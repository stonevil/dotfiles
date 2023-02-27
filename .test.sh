#!/usr/bin/env bash
# vim:ft=sh

# Grab command name
case "$DISTRO" in
	ubuntu|debian) export DISTRO="debian"
	;;
	*) export DISTRO="${1:-alpine}"
	;;
esac

case "$DISTRO" in
	alpine) export DISTRO_VER="${2:-3.17}"
	;;
	fedora) export DISTRO_VER="${2:-37}"
	;;
	*) export DISTRO_VER="${2:-latest}"
	;;
esac

export CLI="${3:-limactl shell docker docker}"

eval "$CLI" run -it --rm -v $PWD:/root/.local/share/chezmoi -e DISTRO=$DISTRO -e DISTRO_VER=$DISTRO_VER $DISTRO:$DISTRO_VER sh -c "/root/.local/share/chezmoi/.test/$DISTRO/run.sh"
