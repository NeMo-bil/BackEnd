# Local Development Deployment

This directory contains the Docker Compose deployment.

## Requirements

- Docker Desktop
- Docker Compose v2

Supported platforms:

- Windows 11
- macOS
- Linux

## Start up

```bash

# Copy env file and make your edits to the new .env file
cp .env.example .env

docker compose up -d

```

## Stop

```bash

docker compose down

```


## Status

```bash

docker compose ps

```

---

## `compose/.env.example`

```dotenv
# NeMo-bil local deployment configuration

# PostgreSQL
POSTGRES_USER=nemobil
POSTGRES_PASSWORD=change-me

# Keycloak
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=change-me

# OAuth Client
KEYCLOAK_CLIENT_ID=nemobil-app
KEYCLOAK_CLIENT_SECRET=change-me

# Environment
NEMOBIL_ENV=local
