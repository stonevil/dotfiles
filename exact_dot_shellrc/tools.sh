#!/usr/bin/env bash
# vim:ft=sh :

if command -v hdiutil >/dev/null; then
	f2iso() {
		hdiutil makehybrid -iso -joliet -o "$(basename $@)".iso "$@" && echo "$(basename $@).iso image created"
	}
fi
