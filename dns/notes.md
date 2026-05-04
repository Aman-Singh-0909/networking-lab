# DNS Deep Dive — Zone Transfers and Full Trace

## Tool: dig

### Full DNS trace from root servers
```bash
dig +trace cloudflare.com
```
Shows 3 levels:
1. Root servers (.) → "ask .com servers"
2. .com TLD servers → "ask cloudflare's nameservers"
3. cloudflare's nameservers → "here is the IP"

### DNS record types
| Type  | Meaning |
|-------|---------|
| A     | IPv4 address |
| AAAA  | IPv6 address |
| MX    | Mail server |
| NS    | Nameserver |
| TXT   | Text (SPF, verification, info) |
| CNAME | Alias to another name |
| SOA   | Start of Authority (zone info) |
| PTR   | Reverse DNS (IP → name) |
| SRV   | Service location |
| HINFO | Host info (hardware + OS) |

## Zone Transfer Attack (AXFR)

### What is it?
DNS servers sync records between primary and backup using AXFR.
Misconfigured servers allow ANYONE to request a full zone dump.

### Command
```bash
dig axfr @nsztm1.digi.ninja zonetransfer.me
```

### What we got from zonetransfer.me (52 records!)
- Internal office IPs (Canberra, DC)
- VPN server address
- OWA (Outlook Web Access) server
- Staging and testing servers
- Email provider (Google)
- Staff contact details (name + phone)
- OS/hardware info (Windows XP!)
- Intentional examples: SQLi, XSS, Shellshock payloads

### Why this is dangerous
An attacker gets complete internal network map without touching the target.
No port scanning needed — DNS does the reconnaissance for free.

### Real world impact
- Find staging servers (less secure than production)
- Identify VPN endpoints to attack
- Find internal hostnames for lateral movement
- Harvest staff contacts for phishing
- Identify technology stack

### How to defend
In BIND DNS config:
In Windows DNS: Right-click zone → Properties → Zone Transfers
→ Only allow to listed servers

### Testing if a server is vulnerable
```bash
dig axfr @<nameserver> <domain>
```
If it returns records → vulnerable
If it returns "Transfer failed" → properly secured

## Key insight
Zone transfer is passive reconnaissance — you never touch the target's
web servers, just query their DNS. Completely legal to test on your
own domains. Always get written permission before testing others.
