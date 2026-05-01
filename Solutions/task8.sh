#!/bin/bash

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

echo -n "duffman" > ~/mysql_user               # alternatively, use printf
echo -n "saysoyeah" > ~/mysql_password
echo -n "SQLp4ss" > ~/mysql_root_password
echo -n "beer" > ~/mysql_database

podman secret create -d=file mysql_user ~/mysql_user
podman secret create -d=file mysql_password ~/mysql_password
podman secret create -d=file mysql_root_password ~/mysql_root_password
podman secret create -d=file mysql_database ~/mysql_database

podman run -d \
    --name secretsdb \
    --restart always \
    -p 3307:3306 \
    --secret mysql_user,type=env,target=MYSQL_USER \
    --secret mysql_password,type=env,target=MYSQL_PASSWORD \
    --secret mysql_root_password,type=env,target=MYSQL_ROOT_PASSWORD \
    --secret mysql_database,type=env,target=MYSQL_DATABASE \
    registry:5000/mariadb

echo "Waiting for MySQL to come online."
sleep 5

echo "Showing DB"
echo "show databases;" | mysql -uduffman -psaysoyeah -h workstation -P 3307

echo "Loading DB"
mysql -uroot -pSQLp4ss -h workstation -P 3307 < /sql/beer.sql

echo "Querying DB"
echo 'select * from types' | mysql -uduffman -psaysoyeah -h workstation -P 3307 beer
