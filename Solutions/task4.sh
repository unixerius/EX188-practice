#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
sudo systemctl --user enable podman-restart
sudo systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

# I can't be arsed to figure out the JQ syntax during an exam. :D
# Basically just grabbing the first tag, that is not "latest".

TAG=$(skopeo list-tags docker://registry.do180.lab:5000/httpd | \
        jq ".Tags[1]" | tr -d \")

echo "Found tag: ${TAG}."

podman run -d \
    --name alp-httpd \
    --restart always \
    -p 8008:80 \
    registry.do180.lab:5000/httpd:${TAG}

curl http://workstation:8008
