#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

cp -r /peapod ~/
podman unshare chmod +x ~/peapod/pop.sh
dos2unix ~/peapod/pop.sh

podman pod create \
    --name peapod \
    -p 7777:80 \
    -v ~/peapod:/usr/local/apache2/htdocs:z 

podman create \
    --name httpd \
    --restart always \
    --pod peapod \
    docker.io/library/httpd

podman create \
    --name pop \
    --restart always \
    --pod peapod \
    docker.io/library/almalinux:9 /usr/local/apache2/htdocs/pop.sh

podman pod start peapod

sleep 2
echo "First check."
curl http://workstation:7777

sleep 10

echo "Second check."
curl http://workstation:7777


