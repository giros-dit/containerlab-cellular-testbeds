# Containerized testbeds for cellular mobile communications networks

<table align="center">
	<tr>
		<td><a href="https://containerlab.dev/"><img src="resources/images/containerlab-logo.png"></a></td>
		<td><a href="http://web.dit.upm.es/vnxwiki/index.php/Main_Page"><img src="resources/images/vnx-logo.png"></a></td>
	</tr>
</table>

## Featured implementations
This repository features the following software/implementations to provide testbed scenarios for cellular mobile communications networks (LTE/4G/5G):

<table align="left">
	<tr>
		<td><a href="https://open5gs.org"><img src="resources/images/open5gs-logo.png"></a></td>
		<td>Open source 3GPP Rel-17 compliant implementation of 4G/LTE EPC (Evolved Packet Core) and 5G Core</td>
	</tr>
	<tr>
		<td><a href="https://github.com/aligungr/UERANSIM"><img src="resources/images/ueransim-logo.png"></a></td>
		<td>Open source 3GPP Rel-15 compliant implementation of 5G UE (User Equipment) and RAN-gNB (Radio Access Network-gNodeB) simulation</td>
	</tr>
</table>


## _Containerlab_ scenarios

### 1.- Building Docker images.

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

### 2.- Deploy testing scenarios.

In the `containerlab` directory there are several subdirectories with different testbed scenarios that can be used. Inside each subdirectory you can find the following:

- A `README` file with information and instructions about the scenario.
- A `conf` subdirectory with configuration files for each container that composes the scenario.
- A `topologies` subdirectory with _Containerlab_ topology definition files for the scenario.
- A `scripts` subdirectory with shell scripts for deploying/destroying/interacting with the scenario.

The number of available scenarios may increase with newer/different ones.

### 3.- Capturing traffic with Wireshark.

This command serves as a template to capture traffic with Wireshark in any container. You just need to replace `<clab-container-name>` with the desired _Containerlab_ container name and `<container-iface>` with the desired network interface inside the container.
The name of the container can be obtained right after deploying the topology. You must have Wireshark installed on your machine.

```
$ sudo ip netns exec <clab-container-name> tcpdump -l -nni <container-iface> -w - | wireshark -k -i -
```

## Disclaimer
_All images and logos are property of their respective owners._

_Click over any logo to open their official webpages for further information and installation/operation instructions._

Special thanks to every developer and contributor that made any featured implementation possible.
