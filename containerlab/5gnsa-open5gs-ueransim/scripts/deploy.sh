#!/bin/bash

# MIT License
# 
# Copyright (c) 2023 Networking and Virtualization Research Group (GIROS DIT-UPM).
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

echo 'Containerlab scenario with Open5GS (LTE/4G EPC) and UERANSIM (1 gNB + 1 UE) for 5G Non-Standalone (NSA)'

echo ''
echo ''

echo '1.- Creating network bridges for inter-container connectivity: S1 Interface (S1-MME and S1-U); and MongoDB'

sudo ovs-vsctl add-br br-s1
sudo ovs-vsctl add-br br-mongodb

echo 'Done.'

echo ''
echo ''

echo '2.- Deploying Containerlab topologies (Open5GS EPC and UERANSIM)...'

sudo containerlab deploy --topo ../topologies/open5gs-epc.yaml
sudo containerlab deploy --topo ../topologies/ueransim.yaml

echo 'Done.'

echo ''
echo ''

echo '3.- Copying gNB and UE configuration files for UERANSIM containers...'

sudo docker cp ../conf/ueransim/gnb.yaml clab-ueransim-gnb:/
sudo docker exec -td clab-ueransim-gnb /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'
sudo docker cp ../conf/ueransim/ue.yaml clab-ueransim-ue:/
sudo docker exec -td clab-ueransim-ue /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '4.- Starting MongoDB daemon in its container...'

sudo docker exec -td clab-open5gs-epc-mongodb mongod --dbpath /var/lib/mongodb --logpath /var/log/mongodb/mongodb.log --bind_ip 0.0.0.0
sudo docker exec -td clab-open5gs-epc-mongodb /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '5.- Copying HSS configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/hss.yaml clab-open5gs-epc-hss:/
sudo docker exec -td clab-open5gs-epc-hss /open5gs/install/bin/open5gs-hssd -c /hss.yaml
sudo docker exec -td clab-open5gs-epc-hss /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '6.- Copying MME configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/mme.yaml clab-open5gs-epc-mme:/
sudo docker exec -td clab-open5gs-epc-mme /open5gs/install/bin/open5gs-mmed -c /mme.yaml
sudo docker exec -td clab-open5gs-epc-mme /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '7.- Copying PCRF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/pcrf.yaml clab-open5gs-epc-pcrf:/
sudo docker exec -td clab-open5gs-epc-pcrf /open5gs/install/bin/open5gs-pcrfd -c /pcrf.yaml
sudo docker exec -td clab-open5gs-epc-pcrf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '8.- Copying SMF/PGW-c configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/smf.yaml clab-open5gs-epc-pgwc:/
sudo docker exec -td clab-open5gs-epc-pgwc /open5gs/install/bin/open5gs-smfd -c /smf.yaml
sudo docker exec -td clab-open5gs-epc-pgwc /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '9.- Copying UPF/PGW-u configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/upf.yaml clab-open5gs-epc-pgwu:/
sudo docker exec -td clab-open5gs-epc-pgwu /open5gs/install/bin/open5gs-upfd -c /upf.yaml
sudo docker exec -td clab-open5gs-epc-pgwu /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '10.- Copying SGW-c configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/sgwc.yaml clab-open5gs-epc-sgwc:/
sudo docker exec -td clab-open5gs-epc-sgwc /open5gs/install/bin/open5gs-sgwcd -c /sgwc.yaml
sudo docker exec -td clab-open5gs-epc-sgwc /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '11.- Copying SGW-u configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/sgwu.yaml clab-open5gs-epc-sgwu:/
sudo docker exec -td clab-open5gs-epc-sgwu /open5gs/install/bin/open5gs-sgwud -c /sgwu.yaml
sudo docker exec -td clab-open5gs-epc-sgwu /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '12.- Starting Open5GS WebUI and registering UE subscriber identity...'

# Web UI credentials --> Username: admin / Password: 1423
sudo docker exec -td clab-open5gs-epc-webui /bin/bash -c 'export DB_URI=mongodb://10.101.1.1/open5gs && npm run dev --prefix /open5gs/webui'
sudo docker exec -td clab-open5gs-epc-mongodb /bin/bash -c '/open5gs-dbctl add 001010000000001 465B5CE8B199B49FAA5F0A2EE238A6BC E8ED289DEBA952E4283B54E88E6183CA'
sudo docker exec -td clab-open5gs-epc-mongodb /bin/bash -c '/open5gs-dbctl type 001010000000001 1'

echo 'Done.'

echo ''
echo ''

echo 'All done. Scenario fully deployed.'
