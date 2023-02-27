#!/usr/bin/env sh
# vim:ft=sh

if [[ $DISTRO_VER == 8* ]]; then
	echo "Fix CentOS 8 repositories URL"
	(sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*) || exit 1
	(sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*) || exit 1
fi

yum update -y && \
	yum install -y sudo bash curl && \
	sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply
