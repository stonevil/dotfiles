#!/usr/bin/env sh
# vim:ft=sh

apk update && \
	apk add sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
