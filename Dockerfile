FROM msjpq/kde-vnc:focal
FROM python:3.9-slim

USER root
RUN apt-get update && apt-get install sudo -y
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER
ARG NB_UID 0
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER root
RUN chown root:root /usr/bin/sudo
RUN chmod 4755 /usr/bin/sudo
# USER ${USER}