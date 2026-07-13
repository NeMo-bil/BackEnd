.PHONY: help

help:
	@echo "NeMo-bil Backend"
	@echo ""
	@echo "Available commands:"
	@echo "  make compose-up     Start local environment"
	@echo "  make compose-down   Stop local environment"

compose-up:
	cd compose && docker compose up -d

compose-down:
	cd compose && docker compose down