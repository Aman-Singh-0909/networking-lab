# Networking Lab — Kali Linux

Hands-on networking projects built from scratch on Kali Linux.
No calculators, no GUIs — just terminal and brain.

## Projects

### 1. Subnetting by Hand
Divided 192.168.1.0/24 into 8 equal /27 subnets manually using bit math.
- 3 bits borrowed → 8 subnets
- 30 usable hosts per subnet
- See: `subnetting/notes.md`

### 2. Wireshark Packet Capture
Captured a live ping (ICMP) and identified every OSI layer inside the packet.
- See: `wireshark/notes.md`

### 3. Inter-VLAN Routing Lab
Built two VLANs on a single Kali machine and routed traffic between them manually.

**Topology:**

**Run the lab:**
```bash
sudo bash vlans/setup.sh
sudo ip netns exec host1 ping 192.168.20.2 -c 4
```

**Tear it down:**
```bash
sudo bash vlans/teardown.sh
```

- See: `vlans/setup.sh` and `vlans/teardown.sh`

## Skills Demonstrated
- IP addressing and subnetting (/24 → /27)
- OSI model — identifying layers in real packets
- Linux networking commands (ip link, ip addr, ip route, ip netns)
- VLAN configuration on Linux
- Virtual ethernet pairs (veth)
- Network namespaces to simulate hosts
- Inter-VLAN routing with Linux as a router
- Packet capture and analysis with Wireshark

## Environment
- OS: Kali Linux
- Tools: iproute2, Wireshark, bash
