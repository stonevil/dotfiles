#!/usr/bin/env bash
# vim:ft=sh

distro=$1
arch=$2

# Display Help
_help() {
	echo "Command syntax:"
	echo -e "./.test.sh [distro]\n"
	echo "Example with Fedora Linux:"
	echo -e "./.test.sh fedora\n"
	echo -e "Supported distro: arch, fedora\n"
}

# Detect OS distro and architecture
case $distro in
arch)
	lima_instance="arch"
	;;
fedora)
	lima_instance="arm64"
	;;
help | '--help' | '-h' | *)
	_help
	exit 0
	;;
esac

if [[ $(limactl list $lima_instance --format "{{.Status}}") == "Running" ]]; then
	read -p "Install $lima_instance is running. Do you want to stop and reset instance? (Y/n): " -n 1 -r REPLY
	if [[ "$REPLY" =~ ^[Yy]$ || "$REPLY" == "" ]]; then
		limactl stop -f $lima_instance && \
		limactl factory-reset $lima_instance
	fi
fi

limactl start $lima_instance

limactl shell $lima_instance mkdir -p /home/${USER}.linux/.local/share
if [[ $distro == "arch" ]]; then
	limactl shell $lima_instance sudo pacman --noconfirm --needed --sync --refresh --sysupgrade rsync
else
	limactl shell $lima_instance sudo dnf install -y rsync
fi
limactl shell $lima_instance rsync --exclude ".git/" --exclude ".stignore" -avz ${PWD}/../chezmoi /home/${USER}.linux/.local/share/ && \
limactl shell $lima_instance /home/${USER}.linux/.local/share/chezmoi/.entrypoint.sh
