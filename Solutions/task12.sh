#!/bin/sh

mkdir ${HOME}/mywebsite
echo "Welcome to my website." > ${HOME}/mywebsite/index.html

HttpdImage=$(podman search --filter=is-official httpd | grep "/httpd" | cut -d" " -f1)
echo "Found that desired image for httpd is: ${HttpdImage}"

podman pull ${HttpdImage}

DocRoot=$(dirname $(podman run ${HttpdImage} find / -name index.html 2>/dev/null))
echo "Found that document root is: ${DocRoot}"

podman run -d \
--name mywebsite \
-p 8888:80 \
-v ${HOME}/mywebsite:${DocRoot}:Z \
${HttpdImage}

curl http://workstation:8888

