#!/usr/bin/env bash

usage() {
	echo "Usage: ${0} [-a <VM CPU architecture: amd64 or arm64>] [-c <CPU core>] [-m <RAM>] [-n <yes/no/restrict>] [-o <yes/no>] [-d <name of .qcow2 image>] [-b <path to block device>] [-i <path to iso image>] [-s <path to shared directory>]" 1>&2
	exit 1
}

a="amd64"
b=""
n="yes"
o="no"
name=""
c="4"
m="8G"
drive=""
i=""
s=""

while getopts ":a:b:c:n:m:d:i:s:o:" z; do
	case "${z}" in
	a)
		a=${OPTARG}
		;;
	b)
		b=${OPTARG}
		;;
	c)
		c=${OPTARG}
		;;
	m)
		m=${OPTARG}
		;;
	d)
		d=${OPTARG}
		drive="${d%.*}"
		name=$(basename "${drive}")
		;;
	n)
		n=${OPTARG}
		;;
	o)
		o=${OPTARG}
		;;
	i)
		i=${OPTARG}
		;;
	s)
		s=${OPTARG}
		;;
	*)
		usage
		;;
	esac
done
shift $((OPTIND - 1))

if [[ -z "${d}" ]]; then
	usage
	exit 1
fi

echo "VM CPU architecture: ${a}"
echo "VM name: ${name}"
echo "CPU cores: ${c}"
echo "Memory: ${m}"
echo "Boot drive: ${drive}.qcow2"
echo "Network: ${n}"
echo "Audio: ${o}"
if [[ ${i} != "" ]]; then
	echo "Installation media: ${i}"
fi
if [[ ${s} != "" ]]; then
	echo "Shared directory: ${s}"
fi

if [[ ! ${a} == @(amd64|arm64) ]]; then
	echo "Incorrect VM CPU architecture. Please use amd64 or arm64"
	exit 1
fi

if [[ ${b} != "" ]] && [[ ! -b "${b}" ]]; then
	echo "${b} absent"
	exit 1
fi

if [[ ! ${n} == @(yes|no|restrict) ]]; then
	n="yes"
fi

if [[ ! ${o} == @(yes|no) ]]; then
	o="no"
fi

if [[ ! -f "${drive}".qcow2 ]]; then
	echo "${drive}.qcow2 absent"
	exit 1
fi

if [[ ${i} != "" ]] && [[ ! -f "${i}" ]]; then
	echo "${i} absent"
	exit 1
fi

if [[ ${s} != "" ]] && [[ ! -d "${s}" ]]; then
	echo "${s} absent"
	exit 1
fi

if [[ ${a} == "amd64" ]]; then
	qemu_command="qemu-system-x86_64"
else
	qemu_command="qemu-system-aarch64"
fi

# TODO
# 1. add arm64 handle -machine type=q35
# 2. -accel hvf
command="-name "${name}" -machine type=q35 -accel tcg -smp ${c} -m ${m} -rtc base=utc,clock=host -device virtio-rng-pci,rng=rng0 -object rng-random,id=rng0,filename=/dev/urandom -chardev qemu-vdagent,id=spice,name=vdagent,clipboard=on -device virtio-serial-pci -device virtserialport,chardev=spice,name=com.redhat.spice.0 -drive file="${drive}".qcow2,format=raw,if=virtio"

installation_command="-boot menu=on -drive file="${i}",media=cdrom"

case "${n}" in
no)
	network_command="-net none"
	;;
restrict)
	network_command="-netdev user,id=mynet0,restrict=y"
	;;
*)
	network_command=""
	;;
esac

shared_command="-virtfs local,path="${s}",mount_tag=host0,security_model=passthrough,id=host0"

block_command="-drive file=${b},format=raw,if=virtio"

if [[ ${o} == "yes" ]]; then
	audio_command="-audiodev coreaudio,id=audio0 -device intel-hda -device hda-micro,audiodev=audio0"
else
	audio_command="-device intel-hda -device hda-output"
fi

video_command="-vga none -device virtio-vga,xres=1280,yres=800 -display cocoa"

usb_command="-device qemu-xhci -device usb-kbd -device usb-tablet"

# daemon_command="-nographic -daemonize &> ${drive}.log"
# -monitor telnet::45454,server,nowait -nographic -serial mon:stdio

# Build command line
if [[ ${i} != "" ]]; then
	command="${installation_command} ${command}"
fi

if [[ ${b} != "" ]]; then
	command="${block_command} ${command}"
fi

if [[ ${s} != "" ]]; then
	command="${shared_command} ${command}"
	echo -e "
	Example how-to mount shared directory in Guest VM:
	sudo mount -t 9p -o trans=virtio,version=9p2000.L shared /mnt/shared
	host0	/shared	9p	trans=virtio,version=9p2000.L	0 0
	"
fi

command="${qemu_command} ${network_command} ${audio_command} ${usb_command} ${video_command} ${command}"

# echo ${command}

# Exacute command
eval "${command}"
