#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "json"
require "rexml/document"
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
PSEO_DIR = File.join(ROOT, "_pseo")
SITE_DIR = File.join(ROOT, "_site")

class ValidationError < StandardError; end

class PseoValidator
  def initialize
    @errors = []
    @documents = Dir[File.join(PSEO_DIR, "*.md")].sort.map { |path| read_document(path) }
  end

  def run
    validate_source_metadata
    validate_rendered_pages
    validate_sitemap

    if @errors.empty?
      puts "pSEO validation passed for #{@documents.length} documents."
      exit 0
    end

    warn "pSEO validation failed:"
    @errors.each { |error| warn "- #{error}" }
    exit 1
  end

  private

  def read_document(path)
    contents = File.read(path)
    match = contents.match(/\A---\s*\n(.*?)\n---\s*\n/m)
    raise ValidationError, "#{relative(path)} does not contain valid YAML front matter" unless match

    data = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: false) || {}
    data = data.transform_keys(&:to_s)
    data["_path"] = path
    data["_name"] = File.basename(path, ".md")
    data
  rescue Psych::Exception => error
    raise ValidationError, "#{relative(path)} has invalid YAML front matter: #{error.message}"
  end

  def validate_source_metadata
    @documents.each do |document|
      required_string(document, "title")
      required_string(document, "description")
      required_string(document, "canonical_url")
      required_string(document, "permalink")
      required_string(document, "axis")
      required_string(document, "problem_headline")

      next unless indexable?(document)

      required_string(document, "reviewed_by")
      required_string(document, "methodology_url")
      require_date(document, "last_modified_at")
      require_date(document, "reviewed_at")
      require_sources(document)
      require_wellness_notice(document)
      validate_review_dates(document)
    end
  rescue ValidationError => error
    @errors << error.message
  end

  def validate_rendered_pages
    @documents.each do |document|
      html_path = output_path(document)
      unless File.exist?(html_path)
        @errors << "#{label(document)} is missing rendered output at #{relative(html_path)}"
        next
      end

      html = File.read(html_path)
      expected_robots = indexable?(document) ? "index, follow" : "noindex, follow"
      robots_values = meta_values(html, "robots")
      if robots_values != [expected_robots]
        @errors << "#{label(document)} should render exactly one robots directive of #{expected_robots.inspect}, found #{robots_values.inspect}"
      end

      canonical_values = canonical_values(html)
      expected_canonical = document.fetch("canonical_url")
      if canonical_values != [expected_canonical]
        @errors << "#{label(document)} should render exactly one canonical URL of #{expected_canonical.inspect}, found #{canonical_values.inspect}"
      end

      h1_count = html.scan(/<h1\b/i).length
      @errors << "#{label(document)} should render exactly one H1, found #{h1_count}" unless h1_count == 1

      validate_methodology_page(document) if indexable?(document)

      json_ld_scripts(html).each_with_index do |json_ld, index|
        JSON.parse(json_ld)
      rescue JSON::ParserError => error
        @errors << "#{label(document)} has invalid JSON-LD script #{index + 1}: #{error.message}"
      end
    end
  end

  def validate_sitemap
    sitemap_path = File.join(SITE_DIR, "sitemap.xml")
    unless File.exist?(sitemap_path)
      @errors << "Rendered sitemap is missing at #{relative(sitemap_path)}"
      return
    end

    sitemap = REXML::Document.new(File.read(sitemap_path))
    entries = {}
    sitemap.root.elements.each("url") do |entry|
      location = entry.elements["loc"]&.text
      entries[location] = entry.elements["lastmod"]&.text if location
    end

    @documents.each do |document|
      canonical_url = document.fetch("canonical_url")
      if indexable?(document)
        expected_date = date_value(document.fetch("last_modified_at")).iso8601
        actual_lastmod = entries[canonical_url]
        if actual_lastmod.nil?
          @errors << "#{label(document)} is approved for indexing but is absent from sitemap.xml"
        elsif !actual_lastmod.start_with?(expected_date)
          @errors << "#{label(document)} sitemap lastmod should begin with #{expected_date.inspect}, found #{actual_lastmod.inspect}"
        end
      elsif entries.key?(canonical_url)
        @errors << "#{label(document)} is not approved for indexing but appears in sitemap.xml"
      end
    end
  rescue REXML::ParseException => error
    @errors << "Rendered sitemap.xml is invalid XML: #{error.message}"
  end

  def required_string(document, field)
    value = document[field]
    return if value.is_a?(String) && !value.strip.empty?

    @errors << "#{label(document)} requires a non-empty #{field}"
  end

  def require_date(document, field)
    value = date_value(document[field])
    if value.nil?
      @errors << "#{label(document)} requires #{field} as an ISO-8601 date"
    elsif value > Date.today
      @errors << "#{label(document)} has a future #{field}"
    end
  end

  def validate_review_dates(document)
    last_modified_at = date_value(document["last_modified_at"])
    reviewed_at = date_value(document["reviewed_at"])
    return if last_modified_at.nil? || reviewed_at.nil?

    if last_modified_at < reviewed_at
      @errors << "#{label(document)} has last_modified_at before reviewed_at; update the content date after review"
    end
  end

  def require_sources(document)
    sources = document["source_urls"]
    unless sources.is_a?(Array) && !sources.empty?
      @errors << "#{label(document)} requires at least one source_urls entry before indexing"
      return
    end

    sources.each do |source|
      uri = URI.parse(source.to_s)
      next if uri.is_a?(URI::HTTPS) && uri.host

      @errors << "#{label(document)} has a non-HTTPS source URL: #{source.inspect}"
    rescue URI::InvalidURIError
      @errors << "#{label(document)} has an invalid source URL: #{source.inspect}"
    end
  end

  def require_wellness_notice(document)
    return if document["medical_disclaimer"] == true

    @errors << "#{label(document)} requires medical_disclaimer: true before indexing"
  end

  def validate_methodology_page(document)
    methodology_url = document["methodology_url"]
    return unless methodology_url.is_a?(String) && !methodology_url.strip.empty?

    unless methodology_url.start_with?("/")
      @errors << "#{label(document)} methodology_url must be a site-relative path"
      return
    end

    methodology_path = File.join(SITE_DIR, methodology_url.sub(%r{\A/}, ""), "index.html")
    unless File.exist?(methodology_path)
      @errors << "#{label(document)} methodology_url does not resolve to rendered output at #{relative(methodology_path)}"
    end
  end

  def output_path(document)
    path = URI.parse(document.fetch("canonical_url")).path
    path = "/" if path.nil? || path.empty?
    File.join(SITE_DIR, path.sub(%r{\A/}, ""), "index.html")
  rescue URI::InvalidURIError
    File.join(SITE_DIR, document.fetch("permalink").sub(%r{\A/}, ""), "index.html")
  end

  def meta_values(html, name)
    html.scan(/<meta\b[^>]*>/i).filter_map do |tag|
      next unless tag.match?(/\bname=["']#{Regexp.escape(name)}["']/i)

      tag[/\bcontent=["']([^"']*)["']/i, 1]
    end
  end

  def canonical_values(html)
    html.scan(/<link\b[^>]*>/i).filter_map do |tag|
      next unless tag.match?(/\brel=["']canonical["']/i)

      tag[/\bhref=["']([^"']*)["']/i, 1]
    end
  end

  def json_ld_scripts(html)
    html.scan(/<script\b[^>]*type=["']application\/ld\+json["'][^>]*>(.*?)<\/script>/im).flatten
  end

  def indexable?(document)
    document["indexable"] == true
  end

  def date_value(value)
    return value if value.is_a?(Date)
    return Date.iso8601(value) if value.is_a?(String)

    nil
  rescue Date::Error
    nil
  end

  def label(document)
    "_pseo/#{document.fetch("_name")}.md"
  end

  def relative(path)
    path.delete_prefix("#{ROOT}/")
  end
end

PseoValidator.new.run
