#!/bin/bash
# Tears down the entire VLAN lab cleanly

echo "[*] Deleting namespaces..."
ip netns del host1 2>/dev/null
ip netns del host2 2>/dev/null

echo "[*] Deleting veth pairs..."
ip link del veth10a 2>/dev/null
ip link del veth20a 2>/dev/null

echo "[*] Deleting VLAN interfaces..."
ip link del eth0.10 2>/dev/null
ip link del eth0.20 2>/dev/null

echo "[+] Lab torn down cleanly."
