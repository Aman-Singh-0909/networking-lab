# Wireshark — Full TCP Session + State Machine

## What we captured
- Tool: Wireshark on Kali Linux
- Target: example.com (HTTP port 80)
- Filter: tcp and (ip.addr == 172.66.147.243 or ip.addr == 104.20.23.154)

## TCP State Machine mapped to real packets

| Packet | Flags      | Direction        | TCP State        |
|--------|------------|------------------|------------------|
| 1      | SYN        | you → server     | SYN_SENT         |
| 2      | SYN-ACK    | server → you     | SYN_RECEIVED     |
| 3      | ACK        | you → server     | ESTABLISHED ✅   |
| 4      | HTTP GET   | you → server     | data transfer    |
| 5      | ACK        | server → you     | data transfer    |
| 6      | HTTP 200   | server → you     | data transfer    |
| 7      | ACK        | you → server     | data transfer    |
| 8      | FIN-ACK    | you → server     | FIN_WAIT_1       |
| 9      | ACK        | server → you     | FIN_WAIT_2       |
| 10     | FIN-ACK    | server → you     | LAST_ACK         |
| 11     | ACK        | you → server     | TIME_WAIT→CLOSED |

## The 3-way handshake
SYN → SYN-ACK → ACK
Your machine knocks, server answers, you confirm. Connection established.

## The 4-way teardown
FIN → ACK → FIN → ACK
Each side closes independently. Both must agree to terminate.

## Key insight
TCP is stateful — every packet has a sequence number.
The receiver always ACKs what it got. If ACK never arrives, sender retransmits.
