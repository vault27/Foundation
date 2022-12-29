# VxLAN
- RFC 7348
- Virtual Extensible LAN, MAC in UDP encapsulation, port 4789
- ECMP based on source UDP port calculation, source UDP port of each tunneled packet is derived from a hash of the customer inner packet. That is why UDP is used, not IP for example.

## Components
- Identifier - VN Identifier - VNID - defines broadcast segment
- NVE - Network Virtualization Edge - interface where VXLAN ends
- VTEP - VXLAN Tunnel Endpoint - Nexus - Leaf
