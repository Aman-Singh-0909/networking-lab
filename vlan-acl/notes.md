# VLAN Segmentation with ACLs + Lateral Movement Lab

## Topology
## Security Policy
| Source | Destination | Rule |
|--------|-------------|------|
| Users | Servers | ✅ ALLOWED |
| Users | Management | ❌ BLOCKED |
| Servers | Users | ❌ BLOCKED |
| Servers | Management | ❌ BLOCKED |
| Management | Anywhere | ✅ ALLOWED |

## iptables Rules
```bash
## Security Policy
| Source | Destination | Rule |
|--------|-------------|------|
| Users | Servers | ✅ ALLOWED |
| Users | Management | ❌ BLOCKED |
| Servers | Users | ❌ BLOCKED |
| Servers | Management | ❌ BLOCKED |
| Management | Anywhere | ✅ ALLOWED |

## iptables Rules
```bash
# Default deny all forwarded traffic
sudo iptables -P FORWARD DROP

# Allow established connections
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow Users → Servers
sudo iptables -A FORWARD -s 10.10.10.0/24 -d 10.20.20.0/24 -j ACCEPT

# Allow Management → everywhere
sudo iptables -A FORWARD -s 10.30.30.0/24 -j ACCEPT

# Log and drop everything else
sudo iptables -A FORWARD -j LOG --log-prefix "VLAN-BLOCKED: "
sudo iptables -A FORWARD -j DROP
```

## Lateral Movement Demo
Before ACLs — USER could ping MGMT (10.30.30.2) ✅
After ACLs — USER ping MGMT = 100% packet loss ❌
This proves ACLs successfully block lateral movement.

## Key commands
```bash
# View rules with counters
sudo iptables -L FORWARD -v --line-numbers

# Flush all rules (reset)
sudo iptables -F
sudo iptables -P FORWARD ACCEPT
```

## Key insight
Default deny + explicit allow = defence in depth.
Even if an attacker compromises a user machine,
they cannot reach management infrastructure.
