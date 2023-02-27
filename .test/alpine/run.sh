#!/usr/bin/env sh
# vim:ft=sh

if [[ $DISTRO_VER == "edge" ]]; then
	sed -i 's/v3.\b[0-9]\{2\}\b/edge/g' /etc/apk/repositories || exit 1
else
	sed -i "s/v3.\b[0-9]\{2\}\b/v$DISTRO_VER/g" /etc/apk/repositories || exit 1
fi

(echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories) || exit 1

apk update && \
	apk add sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
