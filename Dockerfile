#
# Dockerfile to build a docker image from Openfire Master
#
# Dave Cridland <dave.cridland@surevine.com>
# Copyright 2017 Surevine Ltd
#
# Interesting ports: 8080

# Use Ubuntu 16.04 LTS. Because.
FROM debian:7.10
MAINTAINER Dave Cridland <dave.cridland@surevine.com>

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64

# Update system
RUN apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get clean

# Install dependencies.
RUN apt-get install -y python-pip git && pip install pelican markdown ghp-import

# Arguments::
# git repo (your local, or the default Ignite's)
ARG XSF_GIT=https://github.com/xsf/xmpp.org

# Clone sources
WORKDIR /var/tmp/src
ARG XSF_GIT_COMMIT=master
ARG XSF_EPOCH="1"
RUN git clone ${XSF_GIT} && cd xmpp.org && make publish

# Ports:
EXPOSE 8000
# HTTP Admin Console

CMD cd /var/tmp/src/xmpp.org && make serve
