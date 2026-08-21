#!/usr/bin/env bash

set -e

########################################
# Get Stellio Service Account Token
########################################

#
# Verify .env exists
#
if [ ! -f .env ]; then
    echo "ERROR: .env not found."
    exit 1
fi

#
# Read configuration from .env
#
KEYCLOAK_REALM="$(grep '^KEYCLOAK_REALM=' .env | cut -d= -f2-)"
KEYCLOAK_CLIENT_ID="$(grep '^KEYCLOAK_CLIENT_ID=' .env | cut -d= -f2-)"
KEYCLOAK_CLIENT_SECRET="$(grep '^KEYCLOAK_CLIENT_SECRET=' .env | cut -d= -f2-)"
KEYCLOAK_SERVICE_ACCOUNT_USER="$(grep '^KEYCLOAK_SERVICE_ACCOUNT_USER=' .env | cut -d= -f2-)"
KEYCLOAK_SERVICE_ACCOUNT_PASSWORD="$(grep '^KEYCLOAK_SERVICE_ACCOUNT_PASSWORD=' .env | cut -d= -f2-)"

#
# Request access token
#
ACCESS_TOKEN=$(
curl -s -X POST \
    "http://localhost:8080/auth/realms/${KEYCLOAK_REALM}/protocol/openid-connect/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "scope=api:read api:write api:delete" \
    --data-urlencode "grant_type=password" \
    --data-urlencode "client_id=${KEYCLOAK_CLIENT_ID}" \
    --data-urlencode "client_secret=${KEYCLOAK_CLIENT_SECRET}" \
    --data-urlencode "username=${KEYCLOAK_SERVICE_ACCOUNT_USER}" \
    --data-urlencode "password=${KEYCLOAK_SERVICE_ACCOUNT_PASSWORD}" \
| jq -r '.access_token'
)

#
# Verify success
#
if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" = "null" ]; then
    echo "ERROR: Failed to obtain access token."
    exit 1
fi

echo "$ACCESS_TOKEN"