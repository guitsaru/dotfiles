.PHONY: all
all: base rust node elixir

.PHONY: base
base:
	podman build base -t ${USER}/base

.PHONY: rust
rust:
	podman build rust -t ${USER}/rust --build-arg USER=${USER}

.PHONY: node
node:
	podman build node -t ${USER}/node --build-arg USER=${USER}

.PHONY: elixir
elixir:
	podman build elixir -t ${USER}/elixir --build-arg USER=${USER}
