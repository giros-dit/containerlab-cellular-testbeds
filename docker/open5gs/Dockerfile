# MIT License
# 
# Copyright (c) 2023 martinezgarciadavid
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Dockerfile for Open5GS containers.

# The base image is Ubuntu 20.04 LTS ("focal").
FROM ubuntu:focal

# Variables to automatically install/update tzdata.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

# Update base image with new packages.
RUN apt update && apt dist-upgrade -y && apt autoremove -y && apt autoclean

# Install some basic tools and dependencies.
RUN apt install -y nano bash net-tools ldnsutils iputils-ping traceroute iproute2 \
    openssh-server tcpdump unzip subversion git curl wget gnupg python3-pip python3-setuptools \
    python3-wheel ninja-build build-essential flex bison git cmake libsctp-dev libgnutls28-dev \
    libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev libnghttp2-dev \
    libmicrohttpd-dev libcurl4-gnutls-dev libnghttp2-dev libtins-dev libtalloc-dev meson

# Install MongoDB.
RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
RUN echo "deb [arch=amd64,arm64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN apt update && apt install -y mongodb-org

# Install NodeJS.
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt install nodejs

# Clone, build and install Open5GS from its GitHub repository.
RUN git clone https://github.com/open5gs/open5gs
WORKDIR /open5gs
RUN meson build --prefix=`pwd`/install
RUN ninja -C build
RUN cd build/ && ninja install
WORKDIR /open5gs
RUN cd webui/ && npm ci

WORKDIR /
