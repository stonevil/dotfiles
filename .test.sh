#!/usr/bin/env bash
# vim:ft=sh

_help() {
	# Display Help
	echo "Command syntax:"
	echo -e "./.test.sh [distro] [version]\n"
	echo "Example with Alpine Edge Linux:"
	echo -e "./.test.sh alpine edge\n"
	echo -e "Supported distro: Fedora Linux v39 and newer, Alpine Linux Edge, Debian 12 and newer\n"
}

_check() {
	# Check requirements
	if command -v limactl >/dev/null 2>&1; then
		export CLI="limactl shell podman podman"
	else
		if command -v podman >/dev/null 2>&1; then
			export CLI="podman"
		else
			echo -e "At least limactl or podman should be installed for testing container environments\n"
			exit 1
		fi
	fi
	# Detect if limactl podman is running
	if [[ $OSTYPE == 'darwin'* ]]; then
		if [[ $(limactl list podman --format "{{.Status}}") == "Stopped" ]]; then
			echo -e "limactl podman instance is not running\n"
			exit 1
		fi
	fi
}

export DISTRO=$1

# Detect OS distro and version
case "$DISTRO" in
alpine)
	export IMAGE="$DISTRO"
	export IMAGE_TAG="${2:-3.19}"
	;;
arch)
	export IMAGE_TAG="${2:-latest}"
	if [[ $DISTRO == "arch" ]]; then
		IMAGE="archlinux"
	else
		IMAGE="$DISTRO"
	fi
	;;
debian)
	export IMAGE="$DISTRO"
	export IMAGE_TAG="${2:-latest}"
	;;
fedora)
	export IMAGE="$DISTRO"
	export IMAGE_TAG="${2:-39}"
	;;
help | '--help' | '-h')
	_help
	exit 0
	;;
*)
	export DISTRO="alpine"
	IMAGE="$DISTRO"
	IMAGE_TAG="3.19"
	;;
esac

# Check requirements
_check

# Execute testing environment
echo "Execute container"
${CLI} run -it --rm -v "$PWD":/root/.local/share/chezmoi -e DISTRO="$DISTRO" -e IMAGE_TAG="$IMAGE_TAG" "$IMAGE":"$IMAGE_TAG" sh -c "/root/.local/share/chezmoi/.entrypoint.sh"
