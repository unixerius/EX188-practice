#!/bin/sh

sudo yum install -y podman epel-release
sudo yum install -y podman-compose

ConfigFile="/etc/containers/registry.conf"
sudo cp ${ConfigFile} "${ConfigFile}.orig"

sudo sed -i 's/^unqualified-search-registries.*/unqualified-search-registries = ["registry.do188.lab:5000", "registry.access.redhat.com", "registry.redhat.io", "docker.io"]/' ${ConfigFile}

sudo cat >> ${ConfigFile} <<EOF

[[registry]]
location = "registry.do188.lab:5000"
insecure = "true"
EOF

podman search registry.do188.lab:5000/

