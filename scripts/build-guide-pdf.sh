#!/bin/bash
# Build the human-readable PDF guide from the Markdown source.
# Requires Python 3 and the reportlab + Pillow packages.
# Install once with: pip3 install reportlab Pillow

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SOURCE="$PROJECT_ROOT/_GUIDE/Alubys_AI_Dev_System_Guide.md"
PYTHON_SCRIPT="$SCRIPT_DIR/build-guide-pdf.py"

if [ ! -f "$SOURCE" ]; then
  echo "ERROR: Guide source not found: $SOURCE" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "ERROR: python3 is required." >&2
  exit 1
fi

# Check for reportlab
if ! python3 -c "import reportlab" 2>/dev/null; then
  echo "ERROR: reportlab is not installed." >&2
  echo "Install with: pip3 install reportlab Pillow" >&2
  exit 1
fi

echo "Building PDF guide..."
echo "  Source: $SOURCE"

python3 "$PYTHON_SCRIPT"

echo "Done."
