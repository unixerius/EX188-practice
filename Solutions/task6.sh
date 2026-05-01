#!/bin/bash

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

cp -r /dockerfiles/nginx ~/nginx

cat > ~/nginx/task6.dockerfile << EOF
# Edit this file to create an nginx webserver
# Pull from almalinux:9
FROM docker.io/library/almalinux:9

# Install nginx
RUN dnf install -y nginx && dnf clean all

# Publish port 80 to the outside world
EXPOSE 80

# Copy index.html and duffman.png into /usr/share/nginx/html directory
COPY index.html /usr/share/nginx/html/index.html
COPY duffman.png /usr/share/nginx/html/duffman.png

# Run the command 'nginx -g daemon off;'
ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
EOF

podman build -f ~/nginx/task6.dockerfile -t registry.do180.lab:5000/duff-nginx:1.0 ~/nginx

rm Dockerfile index.html duffman.png

podman push registry.do180.lab:5000/duff-nginx:1.0

podman run -d \
    --name duffman \
    --restart always \
    -p 8989:80 \
    registry.do180.lab:5000/duff-nginx:1.0

sleep 2
curl http://localhost:8989
