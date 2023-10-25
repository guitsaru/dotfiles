.PHONY: all
all: base rust node elixir

.PHONY: base
base:
	podman build base -t ${USER}/base --no-cache

.PHONY: rust
rust:
	podman build rust -t ${USER}/rust --build-arg USER=${USER} --no-cache

.PHONY: node
node:
	podman build node -t ${USER}/node --build-arg USER=${USER} --no-cache

.PHONY: elixir
elixir:
	podman build elixir -t ${USER}/elixir --build-arg USER=${USER} --no-cache

