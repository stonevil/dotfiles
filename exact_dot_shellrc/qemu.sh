#!/usr/bin/env bash
# vim:ft=sh :

# https://github.com/knazarov/homebrew-qemu-virgl

if command -v qemu-img >/dev/null; then
	toolbox() {
		ISO_STORAGE_PATH="/Volumes/shared/sl/_soft_/_Linux_"
		DRIVE_STORAGE_PATH="${HOME}/.qemu/drives"

		case "$1" in
		kaiser)
			QEMU_BIN="qemu-system-x86_64"

			VM_NAME="kaiser-toolbox"
			DRIVE_PATH="$DRIVE_STORAGE_PATH/kaiser.qcow2"
			DRIVE_SIZE="40G"
			MEM_SIZE="4G"
			CPU_CORES="2"

			# Create drive if absent
			if [ ! -f "$DRIVE_PATH" ]; then
				qemu-img create -f qcow2 "${DRIVE_PATH}" "${DRIVE_SIZE}"
				ISO_PATH="${ISO_STORAGE_PATH}/xubuntu-21.04-desktop-amd64.iso"
			fi

			NET_CONFIG="-net user,hostfwd=tcp::6122-:22,hostfwd=tcp::6128-:3128,id=nic0,smb=${HOME}/iCloud/Kaiser"
			;;
		*)
			echo "Choose your Destiny, Luke!" && return 1
			;;
		esac

		# -daemonize

		QEMU_CMD="${QEMU_BIN} \
		-name ${VM_NAME} \
		-machine type=q35,accel=hvf \
		-cpu host -smp ${CPU_CORES} -m ${MEM_SIZE} \
		-rtc clock=host,base=localtime \
		-device intel-hda -device hda-output \
		-device virtio-vga-gl \
		-display cocoa,gl=es,show-cursor=on \
		-device qemu-xhci \
		-audiodev id=none,driver=none \
		-device usb-kbd \
		-device usb-tablet \
		-chardev qemu-vdagent,id=spice,name=vdagent,clipboard=on \
		-device virtio-serial-pci \
		-device virtserialport,chardev=spice,name=com.redhat.spice.0 \
		-device virtio-net-pci,netdev=net \
		-netdev user,id=net,ipv6=off \
		-net nic \
		-drive file=${DRIVE_PATH},if=virtio \
		${NET_CONFIG}"

		eval "set -x; ${QEMU_CMD}"
	}
fi
