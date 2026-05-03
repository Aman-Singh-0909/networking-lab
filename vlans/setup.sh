#!/bin/bash
# Inter-VLAN Routing Lab
# Two VLANs connected through a Linux router (Kali)
# VLAN 10: 192.168.10.0/27 | VLAN 20: 192.168.20.0/27

echo "[*] Enabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=1

echo "[*] Creating VLAN interfaces on Kali..."
ip link add link eth0 name eth0.10 type vlan id 10
ip link add link eth0 name eth0.20 type vlan id 20
ip link set eth0.10 up
ip link set eth0.20 up

echo "[*] Creating network namespaces (simulated hosts)..."
ip netns add host1
ip netns add host2

echo "[*] Creating virtual ethernet cable pairs..."
ip link add veth10a type veth peer name veth10b
ip link add veth20a type veth peer name veth20b

echo "[*] Moving one end of each cable into each namespace..."
ip link set veth10b netns host1
ip link set veth20b netns host2

echo "[*] Assigning gateway IPs to Kali..."
ip addr add 192.168.10.1/27 dev veth10a
ip addr add 192.168.20.1/27 dev veth20a
ip link set veth10a up
ip link set veth20a up

echo "[*] Configuring host1 (VLAN 10)..."
ip netns exec host1 ip addr add 192.168.10.2/27 dev veth10b
ip netns exec host1 ip link set veth10b up
ip netns exec host1 ip link set lo up
ip netns exec host1 ip route add default via 192.168.10.1

echo "[*] Configuring host2 (VLAN 20)..."
ip netns exec host2 ip addr add 192.168.20.2/27 dev veth20b
ip netns exec host2 ip link set veth20b up
ip netns exec host2 ip link set lo up
ip netns exec host2 ip route add default via 192.168.20.1

echo "[+] Done! Test with:"
echo "    sudo ip netns exec host1 ping 192.168.20.2 -c 4"
