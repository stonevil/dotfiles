#!/usr/bin/env sh
# vim:ft=sh

case "$DISTRO" in
arch)
	echo "Arch Linux. Install bare minimal packages"
	(pacman --noconfirm -Syy && pacman --noconfirm -Syu && pacman --noconfirm --needed -Syu sudo bash curl git) || exit 1
	;;
debain)
	echo "Debian. Install bare minimal packages"
	(apt update -y && apt install -y sudo bash curl git) || exit 1
	;;
fedora)
	echo "Fedora. Install bare minimal packages"
	(dnf update -y && dnf install -y sudo bash curl git) || exit 1
	;;
esac

export CODESPACES=true
export EPHEMERAL=true

export BINDIR="$HOME/.local/bin"
export PATH=$BINDIR:$PATH

sh -c "$(curl -fsLS git.io/chezmoi)"
chezmoi init --promptString email='fu@bar.org',opacity='1.0',shellPath='/bin/zsh' --promptBool dev=true,devops=true,embedded=true,media=true,ads=true --promptInt tabs=2 &&
	chezmoi apply --force

if command -v zsh >/dev/null 2>&1; then
	RPROMPT="$DISTRO/$IMAGE_TAG" zsh
else
	if command -v bash >/dev/null 2>&1; then
		RPROMPT="$DISTRO/$IMAGE_TAG" bash
	else
		RPROMPT="$DISTRO/$IMAGE_TAG" sh
	fi
fi
