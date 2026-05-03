# Simulating Packet Loss + TCP Retransmission

## Tool used
tc (traffic control) with netem (network emulator) — built into Linux

## Add 50% packet loss
```bash
sudo tc qdisc add dev eth0 root netem loss 50%
```
Randomly drops half of all outgoing packets on eth0.

## Remove packet loss
```bash
sudo tc qdisc del dev eth0 root
```

## What we observed in Wireshark

| Packet colour | Meaning |
|--------------|---------|
| Normal (white/green) | Packet delivered fine |
| Red — TCP Retransmission | Packet was lost, TCP resending |
| Red — Previous segment not captured | Wireshark missed a packet (gap in sequence numbers) |

## TCP retransmission behaviour
1. Sender sends packet
2. Waits for ACK
3. ACK never arrives (packet dropped)
4. Retransmission timeout (RTO) fires — ~1 second
5. Sender resends same packet
6. If still no ACK — waits 2 seconds, resends
7. Then 4 seconds, 8 seconds, 16 seconds...
This doubling is called EXPONENTIAL BACKOFF

## Key insight
TCP guarantees delivery. It will keep retransmitting forever
(up to a limit) until the other side acknowledges receipt.
This is why TCP is reliable but slow on bad networks.
UDP does NOT retransmit — faster but no guarantee.

## Timing from our capture
- HTTP 200 OK arrived at 14.288s
- First retransmission at 15.786s (1.5s gap = RTO fired)
- Second retransmission at 16.580s
TCP refused to give up until every packet was delivered.

## Other netem options worth knowing
```bash
# Add network delay
sudo tc qdisc add dev eth0 root netem delay 200ms

# Add delay + packet loss together
sudo tc qdisc add dev eth0 root netem delay 100ms loss 20%

# Add packet corruption
sudo tc qdisc add dev eth0 root netem corrupt 10%

# Always remove when done!
sudo tc qdisc del dev eth0 root
```
