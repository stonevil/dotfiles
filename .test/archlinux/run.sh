#!/usr/bin/env sh
# vim:ft=sh

 pacman --noconfirm -Syy && pacman --noconfirm -Syu && \
	pacman --noconfirm --needed -Syu sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
