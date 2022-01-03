#!/usr/bin/env bash

DRIVE_PATH="$HOME/.qemu/drivers/xubuntu-desktop.qcow2"
DRIVE_SIZE="40G"
DRIVE_CD_CMD=""

# Create drive if absent
if [ ! -f "$DRIVE_PATH" ]; then
	qemu-img create -f qcow2 "$DRIVE_PATH" "$DRIVE_SIZE"
	DRIVE_CD_CMD='-cdrom /Volumes/shared/sl/_soft_/_Linux_/xubuntu-21.04-desktop-amd64.iso'
fi

# Start VM
qemu-system-x86_64 -m 4G -vga virtio -display default,show-cursor=on -usb -device usb-tablet -machine type=q35,accel=hvf -smp 2 -drive file="$DRIVE_PATH",if=virtio -net user,hostfwd=tcp::6161-:22,hostfwd=tcp::6168-:3128,id=nic0,smb="$HOME/iCloud/Kaiser" -net nic -cpu host
