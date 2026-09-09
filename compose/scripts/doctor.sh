#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

ERRORS=0

echo
echo "======================================"
echo "NeMo.bil Environment Check"
echo "======================================"
echo

check_ok() {
    echo "✓ $1"
}

check_error() {
    echo "✗ $1"
    ERRORS=$((ERRORS + 1))
}

#
# Docker installed
#
if command -v docker >/dev/null 2>&1; then
    check_ok "Docker installed"
else
    check_error "Docker is not installed"
fi

#
# Docker daemon
#
if docker info >/dev/null 2>&1; then
    check_ok "Docker daemon is running"
else
    check_error "Docker daemon is not running"
fi

#
# Docker Compose
#
if docker compose version >/dev/null 2>&1; then
    check_ok "Docker Compose available"
else
    check_error "Docker Compose is not available"
fi

#
# Environment file
#
if [ -f "$SCRIPT_DIR/.env" ]; then
    check_ok ".env file found"
else
    check_error ".env file missing"
fi

#
# Required commands
#
for command in curl jq grep; do
    if command -v "$command" >/dev/null 2>&1; then
        check_ok "$command available"
    else
        check_error "$command not found"
    fi
done

echo
echo "======================================"

if [ "$ERRORS" -eq 0 ]; then
    echo "✓ Environment check passed."
    echo "======================================"
    exit 0
else
    echo "✗ Environment check failed ($ERRORS issue(s))."
    echo "======================================"
    exit 1
fi