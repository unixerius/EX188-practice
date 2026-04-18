#!/bin/sh

sudo yum install -y podman epel-release
sudo yum install -y podman-compose dos2unix

ConfigFile="/etc/containers/registries.conf"
sudo cp ${ConfigFile} "${ConfigFile}.orig"

sudo sed -i 's/^unqualified-search-registries.*/unqualified-search-registries = ["registry.do180.lab:5000", "registry.access.redhat.com", "registry.redhat.io", "docker.io"]/' ${ConfigFile}

sudo tee -a ${ConfigFile} <<EOF

[[registry]]
location = "registry.do180.lab:5000"
insecure = true

[[registry]]
location = "registry:5000"
insecure = true

EOF

podman search registry.do180.lab:5000/

