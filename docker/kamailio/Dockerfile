# MIT License
#
# Copyright (c) Networking and Virtualization Research Group (GIROS DIT-UPM).
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

# REFERENCE: https://github.com/herlesupreeth/docker_open5gs

# Dockerfile for Kamailio IMS containers.

# The base image is Ubuntu 22.04 LTS ("jammy").
FROM ubuntu:jammy

# Variables to automatically install/update tzdata.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

# Update base image with new packages.
RUN apt update && apt dist-upgrade -y && apt autoremove -y && apt autoclean

# Install some basic tools and dependencies.
RUN apt install -y sudo nano bash net-tools ldnsutils iputils-ping traceroute iproute2 \
    xauth openssh-server tcpdump unzip subversion git git-core curl wget gnupg ca-certificates \
    gcc make flex bison cmake libmysqlclient-dev libssl-dev libcurl4-openssl-dev libxml2-dev \
    libpcre2-dev bash-completion g++ autoconf libmnl-dev libsctp-dev libradcli-dev libradcli4 \
    libjson-c-dev pkg-config

# Clone, build and install Kamailio 5.3 from its GitHub repository.
RUN git clone https://github.com/kamailio/kamailio
WORKDIR /kamailio
RUN git checkout 5.3 && git pull
RUN make cfg
COPY modules.lst src/
RUN make -j`nproc` Q=0 all | tee make_all.txt && make install | tee make_install.txt && ldconfig

WORKDIR /

# Finally, create an administration user, set a password for the root user and enable SSH access.
# Reference: https://medium.com/@leicao.me/how-to-ssh-into-a-docker-container-remotely-as-root-or-a-non-root-user-b2105c797273
# Administration user -> Username: admin / Password: admintelecom
# Root user -> Username: root / Password: gprsumts
RUN useradd -m admin -s /bin/bash
RUN echo 'admin:admintelecom' | chpasswd
RUN echo 'root:gprsumts' | chpasswd
RUN echo 'admin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo 'export NOTVISIBLE="in user profile"' >> ~/.bashrc
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
