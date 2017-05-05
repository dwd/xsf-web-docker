# Dockerfile to build a docker image from Openfire Master
#
# Dave Cridland <dave.cridland@surevine.com>
# Copyright 2017 Surevine Ltd

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

FROM debian:7.10
MAINTAINER Dave Cridland <dave.cridland@surevine.com>

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Update system
RUN apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get clean

# Install dependencies.
RUN apt-get install -y python-pip git && pip install pelican==3.3 markdown ghp-import

# Arguments::
ARG XSF_GIT=https://github.com/xsf/xmpp.org

# Clone sources
WORKDIR /var/tmp/src
RUN git clone ${XSF_GIT} && cd xmpp.org && make publish

EXPOSE 8000

CMD cd /var/tmp/src/xmpp.org && make serve
