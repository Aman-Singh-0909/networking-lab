# hping3 — Crafting Custom TCP Packets

## What is hping3?
A raw packet crafting tool. Bypasses the OS TCP stack completely.
You decide every flag, port, and sequence number manually.

## Commands used

### Send SYN packets (like a connection attempt)
```bash
sudo hping3 -S -p 80 -c 3 example.com
```
-S = SYN flag, -p = port, -c = count

### Send SYN-ACK (impersonate a server response)
```bash
sudo hping3 -SA -p 80 -c 3 example.com
```
-SA = SYN + ACK flags simultaneously

### Send FIN (politely close non-existent connection)
```bash
sudo hping3 -F -p 80 -c 3 example.com
```
-F = FIN flag. Used in firewall probing.

### NULL scan (no flags at all)
```bash
sudo hping3 -p 80 -c 3 example.com
```
No flags. Closed ports reply RST. Open ports stay silent.

## What we observed in Wireshark
Pattern: SYN → SYN-ACK → RST → SYN → SYN-ACK → RST...

Why RST appears:
hping3 sends raw packets bypassing the OS.
When server replies with SYN-ACK, the OS sees it and thinks
"I never sent a SYN!" so it fires back RST automatically.

## Real world use
This pattern (SYN → SYN-ACK → RST) is exactly how nmap -sS works.
Called a half-open or stealth scan — never completes the handshake,
harder to detect in logs than a full connection.

## Flag reference
| Flag | hping3 option | Meaning |
|------|--------------|---------|
| SYN  | -S           | Start connection |
| ACK  | -A           | Acknowledge |
| FIN  | -F           | End connection |
| RST  | -R           | Reset/abort |
| PSH  | -P           | Push data immediately |
| URG  | -U           | Urgent data |
