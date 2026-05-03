# Networking Lab — Kali Linux

Hands-on networking projects built from scratch on Kali Linux.
No calculators, no GUIs — just terminal and brain.

## Projects

### 1. Subnetting by Hand
Divided 192.168.1.0/24 into 8 equal /27 subnets manually using bit math.
- 3 bits borrowed → 8 subnets → 30 usable hosts each
- See: `subnetting/notes.md`

### 2. Wireshark — Packet Capture
Captured a live ping (ICMP) and identified every OSI layer inside the packet.
- See: `wireshark/notes.md`

### 3. Inter-VLAN Routing Lab
Built two VLANs on a single Kali machine and routed traffic between them manually.

**Topology:**
```
[host1: 192.168.10.2] ──veth──► [Kali Router] ◄──veth── [host2: 192.168.20.2]
        VLAN 10          192.168.10.1  192.168.20.1         VLAN 20
```

```bash
sudo bash vlans/setup.sh
sudo ip netns exec host1 ping 192.168.20.2 -c 4
sudo bash vlans/teardown.sh
```
- See: `vlans/setup.sh` and `vlans/teardown.sh`

### 4. tcpdump — Capturing TCP SYN Packets
Captured live TCP SYN packets in the terminal using raw filters.
- See: `tcpdump/notes.md`

### 5. ss — Socket Statistics
Found every listening service and the process that owns it.
Discovered Tor on 9050 (localhost only) and SSH on 22 (network-wide).
- See: `ss/notes.md`

### 6. dig — DNS Trace
Traced a full DNS resolution from root servers to authoritative servers.
Watched the 3-level hierarchy: root → .com TLD → google's nameservers.
- See: `dig/notes.md`

### 7. Wireshark — Full TCP Session + State Machine
Captured a complete TCP session and mapped every packet to the TCP state machine.
SYN → SYN-ACK → ACK → data → FIN → FIN → ACK
- See: `tcp-session/notes.md`

### 8. hping3 — Custom Packet Crafting
Hand-crafted TCP packets with specific flags (SYN, FIN, NULL, SYN-ACK).
Observed how the OS fires RST at unexpected SYN-ACKs — the basis of nmap stealth scans.
- See: `hping3/notes.md`

### 9. Packet Loss Simulation + TCP Retransmission
Used tc netem to drop 50% of packets and watched TCP retransmit with exponential backoff.
- See: `packet-loss/notes.md`

## Skills Demonstrated
- IP addressing and subnetting (/24 → /27 by hand)
- OSI model — identifying all layers in real packets
- Linux networking (ip link, ip addr, ip route, ip netns)
- VLAN configuration and inter-VLAN routing
- Virtual ethernet pairs and network namespaces
- Packet capture with Wireshark and tcpdump
- DNS resolution tracing with dig
- Service enumeration with ss
- Raw packet crafting with hping3
- Network emulation with tc netem
- TCP state machine — full session lifecycle
- TCP retransmission and exponential backoff

## Environment
- OS: Kali Linux (VirtualBox NAT)
- Tools: iproute2, Wireshark, tcpdump, hping3, dig, ss, curl, bash
