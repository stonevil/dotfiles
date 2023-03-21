#!/usr/bin/env sh
# vim:ft=sh

case "$DISTRO" in
alpine)
	echo "Alpine. Install bare minimal packages"
	echo "Fix repositories version"
	sed -i 's/v3.\b[0-9]\{2\}\b/edge/g' /etc/apk/repositories || exit 1
	(echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >>/etc/apk/repositories) || exit 1
	(apk update && apk add sudo bash curl) || exit 1
	;;
arch)
	echo "Arch Linux. Install bare minimal packages"
	(pacman --noconfirm -Syy && pacman --noconfirm -Syu && pacman --noconfirm --needed -Syu sudo bash curl) || exit 1
	;;
centos)
	echo "CentOS. Install bare minimal packages"
	# shellcheck disable=SC2081
	if [ "$IMAGE_TAG" = 8* ] || [ "$IMAGE_TAG" = "latest" ]; then
		echo "Fix CentOS 8 repositories URL"
		(sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*) || exit 1
		(sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*) || exit 1
	fi
	(yum update -y && yum install -y sudo bash curl) || exit 1
	;;
fedora)
	echo "Fedora. Install bare minimal packages"
	(dnf update -y && dnf install -y sudo bash curl) || exit 1
	;;
esac

sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --promptString email="fu@bar.org" --promptBool workstation=true --promptInt tabs=2 --promptString opacity="1.0"
sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- apply --force

if command -v zsh >/dev/null; then
	RPROMPT="$DISTRO/$IMAGE_TAG" zsh
else
	if command -v bash >/dev/null; then
		RPROMPT="$DISTRO/$IMAGE_TAG" bash
	else
		RPROMPT="$DISTRO/$IMAGE_TAG" sh
	fi
fi
