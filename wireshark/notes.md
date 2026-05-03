# Wireshark — Capturing and Analysing a Ping

## What We Captured
- Protocol: ICMP (ping)
- Target: 8.8.8.8 (Google DNS)
- Tool: Wireshark on Kali Linux

## How to Capture
1. Open Wireshark: `sudo wireshark`
2. Select your interface (eth0 or wlan0)
3. Set display filter: `icmp`
4. In a second terminal run: `ping -c 4 8.8.8.8`
5. Watch packets appear in real time

## Layers Visible in Each Packet

| Layer | Name in Wireshark | What it shows |
|-------|------------------|---------------|
| 1 - Physical   | Frame N          | Size, arrival time, raw bits |
| 2 - Data Link  | Ethernet II      | Source MAC → Destination MAC |
| 3 - Network    | Internet Protocol| Source IP → Destination IP |
| 4 - Transport  | (none for ICMP)  | ICMP sits above IP directly |
| 5/7 - App-ish  | ICMP             | Type 8 = request, Type 0 = reply |

## Key ICMP Fields
- Type 8 = Echo Request (you sending)
- Type 0 = Echo Reply (Google replying)
- Sequence number: counts each ping (1, 2, 3, 4)
- TTL: how many routers the packet can pass through before dying

## Save Your Capture
File → Save As → ping_capture.pcap
