# dig — DNS Lookup Tool

## Simple lookup
```bash
dig google.com
```

## Full trace from root servers
```bash
dig +trace google.com
```

## Ask a specific DNS server
```bash
dig @8.8.8.8 google.com
```

## Record types
```bash
dig google.com A    # IPv4 address
dig google.com MX   # mail servers
dig google.com NS   # nameservers
dig google.com TXT  # text records
```

## DNS resolution journey (from +trace)
1. Root servers (a-m.root-servers.net) → "ask .com servers"
2. .com TLD servers (gtld-servers.net) → "ask Google's servers"  
3. Google's nameservers (ns1-4.google.com) → "here is the IP!"

## Key fields in output
- TTL: how long to cache the answer (seconds)
- A record: IPv4 address
- NS record: nameserver
- Query time: how fast DNS responded
- SERVER: which DNS server answered
