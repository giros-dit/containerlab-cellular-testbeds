#!/bin/bash

sudo ovs-vsctl add-br br-sbi

sudo containerlab deploy --topo ../../topologies/containerlab/5gsa-ueransim-open5gs.yaml

sudo docker cp ../../conf/ueransim/ue.yaml clab-5gsa-ueransim-open5gs-ue:/
sudo docker cp ../../conf/ueransim/gnb.yaml clab-5gsa-ueransim-open5gs-gnb:/

sudo docker cp ../../conf/open5gs/amf.yaml clab-5gsa-ueransim-open5gs-amf:/
sudo docker cp ../../conf/open5gs/ausf.yaml clab-5gsa-ueransim-open5gs-ausf:/
sudo docker cp ../../conf/open5gs/bsf.yaml clab-5gsa-ueransim-open5gs-bsf:/
sudo docker cp ../../conf/open5gs/nrf.yaml clab-5gsa-ueransim-open5gs-nrf:/
sudo docker cp ../../conf/open5gs/nssf.yaml clab-5gsa-ueransim-open5gs-nssf:/
sudo docker cp ../../conf/open5gs/pcf.yaml clab-5gsa-ueransim-open5gs-pcf:/
sudo docker cp ../../conf/open5gs/scp.yaml clab-5gsa-ueransim-open5gs-scp:/
sudo docker cp ../../conf/open5gs/smf.yaml clab-5gsa-ueransim-open5gs-smf:/
sudo docker cp ../../conf/open5gs/udm.yaml clab-5gsa-ueransim-open5gs-udm:/
sudo docker cp ../../conf/open5gs/udr.yaml clab-5gsa-ueransim-open5gs-udr:/
sudo docker cp ../../conf/open5gs/upf.yaml clab-5gsa-ueransim-open5gs-upf:/