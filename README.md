# Containerized testbeds for cellular mobile communications networks

**NOTE:** Currently work-in-progress. README will be updated whenever a bare minimum scenario can be fully deployed and tested.

## Capturing traffic with Wireshark
```
$ sudo ip netns exec <clab-container-name> tcpdump -l -nni <container-iface> -w - | wireshark -k -i -
```

