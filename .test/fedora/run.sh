#!/usr/bin/env sh
# vim:ft=sh

yum update -y && \
	yum install -y sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
