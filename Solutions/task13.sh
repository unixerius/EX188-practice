#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

HttpdImage=$(podman search --filter=is-official httpd | grep "/httpd" | cut -d" " -f1)

podman pull ${HttpdImage}

podman run -d \
    --name runsalways \
    --restart=always \
    -p 9999:80 \
    ${HttpdImage}

sleep 2
curl http://localhost:9999

kill $(podman ps --format "{{.Pid}}" --filter name=runsalways)

sleep 3
curl http://localhost:9999

echo "Now reboot the workstation VM and prove that the container runs."

