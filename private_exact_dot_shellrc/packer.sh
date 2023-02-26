#!/usr/bin/env bash
# vim:ft=sh :

# Configure packer env
if command -v packer >/dev/null; then
	export PACKER_CACHE_DIR="$HOME"/.packer.d/cache
	export PACKER_ISO_DIR="$HOME"/.packer.d/iso
	export PACKER_BOX_DIR="$HOME"/.packer.d/box
	export PACKER_LOG_PATH="$HOME"/.packer.d/log
fi
