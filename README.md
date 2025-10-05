## Harvee Blog & Site (Jekyll)

Minimal, fast Jekyll setup for `harvee.app` with a blog at `/blog`, full SEO, feeds, and CI deploys.

### Quick Start

```bash
# 1) Install deps (first time)
bundle install

# 2) Run locally (auto-reload)
./run-jekyll-simple.sh
# If 4000 is busy, script uses 4001

# 3) Build (production mode in CI)
./build-jekyll.sh
```

### Common Tasks

- Create new post
  - Using script:
    ```bash
    ./new-post.sh "Why HRV Drops Before Stress"
    # Opens the new file under _posts/YYYY-MM-DD-why-hrv-drops-before-stress.md
    ```
  - Or copy the template:
    ```bash
    cp _drafts/template.md _posts/2025-10-05-your-title.md
    ```

- Preview locally
  ```bash
  ./run-jekyll-simple.sh
  open http://localhost:4000   # or http://localhost:4001
  ```

- Pre-publish checklist (interactive)
  ```bash
  ./pre-publish.sh
  # (Starts local server if needed, opens browser, asks y/n checks)
  ```

- Check SEO for a post
  ```bash
  ./check-seo.sh _posts/2025-01-27-understanding-hrv-stress-recovery.md
  # Color output with pass/warn/fail and specific feedback
  ```

- Publish (deploy)
  ```bash
  git add -A && git commit -m "Post: new article" && git push origin main
  # GitHub Actions builds and deploys to GitHub Pages automatically
  ```

- Update dependencies
  ```bash
  bundle update
  ```

### Folder Structure

```
.
├── _config.yml               # Site config, URLs, plugins, analytics, defaults
├── _layouts/                 # Base HTML layouts (default, blog, post)
├── _includes/                # Reusable snippets (seo, schema, analytics, etc.)
├── _posts/                   # Blog posts (YYYY-MM-DD-title.md)
├── _drafts/                  # Drafts & templates (not published)
├── blog/                     # Blog index, feeds (feed.xml, atom.xml)
├── assets/css/blog.css       # Single source of truth for blog typography/layout
├── files/                    # Shared site CSS/JS used by main pages
├── images/                   # Images & favicons
├── robots.txt                # Robots & sitemap reference
├── sitemap.xml               # Custom sitemap (posts/pages/blog)
├── index.html                # Marketing homepage (non-Jekyll page)
├── scripts:                  # Helper scripts
│   ├── run-jekyll.sh, run-jekyll-simple.sh, build-jekyll.sh
│   ├── new-post.sh, check-seo.sh, pre-publish.sh
└── .github/workflows/deploy.yml  # CI build & deploy to GitHub Pages
```

### Frontmatter Guide

Each post lives in `_posts/` and includes SEO-ready frontmatter.

```yaml
---
layout: post                      # Always "post"
title: "Understanding HRV Trends" # ~50–60 chars
description: "Compelling meta description under 155 chars." # 120–155 chars
date: 2025-10-05                  # YYYY-MM-DD
author: "Artie"                   # Defaults to site.author.name
keywords: ["hrv", "stress", "recovery"]
image: "/images/featured-hrv.jpg" # 1200x630 recommended
canonical_url: "https://harvee.app/blog/understanding-hrv-trends"
tags: ["health", "hrv"]
show_reading_time: true
published: true
---
```

Tips:
- Keep titles concise and descriptive (<= 60 chars).
- Always include a strong description (120–155 chars).
- Use at least 3 focused keywords.
- Point `image` to a real local file in `/images/`.

### Markdown Tips (for this setup)

- Headings: One H1 (the post title), then use `##` and `###` for structure.
- Links: Prefer relative links within the site; check them with `./check-seo.sh`.
- Images: Place in `/images/`, use descriptive alt text: `![Tracking HRV](/images/graph.png)`.
- Code blocks: Standard fenced blocks; optional copy button styling is available via `.copy-button` if you add JS.
- CTA: Close with the “Read Between the Beats with Harvee” CTA section from the template.

### SEO, Feeds, and Analytics

- Feeds: RSS at `/blog/feed.xml`, Atom at `/blog/atom.xml` (full content, author, dates).
- Sitemap: `/sitemap.xml` includes homepage, blog index, posts, and pages with `lastmod`, priorities.
- Robots: `robots.txt` allows crawling and references the sitemap.
- Analytics & GSC: `_includes/analytics.html` reads values from `_config.yml` and loads only in production (`JEKYLL_ENV=production`).
  - Set in `_config.yml`:
    ```yaml
    google_analytics: "G-7VD9JRQVGR"
    google_site_verification: "prtEYsT9vqrzuqVht0Dop6DX382az0CO8GHqONa3iU8"
    ```

### Troubleshooting

- Port already in use
  - Use `./run-jekyll-simple.sh` (falls back to 4001) or kill the process on 4000.

- Live reload port conflict
  - Use `./run-jekyll-simple.sh` (no livereload) or `./run-jekyll.sh` which finds a free port.

- Posts not showing / wrong URLs
  - Ensure `_config.yml` has `permalink: /blog/:title` and filenames follow `YYYY-MM-DD-title.md`.

- Reading time mismatch
  - Reading time include prioritizes `post.content`; ensure it’s included in loops with `{% include reading-time.html %}`.

- Feeds/Sitemap validation
  - RSS/Atom: validate with `https://validator.w3.org/feed/`
  - Sitemap: validate with Google Search Console (after deploy).

- CI deploy fails
  - Check `.github/workflows/deploy.yml` logs. Ensure `bundle install` succeeds and `_site` is generated.

### Scripts

- `run-jekyll.sh` – serve with livereload, incremental builds, auto-regeneration; finds free ports.
- `run-jekyll-simple.sh` – simpler serve without livereload; robust for conflicts.
- `build-jekyll.sh` – production build (`bundle exec jekyll build --incremental`).
- `new-post.sh` – scaffold a new post with correct filename and frontmatter.
- `check-seo.sh` – verify meta/title/keywords/image/H2/wordcount/links/frontmatter.
- `pre-publish.sh` – start server and run an interactive publishing checklist.


