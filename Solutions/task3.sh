#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

skopeo list-tags docker://registry.do180.lab:5000/mariadb

podman pull registry.do180.lab:5000/mariadb:latest

podman run -d \
    --name testql \
    --restart always \
    -p 3306:3306 \
    -e MYSQL_USER="duffman" \
    -e MYSQL_PASSWORD="saysoyeah" \
    -e MYSQL_ROOT_PASSWORD="SQLp4ss" \
    -e MYSQL_DATABASE="beer" \
    registry.do180.lab:5000/mariadb:latest

echo "Waiting for MySQL startup."
sleep 5

echo "Showing DB"
echo "show databases;" | mysql -uduffman -psaysoyeah -h workstation

echo "Loading DB"
mysql -uroot -pSQLp4ss -h workstation < /sql/beer.sql

echo "Querying DB"
echo 'select * from types' | mysql -uduffman -psaysoyeah -h workstation beer

