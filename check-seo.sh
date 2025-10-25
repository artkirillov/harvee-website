#!/bin/bash

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

pass() { echo -e "${GREEN}PASS${NC} - $1"; PASS_COUNT=$((PASS_COUNT+1)); }
warn() { echo -e "${YELLOW}WARN${NC} - $1"; WARN_COUNT=$((WARN_COUNT+1)); }
fail() { echo -e "${RED}FAIL${NC} - $1"; FAIL_COUNT=$((FAIL_COUNT+1)); }

usage() {
  echo "Usage: ./check-seo.sh PATH_TO_POST.md"
}

if [ "${1-}" = "" ]; then
  usage
  exit 1
fi

POST_FILE="$1"
if [ ! -f "$POST_FILE" ]; then
  echo "File not found: $POST_FILE"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
POST_DIR="$(cd "$(dirname "$POST_FILE")" && pwd)"

echo -e "${BLUE}Checking:${NC} $POST_FILE"

# Extract frontmatter block and content
FRONTMATTER=$(awk 'BEGIN{inY=0} /^---\s*$/{c++; if(c==1){inY=1; next} else if(c==2){inY=0}} inY==1{print}' "$POST_FILE" || true)

if [ -z "$FRONTMATTER" ]; then
  fail "Frontmatter not found between '---' markers"
else
  pass "Frontmatter present"
fi

# Title check (< 60 chars)
TITLE=$(printf "%s\n" "$FRONTMATTER" | awk -F": *" '/^title:/ {sub(/^"|"$/,"",$2); print $2; exit}')
if [ -z "${TITLE}" ]; then
  fail "Title missing in frontmatter (title:)"
else
  TITLE_LEN=${#TITLE}
  if [ $TITLE_LEN -gt 60 ]; then
    fail "Title is ${TITLE_LEN} chars (should be <= 60)"
  else
    pass "Title present (${TITLE_LEN} chars)"
  fi
fi

# Description check (120-155 chars)
DESCRIPTION=$(printf "%s\n" "$FRONTMATTER" | awk -F": *" '/^description:/ {sub(/^"|"$/,"",$2); print $2; exit}')
if [ -z "${DESCRIPTION}" ]; then
  fail "Meta description missing (description:)"
else
  DESC_LEN=${#DESCRIPTION}
  if [ $DESC_LEN -lt 120 ]; then
    warn "Description is ${DESC_LEN} chars (recommended 120-155)"
  elif [ $DESC_LEN -gt 155 ]; then
    fail "Description is ${DESC_LEN} chars (must be <= 155)"
  else
    pass "Description length ${DESC_LEN} chars"
  fi
fi

# Keywords count >= 3 (supports inline [a,b] or list)
KEYWORDS_BLOCK=$(printf "%s\n" "$FRONTMATTER" | awk '/^keywords:/,/^[^[:space:]-]/' || true)
KEYWORDS_INLINE=$(printf "%s\n" "$KEYWORDS_BLOCK" | awk -F": *" 'NR==1{print $2}')
KEYCOUNT=0
if printf "%s" "$KEYWORDS_INLINE" | grep -q '\['; then
  KEYCOUNT=$(printf "%s" "$KEYWORDS_INLINE" | sed -E 's/\[|\]|"//g; s/,/ /g' | wc -w | tr -d ' ')
else
  KEYCOUNT=$(printf "%s\n" "$KEYWORDS_BLOCK" | awk '/^-/{c++} END{print c+0}')
fi
if [ "$KEYCOUNT" -ge 3 ]; then
  pass "Keywords count: $KEYCOUNT"
else
  fail "At least 3 keywords required (found $KEYCOUNT)"
fi

# Featured image path exists
IMAGE=$(printf "%s\n" "$FRONTMATTER" | awk -F": *" '/^image:/ {gsub(/^"|"$/,"",$2); print $2; exit}')
if [ -z "$IMAGE" ]; then
  fail "Featured image path missing (image:)"
else
  if printf "%s" "$IMAGE" | grep -Eq '^(http|https)://'; then
    warn "Image is a URL; local path recommended for build-time validation"
    pass "Image provided (URL)"
  else
    # Normalize path
    if printf "%s" "$IMAGE" | grep -q '^/'; then
      IMG_PATH="$REPO_ROOT$IMAGE"
    else
      IMG_PATH="$POST_DIR/$IMAGE"
    fi
    if [ -f "$IMG_PATH" ]; then
      pass "Featured image exists: $IMAGE"
    else
      fail "Featured image not found at: $IMAGE"
    fi
  fi
fi

# Content (after frontmatter)
CONTENT=$(awk 'BEGIN{c=0} /^---\s*$/{c++; next} c>=2{print}' "$POST_FILE" || true)

# H2 heading check
H2_COUNT=$(printf "%s\n" "$CONTENT" | grep -E '^##[[:space:]]+' | wc -l | tr -d ' ' || true)
if [ "${H2_COUNT:-0}" -ge 1 ]; then
  pass "H2 sections found: $H2_COUNT"
else
  fail "At least one H2 (##) heading required"
fi

# Word count (simple; markdown retained)
WORD_COUNT=$(printf "%s\n" "$CONTENT" | wc -w | tr -d ' ')
if [ "$WORD_COUNT" -ge 800 ]; then
  pass "Word count: $WORD_COUNT"
else
  warn "Word count is $WORD_COUNT (< 800). Consider expanding."
fi

# Broken internal links
LINK_FAILS=0
while IFS= read -r url; do
  # Skip empty
  [ -z "$url" ] && continue
  # Strip anchors and queries
  baseurl=$(printf "%s" "$url" | sed 's/[?#].*$//')
  # External links -> skip
  if printf "%s" "$baseurl" | grep -Eq '^(http|https)://'; then
    continue
  fi
  CANDIDATE=""
  if printf "%s" "$baseurl" | grep -q '^/'; then
    CANDIDATE="$REPO_ROOT$baseurl"
  else
    CANDIDATE="$POST_DIR/$baseurl"
  fi
  if [ -d "$CANDIDATE" ] || [ -f "$CANDIDATE" ]; then
    : # ok
  else
    # Also try with trailing index.html for directories
    if [ -d "$CANDIDATE" ] && [ -f "$CANDIDATE/index.html" ]; then
      :
    else
      fail "Broken internal link: $url"
      LINK_FAILS=$((LINK_FAILS+1))
    fi
  fi
done < <(printf "%s\n" "$CONTENT" | sed -n 's/.*\[[^]]*\](\([^)]\+\)).*/\1/p')

if [ "$LINK_FAILS" -eq 0 ]; then
  pass "No broken internal links detected"
fi

# Frontmatter format sanity (basic YAML: keys present)
REQ_KEYS=(layout title description date author keywords image canonical_url)
for k in "${REQ_KEYS[@]}"; do
  if printf "%s\n" "$FRONTMATTER" | grep -q "^$k:"; then
    :
  else
    fail "Frontmatter missing required key: $k"
  fi
done

echo
echo -e "${BLUE}Summary:${NC} ${GREEN}${PASS_COUNT} pass${NC}, ${YELLOW}${WARN_COUNT} warn${NC}, ${RED}${FAIL_COUNT} fail${NC}"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 2
elif [ "$WARN_COUNT" -gt 0 ]; then
  exit 0
else
  exit 0
fi


