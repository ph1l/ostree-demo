# ostree-demo

roughing out a quick demo to try out ostree for deploying ubuntu

# delta test - adding nethack

    sudo ./make_rootfs.sh
    sudo ./make_rootfs.sh with-app

    sudo ./ostree_commit.sh rootfs/20250504.182708/
    sudo ./ostree_commit.sh rootfs/20250504.183218/

    sudo ./ostree_delta.sh rootfs^ rootfs

    du -sh delta-update-file 
    60K     delta-update-file
