#!/usr/bin/env bash
# vim:ft=sh

# Grab command name
export DISTRO="${1:-alpine}"
export DISTRO_VER="${2:-edge}"

export CLI="${3:-limactl shell docker docker}"

limactl shell docker docker run -it --rm -v $PWD:/root/.local/share/chezmoi $DISTRO:$DISTRO_VER sh -c "/root/.local/share/chezmoi/.test/$DISTRO/run.sh"
