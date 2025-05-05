#!/bin/bash -xe

IMAGE_VERSION=$( date +%Y%m%d.%H%M%S )

function unmount_pseudo_filesystems(){
	set +e
	for dir in dev sys proc; do umount -v "$root"/"$dir"; done
	set -e
}

function on_exit(){
	set +e
	unmount_pseudo_filesystems
	umount -v "$root"
}
trap on_exit EXIT

root=rootfs/"$IMAGE_VERSION"

mkdir -p "$root"

# bootstrap the OS

debootstrap noble "$root"

for dir in /proc /sys /dev; do
	mount --bind "$dir" "$root"/"$dir"
done

export DEBIAN_FRONTEND=noninteractive

chroot "$root" locale-gen en_US.UTF-8

chroot "$root" apt-get update

# Install a kernel and bootloader

chroot "$root" apt-get -y --no-install-recommends install linux-generic-hwe-24.04 grub-efi

if [ "$1" == "with-app" ]; then
	# Install an application
	chroot "$root" apt-get update
	chroot "$root" apt-get install -y software-properties-common
	chroot "$root" add-apt-repository -y universe
	chroot "$root" apt-get update
	chroot "$root" apt-get -y install nethack-console
fi


# Cleanup

chroot "$root" apt-get clean

unmount_pseudo_filesystems

rm -rf "$root"/dev/*
rm -rf "$root"/var/lib/apt/lists/*
