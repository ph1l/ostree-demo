#!/bin/bash -xe

ROOTFS_DIR=$1

[ ! -d repo ] && \
	ostree --repo=repo init

ostree --repo=repo commit --branch=rootfs "$ROOTFS_DIR"
