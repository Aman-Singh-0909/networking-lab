# Subnetting 192.168.1.0/24 into 8 Subnets

## The Math
- Original network: 192.168.1.0/24 (256 addresses)
- Need 8 subnets → 2³ = 8 → borrow 3 bits
- New prefix: /24 + 3 = /27
- Addresses per subnet: 2⁵ = 32
- Usable hosts per subnet: 32 - 2 = 30

## The 8 Subnets

| # | Network      | Usable Range              | Broadcast      | Mask |
|---|-------------|---------------------------|----------------|------|
| 1 | 192.168.1.0  | 192.168.1.1 – 192.168.1.30   | 192.168.1.31   | /27  |
| 2 | 192.168.1.32 | 192.168.1.33 – 192.168.1.62  | 192.168.1.63   | /27  |
| 3 | 192.168.1.64 | 192.168.1.65 – 192.168.1.94  | 192.168.1.95   | /27  |
| 4 | 192.168.1.96 | 192.168.1.97 – 192.168.1.126 | 192.168.1.127  | /27  |
| 5 | 192.168.1.128| 192.168.1.129 – 192.168.1.158| 192.168.1.159  | /27  |
| 6 | 192.168.1.160| 192.168.1.161 – 192.168.1.190| 192.168.1.191  | /27  |
| 7 | 192.168.1.192| 192.168.1.193 – 192.168.1.222| 192.168.1.223  | /27  |
| 8 | 192.168.1.224| 192.168.1.225 – 192.168.1.254| 192.168.1.255  | /27  |

## Key Rules
- Subnet jump = 32 (just keep adding 32)
- Network address = first IP of each block (never assign)
- Broadcast = last IP of each block (never assign)
- Usable hosts = 2^(host bits) - 2
