#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

ConfigDir="$HOME/.config/containers/systemd"
mkdir -p ${ConfigDir} 2>/dev/null
rm ${ConfigDir}/kuma.container 2>/dev/null
systemctl --user daemon-reload

podman pull ghcr.io/containers/podlet
podman pull docker.io/louislam/uptime-kuma

podman run --rm ghcr.io/containers/podlet podman run -d \
    --name kuma \
    --restart always \
    -v kuma-data:/app/data \
    -p 3001:3001 \
    docker.io/louislam/uptime-kuma > ${ConfigDir}/kuma.container

systemctl --user daemon-reload
systemctl --user list-unit-files | grep kuma
systemctl --user restart kuma    

sleep 10
curl http://workstation:3001
curl http://workstation:3001/dashboard

