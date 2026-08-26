#!/usr/bin/env bash

set -e

########################################
# NeMo.bil Local Startup Script
########################################

echo
echo "======================================"
echo "Starting NeMo.bil Project Setup..."
echo "======================================"



#
# Create default configuration if necessary
#
if [ ! -f .env ]; then
    echo "No .env found."
    echo "Creating .env from .env.example..."
    cp .env.example .env
fi



#
# Create default configuration if necessary
#
echo 
echo "Info about .env file and test-grepping a sample envVar"
echo "Directory with .env file, PWD=$(pwd)"
ls -l .env
echo "envVar MQTT_NODERED_USER extracted from .env: "
grep '^MQTT_NODERED_USER=' .env || echo "grep failed"



# echo
# echo "Step 1/4 - Creating MQTT password..."
# ./scripts/create-mqtt-password.sh

echo
echo "Step 2/4 - Starting Docker containers..."
docker compose up -d

echo
echo "Step 3/4 - Waiting for services..."
./scripts/wait-for-services.sh

echo
echo "Step 4/4 - Populating demo data..."
./scripts/populate-demo-data.sh



#
# Read FRONTEND_DEMO-USER credentials from .env for demo user info
#
FRONTEND_DEMO_USER="$(grep '^FRONTEND_DEMO_USER=' .env | cut -d= -f2-)"
FRONTEND_DEMO_USER_PASSWORD="$(grep '^FRONTEND_DEMO_USER_PASSWORD=' .env | cut -d= -f2-)"

echo
echo "======================================"
echo "NeMo.bil is ready!"
echo "======================================"
echo
echo "Frontend : http://localhost:8080"
echo "FRONTEND_DEMO_USER: app-user-1@test.de"
echo "FRONTEND_DEMO_USER_PASSWORD: Nemobil_User1_2026!"

echo "Keycloak : http://localhost:8080/auth"
echo
echo "IMPORTANT:"
echo "The project is currently using the default configuration from '.env.template'."
echo "For your own installation, please review and adapt the '.env' file"
echo "(passwords, secrets, URLs, API keys, etc.) before productive use."
echo