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

# Dockerfile for MongoDB container.

# The base image is Ubuntu 22.04 LTS ("jammy").
FROM ubuntu:jammy

# Variables to automatically install/update tzdata.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

# Update base image with new packages.
RUN apt update && apt dist-upgrade -y && apt autoremove -y && apt autoclean

# Install some basic tools and dependencies.
RUN apt install -y sudo nano bash net-tools ldnsutils iputils-ping traceroute iproute2 \
    openssh-server tcpdump unzip subversion git curl wget gnupg

# Install MongoDB and Open5GS's open5gs-dbctl tool.
RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
RUN echo "deb [arch=amd64,arm64] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN apt update && apt install -y mongodb-org
RUN wget https://raw.githubusercontent.com/open5gs/open5gs/main/misc/db/open5gs-dbctl && chmod +x open5gs-dbctl

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
