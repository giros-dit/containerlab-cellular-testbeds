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

echo 'Containerlab scenario with Open5GS (5G Core) and UERANSIM (1 gNB + 1 UE) for 5G Standalone (SA)'

echo ''
echo ''

echo '1.- Creating network bridges for inter-container connectivity: SBI; and N2, N3 and N4 Interfaces...'

sudo ovs-vsctl add-br br-sbi
sudo ovs-vsctl add-br br-n2-n3-n4

echo 'Done.'

echo ''
echo ''

echo '2.- Deploying Containerlab topologies (Open5GS 5G Core and UERANSIM)...'

sudo containerlab deploy --topo ../topologies/open5gs-5gc.yaml
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

sudo docker exec -td clab-open5gs-5gc-mongodb mongod --dbpath /var/lib/mongodb --logpath /var/log/mongodb/mongodb.log --bind_ip 0.0.0.0
sudo docker exec -td clab-open5gs-5gc-mongodb /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '5.- Copying NRF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/nrf.yaml clab-open5gs-5gc-nrf:/
sudo docker exec -td clab-open5gs-5gc-nrf /open5gs/install/bin/open5gs-nrfd -c /nrf.yaml
sudo docker exec -td clab-open5gs-5gc-nrf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '6.- Copying SCP configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/scp.yaml clab-open5gs-5gc-scp:/
sudo docker exec -td clab-open5gs-5gc-scp /open5gs/install/bin/open5gs-scpd -c /scp.yaml
sudo docker exec -td clab-open5gs-5gc-scp /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '7.- Copying AMF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/amf.yaml clab-open5gs-5gc-amf:/
sudo docker exec -td clab-open5gs-5gc-amf /open5gs/install/bin/open5gs-amfd -c /amf.yaml
sudo docker exec -td clab-open5gs-5gc-amf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '8.- Copying SMF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/smf.yaml clab-open5gs-5gc-smf:/
sudo docker exec -td clab-open5gs-5gc-smf /open5gs/install/bin/open5gs-smfd -c /smf.yaml
sudo docker exec -td clab-open5gs-5gc-smf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '9.- Copying UPF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/upf.yaml clab-open5gs-5gc-upf:/
sudo docker exec -td clab-open5gs-5gc-upf /open5gs/install/bin/open5gs-upfd -c /upf.yaml
sudo docker exec -td clab-open5gs-5gc-upf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '10.- Copying AUSF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/ausf.yaml clab-open5gs-5gc-ausf:/
sudo docker exec -td clab-open5gs-5gc-ausf /open5gs/install/bin/open5gs-ausfd -c /ausf.yaml
sudo docker exec -td clab-open5gs-5gc-ausf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '11.- Copying UDM configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/udm.yaml clab-open5gs-5gc-udm:/
sudo docker exec -td clab-open5gs-5gc-udm /open5gs/install/bin/open5gs-udmd -c /udm.yaml
sudo docker exec -td clab-open5gs-5gc-udm /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '12.- Copying PCF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/pcf.yaml clab-open5gs-5gc-pcf:/
sudo docker exec -td clab-open5gs-5gc-pcf /open5gs/install/bin/open5gs-pcfd -c /pcf.yaml
sudo docker exec -td clab-open5gs-5gc-pcf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '13.- Copying NSSF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/nssf.yaml clab-open5gs-5gc-nssf:/
sudo docker exec -td clab-open5gs-5gc-nssf /open5gs/install/bin/open5gs-nssfd -c /nssf.yaml
sudo docker exec -td clab-open5gs-5gc-nssf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '14.- Copying BSF configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/bsf.yaml clab-open5gs-5gc-bsf:/
sudo docker exec -td clab-open5gs-5gc-bsf /open5gs/install/bin/open5gs-bsfd -c /bsf.yaml
sudo docker exec -td clab-open5gs-5gc-bsf /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '15.- Copying UDR configuration file and starting its daemon...'

sudo docker cp ../conf/open5gs/udr.yaml clab-open5gs-5gc-udr:/
sudo docker exec -td clab-open5gs-5gc-udr /open5gs/install/bin/open5gs-udrd -c /udr.yaml
sudo docker exec -td clab-open5gs-5gc-udr /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo '16.- Starting Open5GS WebUI and registering UE subscriber identity...'

# Web UI credentials --> Username: admin / Password: 1423
sudo docker exec -td clab-open5gs-5gc-webui /bin/bash -c 'export DB_URI=mongodb://10.254.1.100/open5gs && npm run dev --prefix /open5gs/webui'
sudo docker exec -td clab-open5gs-5gc-mongodb /bin/bash -c '/open5gs-dbctl add 001010000000001 465B5CE8B199B49FAA5F0A2EE238A6BC E8ED289DEBA952E4283B54E88E6183CA'
sudo docker exec -td clab-open5gs-5gc-mongodb /bin/bash -c '/open5gs-dbctl type 001010000000001 1'
sudo docker exec -td clab-open5gs-5gc-mongodb /bin/bash -c 'mkdir /var/run/sshd && /usr/sbin/sshd -D'

echo 'Done.'

echo ''
echo ''

echo 'All done. Scenario fully deployed.'
