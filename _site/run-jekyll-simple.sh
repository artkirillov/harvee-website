#!/bin/bash

# Set up rbenv environment
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Check if port 4000 is already in use
if lsof -Pi :4000 -sTCP:LISTEN -t >/dev/null ; then
    echo "Port 4000 is already in use. Trying port 4001..."
    PORT=4001
else
    PORT=4000
fi

echo "Starting Jekyll server on port $PORT (without live reload)..."
echo "Visit: http://localhost:$PORT"
echo "Blog: http://localhost:$PORT/blog"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Run Jekyll serve with incremental builds and auto-regeneration (no live reload)
bundle exec jekyll serve --incremental --watch --host 0.0.0.0 --port $PORT
