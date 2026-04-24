#!/bin/sh

ConfigDir="$HOME/.config/containers/systemd"
mkdir -p ${ConfigDir}

sudo loginctl enable-linger $(whoami)

podman pull ghcr.io/containers/podlet
podman pull docker.io/louislam/uptime-kuma

podman run --rm ghcr.io/containers/podlet \ 
    podman run -d \
    -v kuma-data:/app/data \
    -p 3001:3001 \
    --restart always \
    --name kuma \
    docker.io/louislam/uptime-kuma > ${ConfigDir}/kuma.container

# The following isn't even needed, refer to:
# https://access.redhat.com/solutions/7064507
#cat > ${ConfigDir}/kuma.container <<EOF
#[Install]
#WantedBy=default.target
#EOF

systemctl --user daemon-reload
systemctl --user list-unit-files | grep kuma
systemctl --user start kuma    

curl http://workstation:3001
curl http://workstation:3001/dashboard

