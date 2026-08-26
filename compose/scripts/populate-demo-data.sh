#!/usr/bin/env bash

set -e

echo
echo "======================================"
echo "Loading demo data..."
echo "======================================"

echo "1"

#
# Obtain OAuth access token
#
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "2"

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