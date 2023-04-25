# Containerized testbeds for cellular mobile communications networks

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

### Step 2: Using the provided topologies to build scenarios.

In the `containerlab/topologies/` directory there are some `.yaml` files that you can use to define custom scenarios for your testing purposes. The current list of available topologies is the following:

- `open5gs-5gc.yaml`: Open5GS 5G Core for Standalone (SA) deployments.
- `ueransim.yaml`: UERANSIM with 1 gNB and 1 UE for 5G Standalone (SA) deployments.

You can modify these topologies freely.

### Step 3: Using the provided scripts to deploy testing scenarios.

In the `containerlab/scenarios/` directory you can find several subdirectories with ready to use scenarios. Here is a list of the current ones available:

- `5gsa-open5gs-ueransim`. 5G Standalone (SA) scenario with Open5GS 5G Core and UERANSIM with 1 gNB + 1 UE.

Every subdirectory may contain several scripts to deploy and destroy the scenario, and to perform other operations. Please, check these out for more information and context.

### Step 4: Capturing traffic with Wireshark.

This command serves as a template to capture traffic with Wireshark in any container. You just need to replace `<clab-container-name>` with the desired _Containerlab_ container name and `<container-iface>` with the desired network interface inside the container.
The name of the container can be obtained right after deploying the topology.

```
$ sudo ip netns exec <clab-container-name> tcpdump -l -nni <container-iface> -w - | wireshark -k -i -
```

