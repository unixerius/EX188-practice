#!/bin/sh

podman unshare << EOF
cat \$(podman image mount centos:9)/etc/os-release
podman image unmount centos:9
exit
EOF