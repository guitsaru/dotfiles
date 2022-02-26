.PHONY: all
all: base rust node elixir

.PHONY: base
base:
	podman-host build base -t ${USER}/base

.PHONY: rust
rust:
	podman-host build rust -t ${USER}/rust --build-arg USER=${USER}

.PHONY: node
node:
	podman-host build node -t ${USER}/node --build-arg USER=${USER}

.PHONY: elixir
elixir:
	podman-host build elixir -t ${USER}/elixir --build-arg USER=${USER}
