#!/bin/bash

sudo ovs-vsctl add-br br-sbi

sudo containerlab deploy --topo ../../topologies/containerlab/5gsa-ueransim-open5gs.yaml

sudo docker cp ../../conf/ueransim/ue.yaml clab-5gsa-ueransim-open5gs-ue:/
sudo docker cp ../../conf/ueransim/gnb.yaml clab-5gsa-ueransim-open5gs-gnb:/

sudo docker exec -d clab-5gsa-ueransim-open5gs-mongodb mongod --dbpath /var/lib/mongodb --logpath /var/log/mongodb/mongodb.log --bind_ip 0.0.0.0
sleep 5

sudo docker cp ../../conf/open5gs/nrf.yaml clab-5gsa-ueransim-open5gs-nrf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-nrf /open5gs/install/bin/open5gs-nrfd -D -c /nrf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/scp.yaml clab-5gsa-ueransim-open5gs-scp:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-scp /open5gs/install/bin/open5gs-scpd -D -c /scp.yaml
sleep 5

sudo docker cp ../../conf/open5gs/amf.yaml clab-5gsa-ueransim-open5gs-amf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-amf /open5gs/install/bin/open5gs-amfd -D -c /amf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/smf.yaml clab-5gsa-ueransim-open5gs-smf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-smf /open5gs/install/bin/open5gs-smfd -D -c /smf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/upf.yaml clab-5gsa-ueransim-open5gs-upf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-upf /open5gs/install/bin/open5gs-upfd -D -c /upf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/ausf.yaml clab-5gsa-ueransim-open5gs-ausf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-ausf /open5gs/install/bin/open5gs-ausfd -D -c /ausf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/udm.yaml clab-5gsa-ueransim-open5gs-udm:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-udm /open5gs/install/bin/open5gs-udmd -D -c /udm.yaml
sleep 5

sudo docker cp ../../conf/open5gs/pcf.yaml clab-5gsa-ueransim-open5gs-pcf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-pcf /open5gs/install/bin/open5gs-pcfd -D -c /pcf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/nssf.yaml clab-5gsa-ueransim-open5gs-nssf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-nssf /open5gs/install/bin/open5gs-nssfd -D -c /nssf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/bsf.yaml clab-5gsa-ueransim-open5gs-bsf:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-bsf /open5gs/install/bin/open5gs-bsfd -D -c /bsf.yaml
sleep 5

sudo docker cp ../../conf/open5gs/udr.yaml clab-5gsa-ueransim-open5gs-udr:/
sudo docker exec -d clab-5gsa-ueransim-open5gs-udr /open5gs/install/bin/open5gs-udrd -D -c /udr.yaml
sleep 5

# For WebUI:
# export DB_URI=mongodb://10.254.1.100/open5gs
# cd /open5gs/webui/
# npm run dev
# Credentials: admin/1423
