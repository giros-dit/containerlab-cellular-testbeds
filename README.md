# Containerized testbeds for cellular mobile communications networks

<table align="center">
	<tr>
		<td><a href="https://containerlab.dev/"><img src="resources/images/containerlab-logo.png"></a></td>
		<td><a href="http://web.dit.upm.es/vnxwiki/index.php/Main_Page"><img src="resources/images/vnx-logo.png"></a></td>
	</tr>
</table>

## About

The main goal of this repository is to provide testbed scenarios for cellular mobile communications networks (e.g., LTE/4G/5G) using containerization tools (Docker and Linux Containers).

While Docker provides Docker Compose for defining and deploying complex, multi-container scenarios, the networking part of it (inter-container connectivity) is arguably still a little bit complicated. Therefore, it's interesting to use other tools that simplify this task, so here's where Containerlab comes into play. For LXC containers we face similar challenges, and VNX (Virtual Networks over linuX) provides a similar solution. Both tools provide an easy way to define network topologies and scenarios, using standard definition languages (YAML for Containerlab and XML for VNX). And by leveraging existent Linux bridging and switching software, such as Open vSwitch, we can use them to define custom, modular scenarios that can be interconnected in a handful of different ways.

The idea is to provide different testbed scenarios that you can use to deploy and test complete cellular networks. The core network is provided using containerized topologies, and the RAN can be either deployed using any simulated or _physical_ implementations of your choice. The scenarios can be interconnected, so it's possible to, for example, add an IMS and provide VoLTE, or extend the networks any way you may imagine.

### Requisites

In order to run the scenarios, you need to have the following:
- A machine running either a native or virtualized 64-bit Linux operating system with a fairly good amount of available RAM and storage.
	- Depending on your system limitations and the usage of your operating system, a good, minimum recommendation would be to have 16 GB of RAM and 128 GB of storage. However, a more limited system could also run these scenarios without trouble.
	- Since the core functionality of the scenarios runs on Docker and LXC containers, any Linux distribution can be used. However, for maximum compatibility of libraries and dependencies we have used Ubuntu 20.04 LTS. You may want to use this or a newer version. Nevertheless, if you prefer another distribution, feel free to use it, but notice that the installation instructions for any library and dependency will vary.
	- If you only plan to run the Containerlab testbed scenarios and you use Windows 10 or 11, WSL2 may work, but bear in mind that we haven't tested it.
- If you want to run the Containerlab testbed scenarios, you need to install it accordingly. You can find the installation instructions along with more documentation at this link: https://containerlab.dev/install/. These scenarios are based on Docker containers, so you must have Docker installed on your machine.
- If you want to run the VNX scenarios, you need to install it accordingly. The installation instructions can be found at this link: http://web.dit.upm.es/vnxwiki/index.php/Vnx-install. VNX has further requirements that you can also check at that link.
- Some inter-container connectivity relies on Open vSwitch bridges, so you must install it as well. If you installed VNX, Open vSwitch comes as a dependency of it.
- The connectivity between some Containerlab topologies and between scenarios and the Internet is done via the `virbr0` bridge provided by the `libvirt` library, so you must install it. If you installed VNX, `libvirt` comes as a dependency of it.
- For traffic capturing, you need to have Wireshark installed on your system.

### Featured implementations

<table align="left">
	<tr>
		<td><a href="https://open5gs.org"><img src="resources/images/open5gs-logo.png"></a></td>
		<td>Open source 3GPP Rel-17 compliant implementation of 4G-LTE EPC (Evolved Packet Core) and 5G Core.</td>
	</tr>
	<tr>
		<td><a href="https://github.com/aligungr/UERANSIM"><img src="resources/images/ueransim-logo.png"></a></td>
		<td>Open source 3GPP Rel-15 compliant implementation of 5G UE (User Equipment) and RAN (Radio Access Network) gNB simulation.</td>
	</tr>
</table>

## General instructions

### Containerlab scenarios

#### 1.- Building Docker images

You need to build the Docker images of all containers. Follow the following steps (assuming you have a terminal opened at this project's root directory):

```
# For UERANSIM containers:
$ cd docker/ueransim/
$ sudo docker build --no-cache -t giros-dit/ueransim:latest .

# For Open5GS containers:
$ cd docker/open5gs/
$ sudo docker build --no-cache -t giros-dit/open5gs:latest .

# For MongoDB container (Open5GS subscriber database):
$ cd docker/mongodb/
$ sudo docker build --no-cache -t giros-dit/mongodb:latest .
```

#### 2.- Deploy testing scenarios

In the !`[containerlab]`(containerlab) directory there are several subdirectories with different testbed scenarios that can be used. Inside each subdirectory you can find the following:

- A `README` file with information and instructions about the scenario.
- A `conf` subdirectory with configuration files for each container that composes the scenario.
- A `topologies` subdirectory with _Containerlab_ topology definition files for the scenario.
- A `scripts` subdirectory with shell scripts for deploying/destroying/interacting with the scenario.

The number of available scenarios may increase with newer/different ones.

#### 3.- Capturing traffic with Wireshark

This command serves as a template to capture traffic with Wireshark in any container. You just need to replace `<clab-container-name>` with the desired Containerlab container name and `<container-iface>` with the desired network interface inside the container.
The name of the container can be obtained right after deploying the topology. You must have Wireshark installed on your machine.

```
$ sudo ip netns exec <clab-container-name> tcpdump -l -nni <container-iface> -w - | wireshark -k -i -
```

#### SSH access to containers

You can SSH to the containers deployed in any scenario with the following set of credentials:
- Username: `root` - Password: `gprsumts`.
- Username: `admin` - Password: `admintelecom`.

## Disclaimer and acknowledgements
_All images and logos are property of their respective owners. Click over any logo to open the official project's webpage for further information and documentation._

Special thanks to every developer and contributor that made any featured implementation possible.
