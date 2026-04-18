#!/bin/sh

cp -r /peapod ~/
podman unshare chmod +x ~/peapod/pop.sh

podman pod create --name peapod -p 7777:80 -v ~/peapod:/usr/local/apache2/htdocs:z 

podman create --pod peapod --name httpd docker.io/library/httpd

podman create --pod peapod --name pop quay.io/centos/centos:9 /usr/local/apache2/htdocs/pop.sh

podman pod start peapod


