# ss — Socket Statistics

## Most useful command
```bash
sudo ss -tlnp
```
Flags: -t TCP, -l listening only, -n port numbers, -p show process

## Output explained
| Column | Meaning |
|--------|---------|
| State | LISTEN = waiting for connections |
| Recv-Q | packets waiting to be processed |
| Send-Q | buffer size |
| Local Address:Port | where it's listening |
| Process | which program owns this socket |

## Address types
| Address | Exposed to |
|---------|-----------|
| 127.0.0.1 | localhost only |
| 0.0.0.0 | all IPv4 interfaces |
| [::] | all IPv6 interfaces |

## Services found on Kali
- 127.0.0.1:9050 → Tor proxy (localhost only, safe)
- 0.0.0.0:22 → SSH (network-wide, intentional)
