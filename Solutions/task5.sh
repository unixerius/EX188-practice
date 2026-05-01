#!/bin/sh

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

podman exec -ti alp-httpd /bin/sh << EOF
echo "Before:"
cat /usr/local/apache2/htdocs/index.html
sed -i 's/It works!/It Twerks!/' /usr/local/apache2/htdocs/index.html
echo "After:"
cat /usr/local/apache2/htdocs/index.html
exit
EOF

curl http://localhost:8008

read -p "Did it work? Shall we continue? Press enter." ANSWER

podman commit -a Tess alp-httpd registry.do180.lab:5000/httpd:twerks

podman push registry.do180.lab:5000/httpd:twerks

echo "Verifying the upload:"
podman search httpd:twerks

podman kill alp-httpd

podman run -d \
    --name tw-httpd \
    --restart always \
    -p 8008:80 \
    registry.do180.lab:5000/httpd:twerks

sleep 2
curl http://workstation:8008

