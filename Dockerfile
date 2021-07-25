ARG BASE_CONTAINER=pzawad/raspios-xfce4
FROM $BASE_CONTAINER

ARG DISPLAY=${DISPLAY:-":0.0"}
ENV DISPLAY=${DISPLAY}

ENV USER=${USER:-pi}

ENV USER_NAME=${USER}
ENV HOME=/home/${USER}
ENV WORKDIR=/home/${USER}

ENV DEBIAN_FRONTEND noninteractive
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}

ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
ENV unix:runtime=yes

USER root

RUN rm -rf .cache/
COPY .config/ /home/pi/.config/
RUN chown -R ${USER_ID}.${GROUP_ID} ${HOME}/.config/

RUN apt-get update && apt-get install -y codeblocks && apt-get clean

USER ${USER}
WORKDIR ${HOME}

CMD ["/bin/bash"]

MAINTAINER Piotr ZAWADZKI "pzawadzki@polsl.pl"
