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

# Find an available port for live reload
LIVERELOAD_PORT=35729
while lsof -Pi :$LIVERELOAD_PORT -sTCP:LISTEN -t >/dev/null 2>&1; do
    LIVERELOAD_PORT=$((LIVERELOAD_PORT + 1))
done

echo "Starting Jekyll server on port $PORT..."
echo "Live reload on port $LIVERELOAD_PORT"
echo "Visit: http://localhost:$PORT"
echo "Blog: http://localhost:$PORT/blog"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Run Jekyll serve with live reload, incremental builds, and auto-regeneration
bundle exec jekyll serve --livereload --livereload-port $LIVERELOAD_PORT --incremental --watch --host 0.0.0.0 --port $PORT
