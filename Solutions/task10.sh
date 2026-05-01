#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

podman compose -f ./task10.compose up -d

echo "Waiting until everything's started up properly."
sleep 10

curl http://workstation:5000

curl http://workstation:5000

sudo dnf install -y lynx

echo "Cast a vote and test, by visiting http://workstation:5000 with the Lynx browser."

