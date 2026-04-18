#!/bin/sh
# Thanks again to Nawaz Dhandala. Thanks to them, I now learned that Python normally buffers output.
# This makes it seem like there is no logging, if you run the container in daemonized form.
# See: https://oneuptime.com/blog/post/2026-03-16-troubleshoot-missing-container-logs-podman/view

sudo rm -rf ~/echo 2>/dev/null 

Repo="docker.io/library/python"

ImageTag=$(skopeo list-tags docker://${Repo} | grep -i slim | grep -i trixie | tr -d "\"|,| " | grep ^[a-z])

podman pull ${Repo}:${ImageTag}

# Found by running: dnf whatprovides */semanage
sudo dnf install -y policycoreutils-python-utils

cp -r /echo ~/

cat >~/echo/Dockerfile <<EOF
from ${Repo}:${ImageTag}

ENV PYTHONUNBUFFERED=1
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
chmod 755 ~/echo/udp_echo_server.py
exit
EOF

podman run --name echo -d -p 5500:5000/udp -v ~/echo:/app echo:1.0 /app/udp_echo_server.py

echo "Hello." >/dev/udp/workstation/5500

echo "You should see logs, that bytes were received. If not, then it didn't work."
podman logs echo 


