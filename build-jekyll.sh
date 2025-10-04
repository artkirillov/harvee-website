#!/bin/bash

# Set up rbenv environment
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Build Jekyll site with incremental builds for faster production builds
bundle exec jekyll build --incremental
