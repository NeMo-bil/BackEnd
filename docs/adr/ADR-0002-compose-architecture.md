# ADR-0002 Docker Compose Architecture

## Decision

Docker Compose is used only for local development.

The production deployment target is Kubernetes.

Therefore the compose files should resemble the Kubernetes architecture:

- one service = one container
- explicit networks
- health checks
- environment variables
- no development shortcuts