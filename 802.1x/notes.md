# 802.1X Port Authentication with FreeRADIUS

## What is 802.1X?
Port-based network access control. Devices must authenticate
before getting any network access. Used in enterprise WiFi and
wired switch ports.

## Three components
| Role | Component | What it does |
|------|-----------|-------------|
| Supplicant | Device | Provides credentials |
| Authenticator | Switch/AP | Forwards auth to RADIUS |
| Auth Server | RADIUS | Accepts or rejects |

## Lab setup
- Tool: FreeRADIUS 3.0
- Test client: radtest
- Port: UDP 1812 (RADIUS authentication)
- Shared secret: testing123

## Users file location
/etc/freeradius/3.0/users

## User entries (TAB required between username and Cleartext-Password)
cat > ~/networking-lab/802.1x/notes.md << 'EOF'
# 802.1X Port Authentication with FreeRADIUS

## What is 802.1X?
Port-based network access control. Devices must authenticate
before getting any network access. Used in enterprise WiFi and
wired switch ports.

## Three components
| Role | Component | What it does |
|------|-----------|-------------|
| Supplicant | Device | Provides credentials |
| Authenticator | Switch/AP | Forwards auth to RADIUS |
| Auth Server | RADIUS | Accepts or rejects |

## Lab setup
- Tool: FreeRADIUS 3.0
- Test client: radtest
- Port: UDP 1812 (RADIUS authentication)
- Shared secret: testing123

## Users file location
/etc/freeradius/3.0/users

## User entries (TAB required between username and Cleartext-Password)
## Test commands
```bash
# Should get Access-Accept
radtest authorised-device correct-password 127.0.0.1 0 testing123

# Should get Access-Reject
radtest rogue-device anything 127.0.0.1 0 testing123
```

## Results
- authorised-device → Access-Accept ✅ (correct credentials)
- rogue-device → Access-Reject ❌ (explicitly blacklisted)

## Real world usage
- Enterprise WiFi (WPA2-Enterprise)
- Switch port authentication
- VPN authentication
- Guest network isolation

## Key insight
802.1X stops rogue devices at the port level — before
they get an IP address. Even if an attacker plugs into
a physical port, they get nothing without valid credentials.
This is why enterprise networks are hard to infiltrate
just by finding an open network port.

## Start FreeRADIUS in debug mode
```bash
sudo freeradius -X
```
