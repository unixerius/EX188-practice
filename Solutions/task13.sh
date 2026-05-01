#!/bin/sh

sudo loginctl enable-linger $(whoami)
sudo systemctl enable podman-restart
sudo systemctl start podman-restart
systemctl --user enable podman-restart
systemctl --user start podman-restart

HttpdImage=$(podman search --filter=is-official httpd | grep "/httpd" | cut -d" " -f1)

podman pull ${HttpdImage}

podman run -d \
    --name runsalways \
    --restart=always \
    -p 9999:80 \
    ${HttpdImage}

curl http://localhost:9999

kill $(podman ps --format "{{.Pid}}" --filter name=runsalways)

curl http://localhost:9999

echo "Now reboot the workstation VM and prove that the container runs."

