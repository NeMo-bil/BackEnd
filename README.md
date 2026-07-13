# NeMo-bil Backend

Reference backend platform for NGSI-LD mobile applications.

This repository provides a reproducible backend stack based on:

- Keycloak
- APISIX
- Stellio Context Broker
- PostgreSQL
- Kafka

The project supports:

- Docker Compose for local development
- Helm for Kubernetes deployments
- GitOps deployment through App-of-Apps

## Quick Start

See:

[compose/README.md](compose/README.md)

## Architecture

See:

[docs/architecture](docs/architecture)

## Development

See:

[docs/development](docs/development)

## License

Apache License 2.0


## Known local development limitation

The local Docker Compose deployment runs Keycloak over HTTP.

The Keycloak Account Console may show a session iframe warning because
secure cookies require HTTPS.

OAuth2 authentication flows are fully functional and tested.