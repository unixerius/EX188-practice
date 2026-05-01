#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

mkdir ${HOME}/mywebsite
echo "Welcome to my website." > ${HOME}/mywebsite/index.html

HttpdImage=$(podman search --filter=is-official httpd | grep "/httpd" | cut -d" " -f1)
echo "Found that desired image for httpd is: ${HttpdImage}"

podman pull ${HttpdImage}

DocRoot=$(dirname $(podman run --rm ${HttpdImage} find / -name index.html 2>/dev/null))
echo "Found that document root is: ${DocRoot}"

podman run -d \
    --name mywebsite \
    --restart always \
    -p 8888:80 \
    -v ${HOME}/mywebsite:${DocRoot}:Z \
    ${HttpdImage}

curl http://workstation:8888

