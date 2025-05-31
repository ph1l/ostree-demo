# ostree-demo

## Intro

This is a prototype outline for building and deploying a debian based OS with
ostree.  For purposes of demonstration, the OS runs from a bootable USB device
on a UEFI capable amd64 machine.  Once a USB device is created and booted, the
OS can be updated using a simple shell script.


## Obtaining prebuilt usb images

Prebuilt usb device images are available here: <https://os.halo.nu/images/>

A gpg signed checksum file is available to verify authenticity.

Download the `.img.gz` and the `.img.bmap` file locally and use bmaptool to
write to a usb device. e.g:

    sudo bmaptool copy ./halo-01-usb-*.img /dev/sdX


## Using the running system

On first boot, the system should re-partition the usb device and grow the root
filesystem for you.

### Login

Login as `root` with the password `guest`

### Connect to the internet

Use network manager on the cli to connect to the internet

    nmtui

### Update

Check for and apply system updates from public ostree repo, hosted at
<https://os.halo.nu/repo-dev/>:

    # halo-upgrade


## Building locally

    $ sudo ./build-os          # build the os in a chroot, tweak it for ostree
    $ sudo ./commit-os         # commit the root filesystem to an ostree build repo
    $ ./publish-repo           # migrate the content to an archive repo
    $ sudo ./generate-usb-img  # build a bootable usb image file
    $ ./sync-repo              # sync the archive repo up to a webserver
