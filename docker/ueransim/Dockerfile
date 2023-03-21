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

# Dockerfile for UERANSIM containers.

# The base image is Ubuntu 20.04 LTS ("focal").
FROM ubuntu:focal

# Variables to automatically install/update tzdata.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

# Update base image with new packages.
RUN apt update && apt dist-upgrade -y && apt autoremove -y && apt autoclean

# Install some basic tools and dependencies.
RUN apt install -y nano bash net-tools ldnsutils iputils-ping traceroute iproute2 openssh-server tcpdump unzip subversion git curl wget gcc make perl g++ libsctp-dev lksctp-tools libssl-dev

# Download and extract cmake source code (latest stable version as of March 21, 2023: 3.26.0)
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.0/cmake-3.26.0.tar.gz
RUN tar -xzf cmake-3.26.0.tar.gz

# Build cmake from source code.
WORKDIR /cmake-3.26.0
RUN ./bootstrap && make && make install

# Clone and build UERANSIM from its GitHub repository.
WORKDIR /
RUN git clone https://github.com/aligungr/UERANSIM.git && cd UERANSIM && make -j

# Copy UERANSIM binaries to /usr/local/bin
WORKDIR /UERANSIM/build
RUN ln -s nr-gnb /usr/local/bin/nr-gnb && ln -s nr-ue /usr/local/bin/nr-ue && ln -s nr-cli /usr/local/bin/nr-cli && ln -s nr-binder /usr/local/bin/nr-binder
