#!/bin/sh
# Heavily inspired by https://giacomo.coletto.io/blog/podman-quadlets/
#

sudo loginctl enable-linger $(whoami) 

ConfigDir="$HOME/.config/containers/systemd"
mkdir -p ${ConfigDir}

cat > ${ConfigDir}/kuma.container << EOF
[Container]
ContainerName=kuma
Image=docker.io/louislam/uptime-kuma
PublishPort=3001:3001
Volume=kuma-data/app/data

[Service]
Restart=always

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user list-unit-files | grep kuma
systemctl --user start kuma

curl http://workstation:3001
curl http://workstation:3001/dashboard


