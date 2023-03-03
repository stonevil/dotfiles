#!/usr/bin/env bash
# vim:ft=sh

export DISTRO=$1

echo "Detect OS distro and version"
case "$DISTRO" in
	alpine) export DISTRO_VER="${2:-3.17}"
	;;
	archlinux|centos) export DISTRO_VER="${2:-latest}"
	;;
	fedora) export DISTRO_VER="${2:-37}"
	;;
	*) export DISTRO="alpine"; DISTRO_VER="3.17"
	;;
esac

echo "Last chance for Blade Runner"
export CLI="${3:-limactl shell docker docker}"

echo "Execute container"
eval "$CLI" run -it --rm -v $PWD:/root/.local/share/chezmoi -e DISTRO=$DISTRO -e DISTRO_VER=$DISTRO_VER $DISTRO:$DISTRO_VER sh -c "/root/.local/share/chezmoi/.test_runner.sh"
