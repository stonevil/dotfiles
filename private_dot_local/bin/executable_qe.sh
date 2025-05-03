#!/usr/bin/env bash

usage() {
	echo "Usage: ${0} [-a <VM CPU architecture: amd64 or arm64>] [-c <CPU core>] [-m <RAM>] [-n <yes/no/restrict>] [-d <name of .qcow2 image>] [-i <path to iso image>] [-s <path to shared directory>]" 1>&2
	exit 1
}

a="amd64"
n="yes"
v=""
c="4"
m="8G"
d=""
i=""
s=""

while getopts ":a:c:n:m:d:i:s:" o; do
	case "${o}" in
	a)
		a=${OPTARG}
		;;
	c)
		c=${OPTARG}
		;;
	m)
		m=${OPTARG}
		;;
	d)
		d=${OPTARG}
		b="${d%.*}"
		v=$(basename "${b}")
		;;
	n)
		n=${OPTARG}
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

echo "VM CPU architecture: ${a}"
echo "VM name: ${v}"
echo "CPU cores: ${c}"
echo "Memory: ${m}"
echo "Boot drive: ${b}.qcow2"
echo "Network: ${n}"
if [[ ${i} != "" ]]; then
	echo "Installation media: ${i}"
fi
if [[ ${s} != "" ]]; then
	echo "Shared directory: ${s}"
fi

if [[ -z "${d}" ]]; then
	usage
	exit 1
fi

if [[ ! ${a} == @(amd64|arm64) ]]; then
	echo "Incorrect VM CPU architecture. Please use amd64 or arm64"
	exit 1
fi

if [[ ! ${n} == @(yes|no|restrict) ]]; then
	n="yes"
fi

if [[ ! -f "${b}".qcow2 ]]; then
	echo "${b}.qcow2 absent"
	exit 1
else
	if [[ ${i} != "" ]] && [[ ! -f "${i}" ]]; then
		echo ""${i}" absent"
		exit 1
	fi
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

# TODO add arm64 handle -machine type=q35
command='-name "${v}" -machine type=q35 -accel hvf -accel tcg -smp ${c} -m ${m} -device intel-hda -device hda-output -device qemu-xhci -device usb-kbd -device usb-tablet -chardev qemu-vdagent,id=spice,name=vdagent,clipboard=on -device virtio-serial-pci -device virtserialport,chardev=spice,name=com.redhat.spice.0 -drive file="${b}".qcow2,if=virtio'

installation_command='-boot menu=on -drive file="${i}",media=cdrom'

case "${n}" in
no)
	network_command='-net none'
	;;
restrict)
	network_command='-netdev user,id=mynet0,restrict=y'
	;;
*)
	network_command=""
	;;
esac

shared_command='-virtfs local,path="${s}",mount_tag=host0,security_model=passthrough,id=host0'

command="${network_command} ${command}"

if [[ ${i} != "" ]]; then
	command="${installation_command} ${command}"
fi

if [[ ${s} != "" ]]; then
	command="${shared_command} ${command}"
	echo -e "
	Example how-to mount shared directory in Guest VM:
	sudo mount -t 9p -o trans=virtio,version=9p2000.L shared /mnt/shared
	host0	/shared	9p	trans=virtio,version=9p2000.L	0 0
	"
fi

command="${qemu_command} ${command}"

eval "${command}"
