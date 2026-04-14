FROM centos:7

ARG buildname=joe

RUN useradd -m $buildname
USER $buildname

CMD ["whoami"]
