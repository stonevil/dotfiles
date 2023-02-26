#!/usr/bin/env sh
# vim:ft=sh

(echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories) || exit 1

sed -i 's/v3.\b[0-9]\{2\}\b/edge/g' /etc/apk/repositories || exit 1

apk update && \
	apk add sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
