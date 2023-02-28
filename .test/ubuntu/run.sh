#!/usr/bin/env sh
# vim:ft=sh

apt update -y && \
	apt upgrade -y && \
	apt install -y sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
