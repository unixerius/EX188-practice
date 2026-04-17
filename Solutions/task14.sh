#!/bin/sh

Repo="docker.io/library/python"

ImageTag=$(skopeo list-tags docker://${Repo} | grep -i slim | grep -i trixie | tr -d "\"|,| " | grep ^[a-z])

podman pull ${Repo}:${ImageTag}

# Found by running: dnf whatprovides */semanage
sudo dnf install -y policycoreutils-python-utils

cp -r /echo ~/echo

cat >~/echo/Dockerfile <<EOF
from ${Repo}:${ImageTag}

RUN useradd -u 1000 -m app
USER app

ENTRYPOINT [ "python3" ]
EOF

podman build -t echo:1.0 ~/echo

sudo semanage fcontext -a -t container_file_t "${HOME}/echo(/.*)?"
sudo restorecon -R -v ~/echo
ls -alZ ~/echo

podman unshare <<EOF
chown -R 1000:1000 ~/echo
chmod 755 ~/echo/echo.py
exit
EOF

podman run --name echo -d -p 5000:5000/udp -v ./echo:/app echo:1.0 /app/echo.py

bash -e echo "Hello." >/dev/udp/workstation/5000

podman logs echo 

