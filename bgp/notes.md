# BGP Lab — iBGP and eBGP with FRRouting

## Topology
## Key concepts

### Autonomous System (AS)
A network under one organisation's control with a unique AS number.
- AS 100 = our company (R1 + R2)
- AS 200 = another company (R3)

### iBGP vs eBGP
| Type | Meaning | Used between |
|------|---------|-------------|
| iBGP | internal BGP | Routers in the SAME AS |
| eBGP | external BGP | Routers in DIFFERENT AS |

### BGP uses TCP port 179
Unlike OSPF (which uses multicast), BGP opens a TCP connection
to each neighbor. This makes it reliable but slower to converge.

## FRR Config

### R1 (AS 100)
router bgp 100
bgp router-id 1.1.1.1
no bgp ebgp-requires-policy
neighbor 10.0.12.2 remote-as 100
address-family ipv4 unicast
network 10.0.12.0/30
neighbor 10.0.12.2 activate
### R2 (AS 100 — the border router)
router bgp 100
bgp router-id 2.2.2.2
no bgp ebgp-requires-policy
neighbor 10.0.12.1 remote-as 100
neighbor 10.0.23.2 remote-as 200
address-family ipv4 unicast
network 10.0.12.0/30
network 10.0.23.0/30
neighbor 10.0.12.1 activate
neighbor 10.0.23.2 activate
### R3 (AS 200 — different company)
router bgp 200
bgp router-id 3.3.3.3
no bgp ebgp-requires-policy
neighbor 10.0.23.1 remote-as 100
address-family ipv4 unicast
network 10.0.23.0/30
neighbor 10.0.23.1 activate
## Key commands

### Check BGP session status
```bash
sudo ip netns exec R2 vtysh -c "show bgp summary"
```
Look for: State = Established, PfxRcd > 0

### Check BGP learned routes
```bash
sudo ip netns exec R3 vtysh -c "show bgp ipv4 unicast"
```

### Check kernel routing table (proto bgp = BGP learned)
```bash
sudo ip netns exec R3 ip route
```

## What we proved
- R1 (AS 100) can ping R3 (AS 200) — 0% packet loss
- Routes cross AS boundaries automatically via eBGP
- No static routes typed — BGP learned everything
- proto bgp visible in kernel routing table

## Key insight
BGP is the protocol of the internet. Every time you visit a website,
your ISP uses eBGP to exchange routes with that website's ISP.
The entire internet is held together by BGP sessions just like this one.
