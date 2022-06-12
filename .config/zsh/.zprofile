command_not_found_handle() {
	# don't run if not in a container
	if [ ! -e /run/.containerenv ] &&
		[ ! -e /.dockerenv ]; then
		exit 127
	fi

	if command -v flatpak-spawn >/dev/null 2>&1; then
		flatpak-spawn --host "${@}"
	elif command -v host-exec >/dev/null 2>&1; then
		host-exec "$@"
	else
		exit 127
	fi
}

if [ -n "${ZSH_VERSION-}" ]; then
	command_not_found_handler() {
		command_not_found_handle "$@"
	}
fi
