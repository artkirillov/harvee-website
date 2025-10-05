#!/bin/bash

set -euo pipefail

# Pre-publish helper: run local server, open preview, and walk through a checklist
# Usage: ./pre-publish.sh [--no-serve]

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

NO_SERVE=false
if [ "${1-}" = "--no-serve" ]; then
  NO_SERVE=true
fi

start_server() {
  # If port 4000 busy, use 4001
  PORT=4000
  if lsof -Pi :4000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo -e "${YELLOW}Port 4000 busy, using 4001${NC}"
    PORT=4001
  fi
  echo -e "${BLUE}Starting local server on port ${PORT}...${NC}"
  # Run in background
  (bundle exec jekyll serve --incremental --watch --host 0.0.0.0 --port "$PORT" >/dev/null 2>&1 & echo $! > .jekyll-serve.pid) || true
  sleep 2
  if command -v open >/dev/null 2>&1; then
    open "http://localhost:${PORT}" || true
  fi
  echo -e "Preview: ${GREEN}http://localhost:${PORT}${NC} (PID: $(cat .jekyll-serve.pid 2>/dev/null || echo '?'))"
  echo "To stop later: kill \$(cat .jekyll-serve.pid)"
}

interactive_checklist() {
  declare -A items
  prompts=(
    "Meta description filled (120-155 chars)"
    "Featured image added"
    "Keywords relevant"
    "CTA section included"
    "No placeholder text remaining"
    "Links tested"
    "Mobile responsive checked"
    "Reading time makes sense"
  )

  echo
  echo -e "${BLUE}Pre-publish checklist${NC} (y/n)"
  for p in "${prompts[@]}"; do
    while true; do
      read -r -p "- ${p}? [y/n] " ans || ans="n"
      case "${ans,,}" in
        y|yes) items["$p"]=x; break;;
        n|no)  items["$p"]=; break;;
        *) echo "Please answer y or n.";;
      esac
    done
  done

  echo
  echo -e "${GREEN}Checklist summary (copy to PR/notes):${NC}"
  echo
  echo "- [${items["Meta description filled (120-155 chars)"]:- }] Meta description filled (120-155 chars)"
  echo "- [${items["Featured image added"]:- }] Featured image added"
  echo "- [${items["Keywords relevant"]:- }] Keywords relevant"
  echo "- [${items["CTA section included"]:- }] CTA section included"
  echo "- [${items["No placeholder text remaining"]:- }] No placeholder text remaining"
  echo "- [${items["Links tested"]:- }] Links tested"
  echo "- [${items["Mobile responsive checked"]:- }] Mobile responsive checked"
  echo "- [${items["Reading time makes sense"]:- }] Reading time makes sense"
}

if [ "$NO_SERVE" = false ]; then
  start_server
else
  echo -e "${YELLOW}Skipping local server (--no-serve).${NC}"
fi

interactive_checklist


