# 5G Standalone (5G SA) with _Open5GS_ and _UERANSIM_

## Scenario diagram

![](resources/5g-sa_open5gs_ueransim.drawio.png)

## Deploying the scenario

```bash
$ cd scripts/
$ ./deploy.sh
```

## Starting gNB and UEs

In different terminal tabs or windows:

### gNB

```bash
$ cd scripts/
$ ./start-gnb.sh
```

### UE 1

```bash
$ cd scripts/
$ ./start-ue1.sh
```

### UE 2

```bash
$ cd scripts/
$ ./start-ue2.sh
```

## Using UE's Internet connectivity

Open a new terminal tab or window and execute the following:

```bash
$ ssh -X root@clab-ueransim-ue1
```
(for UE 1)

```bash
$ ssh -X root@clab-ueransim-ue2
```
(for UE 2)

Password is `gprsumts`.

Once logged in, execute the following command to launch an instance of Firefox attached to the GTP interface:

```bash
$ cd /UERANSIM/build
$ ./nr-binder 172.45.1.2 firefox
```
(for UE 1)

```bash
$ cd /UERANSIM/build
$ ./nr-binder 172.45.1.3 firefox
```
(for UE 2)

In case the IP addresses assigned to the GTP interfaces do not match the above values, you can retrieve them with the following command:

```bash
$ ifconfig uesimtun0
```

## Destroying the scenario

```bash
$ cd scripts/
$ ./destroy.sh
```
