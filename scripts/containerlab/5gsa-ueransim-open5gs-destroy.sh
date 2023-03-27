#!/bin/bash

sudo containerlab destroy --topo ../../topologies/containerlab/5gsa-ueransim-open5gs.yaml

sudo ovs-vsctl del-br br-sbi
