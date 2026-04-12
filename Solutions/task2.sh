#!/bin/sh

skopeo list-tags docker://registry.do180.lab:5000/httpd

sudo podman pull registry.do180.lab:5000/httpd:latest

sudo podman run -d \
        --name reg-httpd \
        -p 8080:80 \
        -v /web:/usr/local/apache2/htdocs:Z \
        registry.do180.lab:5000/httpd:latest

sudo podman generate systemd reg-httpd | sudo tee -a /usr/lib/systemd/system/reg-httpd.service

sudo systemctl daemon-reload
sudo systemctl enable reg-httpd
sudo systemctl restart reg-httpd
