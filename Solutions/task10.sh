#!/bin/sh

podman compose -d -f .\task10.compose up

echo "Waiting until everything's started up properly."
sleep 10

curl http://workstation:5000

curl http://workstation:5000

sudo dnf install -y lynx

echo "Cast a vote and test, by visiting http://workstation:5000 with the Lynx browser."