#!/usr/bin/env bash
set -e

echo "Creating Mosquitto password file..."

#
# Verify .env exists
#
if [ ! -f .env ]; then
    echo "ERROR: .env not found."
    exit 1
fi

#
# Read MQTT credentials from .env
#
MQTT_NODERED_USER="$(grep '^MQTT_NODERED_USER=' .env | cut -d= -f2-)"
MQTT_NODERED_PASSWORD="$(grep '^MQTT_NODERED_PASSWORD=' .env | cut -d= -f2-)"

#
# Basic validation
#
if [ -z "$MQTT_NODERED_USER" ]; then
    echo "ERROR: MQTT_NODERED_USER missing in .env"
    exit 1
fi

if [ -z "$MQTT_NODERED_PASSWORD" ]; then
    echo "ERROR: MQTT_NODERED_PASSWORD missing in .env"
    exit 1
fi


docker run --rm \
  -v "$(pwd)/mosquitto/config:/mosquitto/config" \
  eclipse-mosquitto:2.0.22 \
  mosquitto_passwd \
  -c -b \
  /mosquitto/config/passwd \
  "$MQTT_NODERED_USER" \
  "$MQTT_NODERED_PASSWORD"

echo "✓ Mosquitto password file created."