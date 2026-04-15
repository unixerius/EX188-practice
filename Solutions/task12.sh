#!/bin/sh

mkdir ${HOME}/mywebsite
echo "Welcome to my website." > ${HOME}/mywebsite/index.html

HttpdImage=$(podman search --filter=is-official httpd | grep "/httpd" | cut -d" " -f1)

podman pull ${HttpdImage}

DocRoot=$(dirname $(podman run ${HttpdImage} find / -name index.html 2>/dev/null))

podman run -d \
--name mywebsite \
-p 8888:80 \
-v ${HOME}/mywebsite:${DocRoot}:Z \
${HttpdImage}

curl http://localhost:8888

