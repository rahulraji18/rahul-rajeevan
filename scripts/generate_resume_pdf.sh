#!/usr/bin/env bash
# Generate public/resume.pdf from public/resume.html using headless Chrome or wkhtmltopdf
# Usage: ./scripts/generate_resume_pdf.sh
set -e
OUT="$(pwd)/public/resume.pdf"
HTML="$(pwd)/public/resume.html"

if command -v google-chrome >/dev/null 2>&1; then
  CHROME=google-chrome
elif command -v google-chrome-stable >/dev/null 2>&1; then
  CHROME=google-chrome-stable
elif command -v chromium >/dev/null 2>&1; then
  CHROME=chromium
elif command -v chromium-browser >/dev/null 2>&1; then
  CHROME=chromium-browser
fi

if [ -n "$CHROME" ]; then
  echo "Using $CHROME to render PDF..."
  "$CHROME" --headless --disable-gpu --print-to-pdf="$OUT" "file://$HTML"
  echo "Saved $OUT"
  exit 0
fi

if command -v wkhtmltopdf >/dev/null 2>&1; then
  echo "Using wkhtmltopdf to render PDF..."
  wkhtmltopdf "$HTML" "$OUT"
  echo "Saved $OUT"
  exit 0
fi

echo "No supported PDF generator found. Install Google Chrome/Chromium or wkhtmltopdf and re-run this script." >&2
exit 2
