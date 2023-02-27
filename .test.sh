#!/usr/bin/env bash
# vim:ft=sh

export DISTRO=$1

echo "Detect OS distro and version"
case "$DISTRO" in
	alpine) export DISTRO_VER="${2:-3.17}"
	;;
	archlinux) export DISTRO_VER="${2:-latest}"
	;;
	fedora) export DISTRO_VER="${2:-37}"
	;;
	centos) export DISTRO_VER="${2:-latest}"
	;;
	ubuntu|debian) export DISTRO_DIR="debian"; export DISTRO_VER="${2:-latest}"
	;;
	*) export DISTRO="alpine"; DISTRO_DIR="alpine"; DISTRO_VER="3.17"
	;;
esac

echo "Last chance for Blade Runner"
export CLI="${3:-limactl shell docker docker}"

echo "Execute container"
eval "$CLI" run -it --rm -v $PWD:/root/.local/share/chezmoi -e DISTRO=$DISTRO -e DISTRO_VER=$DISTRO_VER -e DISTRO_DIR:$DISTRO_DIR $DISTRO:$DISTRO_VER sh -c "/root/.local/share/chezmoi/.test/$DISTRO_DIR/run.sh"
