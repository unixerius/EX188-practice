FROM docker.io/library/almalinux:9

ARG buildname=joe

RUN useradd -m $buildname
USER $buildname

CMD ["whoami"]
