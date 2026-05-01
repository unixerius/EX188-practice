#!/bin/bash

# Needed to ensure that containers come up after a reboot.
sudo loginctl enable-linger $(whoami)
systemctl --user enable podman-restart
systemctl --user start podman-restart
sudo systemctl enable podman-restart
sudo systemctl start podman-restart

cp -r /dockerfiles/mosquitto/ ~/mosquitto

cat > ~/mosquitto/Dockerfile << EOF
# Use the almalinux:9 base image
FROM docker.io/library/almalinux:9

# Add your maintainer info
MAINTAINER Tess Sluijter-Stek spam@spam.spam

# Create a user named duffman
RUN useradd -m duffman

# Install epel-release and mosquitto (epel-release must be installed first)
RUN dnf install -y epel-release && dnf install -y mosquitto dos2unix && dnf clean all

# Create the colors directory from colors.tar
ADD colors.tar /

# Move skeeter.sh over to /skeeter.sh
COPY skeeter.sh /skeeter.sh

# Put mosquitto.conf into /etc/
COPY mosquitto.conf /etc/mosquitto/mosquitto.conf

# Make skeeter.sh executable
RUN chmod 755 /skeeter.sh && dos2unix /skeeter.sh && chmod 644 /etc/mosquitto/mosquitto.conf

# Allow connections to port 1883
EXPOSE 1883

# Switch to the duffman user
USER duffman

# Run the skeeter.sh script
ENTRYPOINT [ "/skeeter.sh" ]
EOF

podman build -t skeeter:1.0 -f ~/task7/Dockerfile ~/task7

podman run -d \
    --name mosquitto-1 \
    --restart always \
    -p 11883:1883 \
    skeeter:1.0

sleep 2
echo "Now starting test...Stop with ctrl-C."
mosquitto_sub -h 127.0.0.1 -p 11883 -t "#"

