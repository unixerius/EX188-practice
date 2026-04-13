#!/bin/bash

cp /dockerfiles/mosquitto/colors.tar .
cp /dockerfiles/mosquitto/skeeter.sh .
cp /dockerfiles/mosquitto/mosquitto.conf .

cat > ./task7.dockerfile << EOF
# Use the centos 9 base image
FROM centos:9

# Add your maintainer info
MAINTAINER Tess Sluijter-Stek spam@spam.spam

# Create a user named duffman
RUN useradd -m duffman

# Install epel-release and mosquitto (epel-release must be installed first)
RUN dnf install -y epel-release && dnf install -y mosquitto && dnf clean all

# Create the colors directory from colors.tar
ADD colors.tar /

# Move skeeter.sh over to /skeeter.sh
COPY skeeter.sh /skeeter.sh

# Put mosquitto.conf into /etc/
COPY mosquitto.conf /etc/mosquitto.conf

# Make skeeter.sh executable
RUN chmod 755 /skeeter.sh && chmod 644 /etc/mosquitto.conf

# Allow connections to port 1883
EXPOSE 1883

# Switch to the duffman user
USER duffman

# Run the skeeter.sh script
ENTRYPOINT ["/skeeter.sh"]
EOF

podman build -t skeeter:1.0 -f ./task7.dockerfile .

rm colors.tar skeeter.sh mosquitto.conf

podman run -d --name mosquitto-1 \
        -p 11883:1883 \
        skeeter:1.0

echo "Now starting test...Stop with ctrl-C."

mosquitto_sub -h 127.0.0.1 -p 11883 -t "#"

