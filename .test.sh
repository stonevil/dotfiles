#!/usr/bin/env bash
# vim:ft=sh

export DISTRO=$1

echo "Detect OS distro and version"
case "$DISTRO" in
	alpine) export IMAGE="$DISTRO"; export IMAGE_TAG="${2:-3.17}"
		;;
	arch|centos) export IMAGE_TAG="${2:-latest}"
		if [[ DISTRO == "arch" ]]; then
			IMAGE="archlinux"
		else
			IMAGE="$DISTRO"
		fi
		;;
	fedora) export IMAGE="$DISTRO"; export IMAGE_TAG="${2:-37}"
	;;
	*) export DISTRO="alpine"; IMAGE="$DISTRO"; IMAGE_TAG="3.17"
		;;
esac

echo "Last chance for Blade Runner"
export CLI="${3:-limactl shell docker docker}"

echo "Execute container"
eval "$CLI" run -it --rm -v $PWD:/root/.local/share/chezmoi -e DISTRO=$DISTRO -e IMAGE_TAG=$IMAGE_TAG $IMAGE:$IMAGE_TAG sh -c "/root/.local/share/chezmoi/.test_runner.sh"
