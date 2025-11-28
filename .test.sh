#!/usr/bin/env bash
# vim:ft=sh

distro=$1
tag=$2

podman_instance="podman-intel"

_help() {
	# Display Help
	echo "Command syntax:"
	echo -e "./.test.sh [distro] [version]\n"
	echo "Example with Fedora Linux:"
	echo -e "./.test.sh fedora 43\n"
	echo -e "Supported distro: archlinux, fedora\n"
}

_check() {
	# Detect if limactl podman is running
	if [[ $(limactl list $podman_instance --format "{{.Status}}") == "Stopped" ]]; then
		echo -e "limactl $podman_instance instance is not running\n"
		exit 1
	fi
}

# Detect OS distro and version
case $distro in
arch)
	tag="${tag:-latest}"
	if [[ $distro == "arch" ]]; then
		# distro="menci/archlinuxarm"
		distro="archlinux"
	fi
	;;
fedora)
	tag="${tag:-43}"
	;;
help | '--help' | '-h')
	_help
	exit 0
	;;
*)
	distro="fedora"
	tag="latest"
	;;
esac

# Check requirements
_check

# Execute testing environment
echo "Execute container"
limactl shell $podman_instance podman run -it --rm -v "${PWD}":/chezmoi -e DISTRO=$distro -e IMAGE_TAG=$tag $distro:$tag sh -c "/chezmoi/.entrypoint.sh"
