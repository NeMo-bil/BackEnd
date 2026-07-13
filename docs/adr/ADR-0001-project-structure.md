# ADR-0001 Project Structure

## Status

Accepted

## Context

NeMo-bil integrates several mature open-source projects including:

- Keycloak
- Stellio Context Broker
- PostgreSQL
- Apache Kafka

The goal is to avoid maintaining forks of upstream projects.

## Decision

The repository contains only NeMo-bil specific assets.

Third-party software is consumed as released artifacts
(Docker images, Helm charts, Maven artifacts).

No upstream source code is copied into this repository.

## Consequences

- Easier upgrades
- Smaller repository
- Clear ownership
- Less maintenance