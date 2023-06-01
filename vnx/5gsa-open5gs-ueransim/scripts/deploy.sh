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

echo 'VNX Scenario with Open5GS (5G Core) and UERANSIM (1 gNB + 1 UE) for 5G Standalone (SA)'

echo ''
echo ''

echo '1.- Restarting Open vSwitch before deploying the scenario...'

sudo ovs-vsctl --if-exists del-br br-sbi
sudo ovs-vsctl --if-exists del-br br-n2-n3-n4
sudo ovs-vsctl emer-reset
sudo /etc/init.d/openvswitch-switch restart

echo 'Done'

echo '2.- Creating network bridges for inter-container connectivity: SBI; and N2, N3 and N4 Interfaces...'

sudo ovs-vsctl add-br br-sbi
sudo ovs-vsctl add-br br-n2-n3-n4

echo 'Done.'

echo ''
echo ''

echo '3.- Creating VNX scenario...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --create
sleep 1

echo 'Done.'

echo ''
echo ''

echo '4.- Starting MongoDB daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-mongodb

echo 'Done.'

echo ''
echo ''

echo '5.- Starting NRF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-nrf

echo 'Done.'

echo ''
echo ''

echo '6.- Starting SCP daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-scp

echo 'Done.'

echo ''
echo ''

echo '7.- Starting AMF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-amf

echo 'Done.'

echo ''
echo ''

echo '8.- Starting SMF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-smf

echo 'Done.'

echo ''
echo ''

echo '9.- Starting UPF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-upf

echo 'Done.'

echo ''
echo ''

echo '10.- Starting AUSF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-ausf

echo 'Done.'

echo ''
echo ''

echo '11.- Starting UDM daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-udm

echo 'Done.'

echo ''
echo ''

echo '12.- Starting PCF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-pcf

echo 'Done.'

echo ''
echo ''

echo '13.- Starting NSSF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-nssf

echo 'Done.'

echo ''
echo ''

echo '14.- Starting BSF daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-bsf

echo 'Done.'

echo ''
echo ''

echo '15.- Starting UDR daemon...'

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-udr

echo 'Done.'

echo ''
echo ''

echo '16.- Starting WebUI and adding UE subscriber identity...'

# Web UI credentials --> Username: admin / Password: 1423

sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute start-webui
sudo vnx -f ../5gsa-open5gs-ueransim.xml --execute add-ue

echo 'Done.'

echo ''
echo ''

echo 'All done. Scenario fully deployed.'
