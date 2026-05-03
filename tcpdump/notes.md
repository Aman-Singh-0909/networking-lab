# tcpdump — Capturing TCP SYN Packets

## What is a TCP SYN?
The first packet of every TCP connection. Flags [S] only.
Part of the 3-way handshake: SYN → SYN-ACK → ACK

## Command
```bash
sudo tcpdump -i eth0 'tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack == 0' -n
```

## Filter breakdown
- tcp[tcpflags] & tcp-syn != 0  → SYN bit must be ON
- tcp[tcpflags] & tcp-ack == 0  → ACK bit must be OFF
- -n → show IPs not hostnames (faster, no DNS lookups)

## Sample captured packet
- Source: 10.0.2.15 (Kali) port 51248 (random ephemeral port)
- Dest: 142.250.193.142 (Google) port 443 (HTTPS)
- [S] = SYN only = start of handshake
- seq = initial sequence number
- win = receive window size (flow control)

## Save to file
```bash
sudo tcpdump -i eth0 'tcp[tcpflags] & tcp-syn != 0' -w syn_capture.pcap
```
