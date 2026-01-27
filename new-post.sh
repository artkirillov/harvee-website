#!/bin/bash

set -euo pipefail

# Usage: ./new-post.sh "Your Post Title"

# --- Helpers ---
slugify() {
  # Lowercase, replace non-alphanumerics with hyphens, collapse hyphens, trim
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/-+/-/g; s/^-|-$//g'
}

# --- Validations ---
if [ "${1-}" = "" ]; then
  echo "Error: Missing post title."
  echo "Usage: ./new-post.sh \"Why HRV Drops Before Stress\""
  exit 1
fi

TITLE="$1"
TODAY=$(date +%Y-%m-%d)
SLUG=$(slugify "$TITLE")
FILENAME="${TODAY}-${SLUG}.md"
POSTS_DIR="_posts"
TARGET_PATH="${POSTS_DIR}/${FILENAME}"

# Ensure _posts exists
if [ ! -d "$POSTS_DIR" ]; then
  mkdir -p "$POSTS_DIR"
fi

# Guard if file exists
if [ -e "$TARGET_PATH" ]; then
  echo "Error: ${TARGET_PATH} already exists. Choose a different title or delete the file."
  exit 1
fi

# --- Create file content ---
cat > "$TARGET_PATH" <<EOF
---
layout: post
title: "$TITLE"
description: "" # TODO: Add a compelling meta description under 155 chars
date: $TODAY
author: "Artie"
keywords: [] # e.g. ["hrv", "stress", "recovery"]
image: "/images/your-featured-image.jpg" # 1200x630 recommended
canonical_url: "https://harvee.app/blog/${SLUG}"
show_reading_time: true
tags: []
---

<!-- Hook paragraph: briefly state the problem and the value readers will get. -->

## Understanding the Core Idea

Explain the main concept clearly. Provide context and why it matters.

### Key Points

- Point 1
- Point 2
- Point 3

## Practical Guidance

Offer actionable steps or a simple framework readers can follow.

### Steps

1. Step one
2. Step two
3. Step three

---

## Read Between the Beats with Harvee

Ready to take your health monitoring to the next level? **Harvee: Stress Monitor & Recovery Companion** helps you track heart rate variability, understand stress patterns, and optimize recovery.

[Download Harvee on the App Store](https://apps.apple.com/app/apple-store/id6746194884?pt=126794358&ct=harvee-website&mt=8)
EOF

echo "Created: ${TARGET_PATH}"

# Try to open in default editor if available
if command -v open >/dev/null 2>&1; then
  open "$TARGET_PATH" >/dev/null 2>&1 || true
elif [ -n "${EDITOR-}" ]; then
  "$EDITOR" "$TARGET_PATH" || true
fi


