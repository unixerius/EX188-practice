#!/bin/sh

podman unshare << EOF
cat \$(podman image mount docker.io/library/almalinux:9)/etc/os-release
podman image unmount docker.io/library/almalinux:9
exit
EOF