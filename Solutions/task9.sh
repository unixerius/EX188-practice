#!/bin/bash

cat > task9.dockerfile << EOF
FROM centos:9

ARG buildname=joe

RUN useradd -m \$buildname
USER \$buildname

CMD ["whoami"]
EOF

podman build -t hello-joe:1.0 -f task9.dockerfile .

podman build --build-arg buildname=lisa -t hello-lisa:1.0 -f task9.dockerfile .

podman run -ti --name joe hello-joe:1.0
podman run -ti --name lisa hello-lisa:1.0

