# Containerized testbeds for cellular mobile communications networks

**NOTE:** Currently work-in-progress. README will be updated whenever a bare minimum scenario can be fully deployed and tested.

## _Containerlab_ scenarios

### Step 1: Building Docker images.

You need to build the Docker images of all containers. Follow the following steps (assuming you have a terminal opened at this project's root directory):

```
# For UERANSIM containers:
$ cd docker/ueransim/
$ sudo docker build --no-cache -t giros-dit/ueransim:latest .

# For Open5GS containers:
$ cd docker/open5gs/
$ sudo docker build --no-cache -t giros-dit/open5gs:latest .

# For MongoDB container (subscriber database for Open5GS topologies):
$ cd docker/mongodb/
$ sudo docker build --no-cache -t giros-dit/mongodb:latest .
```

### Step 2: Using the provided topologies as building blocks.

In the `containerlab/topologies/` directory there are some `.yaml` files that you can use as some sort of building blocks to define custom scenarios for your testing purposes. The current list of available topologies is the following (note that this list will be updated with new topologies or updated versions of the previously available ones):

- `open5gs-5gc.yaml`: Open5GS 5G Core for Standalone (SA) deployments.
- `ueransim.yaml`: UERANSIM with 1 gNB and 1 UE for 5G Standalone (SA) deployments.

You can modify these topologies freely.

### Step 3: Using the provided scripts to deploy testing scenarios.

In the `containerlab/scenarios/` directory you can find several subdirectories with ready to use scenarios built by us. As of Tuesday, 11th April, 2023, here is a list of the current pre-built scenarios:

- `5gsa-open5gs-ueransim`. 5G Standalone (SA) scenario with Open5GS 5G Core and UERANSIM with 1 gNB + 1 UE.

Use the `deploy.sh` and `destroy.sh` shell scripts to automatically deploy and destroy the scenarios. The additional `start-gnb.sh` and `start-ue.sh` scripts run the respective UERANSIM binaries in the foreground. You can edit these scripts as you wish. In the `conf` subdirectory you can find all configuration files for every container of the topologies that form the scenario.

### Step 4: Capturing traffic with Wireshark.

This command serves as a template to capture traffic with Wireshark in any container. You just need to replace `<clab-container-name>` with the desired _Containerlab_ container name and `<container-iface>` with the desired network interface inside the container.

```
$ sudo ip netns exec <clab-container-name> tcpdump -l -nni <container-iface> -w - | wireshark -k -i -
```

