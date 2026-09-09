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

NEMOBIL_NGSI_JSON_LD_CONTEXT="$(
    grep '^NEMOBIL_NGSI_JSON_LD_CONTEXT=' "$PROJECT_DIR/.env" | cut -d= -f2-
)"

APPLICATION_TENANTS_0_NAME="$(
    grep '^APPLICATION_TENANTS_0_NAME=' "$PROJECT_DIR/.env" | cut -d= -f2-
)"

export NEMOBIL_NGSI_JSON_LD_CONTEXT
export APPLICATION_TENANTS_0_NAME

if [ -z "$NEMOBIL_NGSI_JSON_LD_CONTEXT" ]; then
    echo "ERROR: NEMOBIL_NGSI_JSON_LD_CONTEXT missing in .env"
    exit 1
fi

if [ -z "$APPLICATION_TENANTS_0_NAME" ]; then
    echo "ERROR: APPLICATION_TENANTS_0_NAME missing in .env"
    exit 1
fi

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
    
    if [ "$HTTP_CODE" -eq 201 ]; then
        echo "✓ Subscription created (HTTP $HTTP_CODE)" 
    else
        echo "✗ Failed to create subscription (HTTP $HTTP_CODE)"
        exit 1
    fi
done

echo
echo "======================================"
echo "✓ Demo data successfully imported."
echo "======================================"