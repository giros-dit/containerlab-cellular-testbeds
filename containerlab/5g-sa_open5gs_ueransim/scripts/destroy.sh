#!/bin/bash

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

echo 'Containerlab scenario with Open5GS (5G Core) and UERANSIM (1 gNB + 2 UEs) for 5G Standalone (SA)'

echo ''
echo ''

echo 'Destroying scenario...'

echo ''
echo ''

echo '1.- Destroying Open5GS 5G Core topology...'

sudo containerlab destroy --topo ../topologies/open5gs-5gc.yaml
sudo rm -Rf clab-open5gs-5gc/
sudo rm ../topologies/.open5gs-5gc.yaml.bak

echo 'Done.'

echo ''
echo ''

echo '2.- Destroying UERANSIM (1 gNB + 2 UEs) topology...'

sudo containerlab destroy --topo ../topologies/ueransim.yaml
sudo rm -Rf clab-ueransim/
sudo rm ../topologies/.ueransim.yaml.bak

echo 'Done.'

echo ''
echo ''

echo '3.- Deleting Open vSwitch bridges...'

sudo ovs-vsctl del-br br-sbi
sudo ovs-vsctl del-br br-n2-n3-n4
sudo ovs-vsctl del-br br-nr-uu

echo 'Done.'

echo ''
echo ''

echo 'All done. Scenario fully destroyed.'
