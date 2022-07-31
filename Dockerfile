FROM jupyter/scipy-notebook:cf6258237ff9
# FROM ubuntu:12.04
FROM msjpq/kde-vnc:focal
USER root
# RUN apt-get update && \
#       apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
RUN adduser docker sudo

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
COPY . ${HOME}
RUN adduser ${NB_USER} sudo
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
ENTRYPOINT ["/bin/bash", "-c", "@$"]
