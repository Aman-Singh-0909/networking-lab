# OSPF Lab — 3 Router Topology with FRRouting

## Topology
## Tools used
- FRRouting (FRR) 10.6.1
- Linux network namespaces (R1, R2, R3)
- Virtual ethernet pairs (veth)

## Key concepts
- OSPF router-id: unique identifier per router (1.1.1.1, 2.2.2.2, 3.3.3.3)
- Area 0: backbone area — all routers must connect through it
- /30 subnets: perfect for point-to-point router links (2 usable IPs)
- IP forwarding: must be enabled on middle routers (sysctl net.ipv4.ip_forward=1)

## What OSPF does automatically
1. Routers send Hello packets to discover neighbors
2. Neighbors exchange Link State Advertisements (LSAs)
3. Each router builds a complete map of the network (LSDB)
4. Each router runs Dijkstra's algorithm to find best paths
5. Best paths installed into kernel routing table (proto ospf)

## Commands used

### Setup namespaces and links
```bash
sudo ip netns add R1 && sudo ip netns add R2 && sudo ip netns add R3
sudo ip link add veth12a type veth peer name veth12b
sudo ip link add veth23a type veth peer name veth23b
sudo ip link set veth12a netns R1
sudo ip link set veth12b netns R2
sudo ip link set veth23a netns R2
sudo ip link set veth23b netns R3
```

### Assign IPs
```bash
sudo ip netns exec R1 ip addr add 10.0.12.1/30 dev veth12a
sudo ip netns exec R2 ip addr add 10.0.12.2/30 dev veth12b
sudo ip netns exec R2 ip addr add 10.0.23.1/30 dev veth23a
sudo ip netns exec R3 ip addr add 10.0.23.2/30 dev veth23b
```

### Enable IP forwarding on middle router
```bash
sudo ip netns exec R2 sysctl -w net.ipv4.ip_forward=1
```

### Start FRR daemons inside each namespace
```bash
sudo ip netns exec R1 /usr/lib/frr/zebra -d -f /etc/frr/R1/frr.conf -i /tmp/zebra-R1.pid -z /tmp/zebra-R1.sock
sudo ip netns exec R1 /usr/lib/frr/ospfd -d -f /etc/frr/R1/frr.conf -i /tmp/ospfd-R1.pid -z /tmp/zebra-R1.sock
```

### Verify OSPF learned routes
```bash
sudo ip netns exec R1 ip route
# Look for: proto ospf — these are OSPF-learned routes!
```

### Test end-to-end (R1 → R3, two hops)
```bash
sudo ip netns exec R1 ping 10.0.23.2 -c 4
```

## Key insight
OSPF installs routes automatically — no static routes needed.
If a link goes down, OSPF reconverges and reroutes within seconds.
This is how every enterprise network and ISP backbone works.
