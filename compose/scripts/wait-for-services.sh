#!/usr/bin/env bash

set -e

########################################
# Wait until NeMo.bil is ready
########################################

URL="http://localhost:8080"
TIMEOUT=300
INTERVAL=2

echo
echo "======================================"
echo "Waiting for NeMo.bil startup..."
echo "======================================"

elapsed=0

printf "Frontend "

while ! curl -fs "$URL" >/dev/null 2>&1
do
    if [ "$elapsed" -ge "$TIMEOUT" ]; then
        echo
        echo
        echo "ERROR: Startup timeout after ${TIMEOUT} seconds."
        echo
        echo "The frontend is still not reachable:"
        echo "  $URL"
        echo
        echo "Please inspect the containers:"
        echo "  docker compose ps"
        echo "  docker compose logs"
        exit 1
    fi

    printf "."
    sleep "$INTERVAL"
    elapsed=$((elapsed + INTERVAL))
done

echo " OK"

echo
echo "======================================"
echo "NeMo.bil is ready!"
echo "======================================"
echo
echo "Frontend : http://localhost:8080"
echo "Keycloak : http://localhost:8080/auth"
echo