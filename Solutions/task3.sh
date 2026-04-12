#!/bin/sh

skopeo list-tags docker://registry.do180.lab:5000/mariadb

podman pull registry.do180.lab:5000/mariadb:latest

podman run -d \
        --name testql \
        -p 3306:3306 \
        -e MYSQL_USER="duffman" \
        -e MYSQL_PASSWORD="saysoyeah" \
        -e MYSQL_ROOT_PASSWORD="SQLp4ss" \
        -e MYSQL_DATABASE="beer" \
        registry.do180.lab:5000/mariadb:latest

echo "show databases;" | mysql -uduffman -psaysoyeah -h workstation

mysql -uroot -pSQLp4ss -h workstation < /sql/beer.sql

echo 'select * from types' | mysql -uduffman -psaysoyeah -h workstation beer

