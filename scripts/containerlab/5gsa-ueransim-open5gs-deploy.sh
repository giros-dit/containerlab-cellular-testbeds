#!/bin/bash

sudo ovs-vsctl add-br br-sbi
sudo ovs-vsctl add-br br-n2-n3-n4

sudo containerlab deploy --topo ../../topologies/containerlab/5gsa-ueransim-open5gs.yaml

sudo docker cp ../../conf/ueransim/ue.yaml clab-5gsa-ueransim-open5gs-ue:/
sudo docker cp ../../conf/ueransim/gnb.yaml clab-5gsa-ueransim-open5gs-gnb:/

sudo docker exec -td clab-5gsa-ueransim-open5gs-mongodb mongod --dbpath /var/lib/mongodb --logpath /var/log/mongodb/mongodb.log --bind_ip 0.0.0.0

sudo docker cp ../../conf/open5gs/nrf.yaml clab-5gsa-ueransim-open5gs-nrf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-nrf /open5gs/install/bin/open5gs-nrfd -c /nrf.yaml

sudo docker cp ../../conf/open5gs/scp.yaml clab-5gsa-ueransim-open5gs-scp:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-scp /open5gs/install/bin/open5gs-scpd -c /scp.yaml

sudo docker cp ../../conf/open5gs/amf.yaml clab-5gsa-ueransim-open5gs-amf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-amf /open5gs/install/bin/open5gs-amfd -c /amf.yaml

sudo docker cp ../../conf/open5gs/smf.yaml clab-5gsa-ueransim-open5gs-smf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-smf /open5gs/install/bin/open5gs-smfd -c /smf.yaml

sudo docker cp ../../conf/open5gs/upf.yaml clab-5gsa-ueransim-open5gs-upf:/

sudo docker exec clab-5gsa-ueransim-open5gs-upf dhclient eth2
sudo docker exec clab-5gsa-ueransim-open5gs-upf ip route del default
sudo docker exec clab-5gsa-ueransim-open5gs-upf ip route add default via 192.168.122.1 dev eth2

sudo docker exec clab-5gsa-ueransim-open5gs-upf ip tuntap add name ogstun mode tun
sudo docker exec clab-5gsa-ueransim-open5gs-upf ip addr add 10.45.0.1/16 dev ogstun
sudo docker exec clab-5gsa-ueransim-open5gs-upf ip link set ogstun up

sudo docker exec -td clab-5gsa-ueransim-open5gs-upf /open5gs/install/bin/open5gs-upfd -c /upf.yaml

sudo docker exec clab-5gsa-ueransim-open5gs-upf sysctl -w net.ipv4.ip_forward=1

sudo docker exec clab-5gsa-ueransim-open5gs-upf iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE

sudo docker cp ../../conf/open5gs/ausf.yaml clab-5gsa-ueransim-open5gs-ausf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-ausf /open5gs/install/bin/open5gs-ausfd -c /ausf.yaml

sudo docker cp ../../conf/open5gs/udm.yaml clab-5gsa-ueransim-open5gs-udm:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-udm /open5gs/install/bin/open5gs-udmd -c /udm.yaml

sudo docker cp ../../conf/open5gs/pcf.yaml clab-5gsa-ueransim-open5gs-pcf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-pcf /open5gs/install/bin/open5gs-pcfd -c /pcf.yaml

sudo docker cp ../../conf/open5gs/nssf.yaml clab-5gsa-ueransim-open5gs-nssf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-nssf /open5gs/install/bin/open5gs-nssfd -c /nssf.yaml

sudo docker cp ../../conf/open5gs/bsf.yaml clab-5gsa-ueransim-open5gs-bsf:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-bsf /open5gs/install/bin/open5gs-bsfd -c /bsf.yaml

sudo docker cp ../../conf/open5gs/udr.yaml clab-5gsa-ueransim-open5gs-udr:/
sudo docker exec -td clab-5gsa-ueransim-open5gs-udr /open5gs/install/bin/open5gs-udrd -c /udr.yaml

# For WebUI:
# export DB_URI=mongodb://10.254.1.100/open5gs
# cd /open5gs/webui/
# npm run dev
# Credentials: admin/1423
