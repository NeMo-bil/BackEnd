#!/usr/bin/env bash

set -e

echo
echo "======================================"
echo "Loading demo data..."
echo "======================================"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

#
# Load environment variables
#
if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo "ERROR: .env not found: $PROJECT_DIR/.env"
    exit 1
fi

set -a
source "$PROJECT_DIR/.env"
set +a

#
# Obtain OAuth access token
#
ACCESS_TOKEN=$("$SCRIPT_DIR/get-token.sh")

echo
echo "ACCESS_TOKEN (80 Characters only):"
echo "${ACCESS_TOKEN:0:80}..."
echo

export ACCESS_TOKEN

#
# Execute all demo-data scripts
#
for script in "$(dirname "$0")"/demo-data/*.sh
do
    echo
    echo "Running $(basename "$script")..."
    bash "$script"
done

echo
echo "======================================"
echo "✓ Demo data successfully imported."
echo "======================================"