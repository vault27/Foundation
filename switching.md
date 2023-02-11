# Switching

## vPC
- Virtual port channel
- Active-active dual homed host connection
- Cisco technology for Nexus = MLAG, MCLAG
- The same as VSS on Catalyst, but more reliable
- Two switches maximum the same as in MLAG

### Components
- Peer link - LAG - no traffic - CFS Cisco protocol - sync vPC config + MAC table + ARP table
- Peer keep alive link - maybe virtual - used only for heartbeat - recomended to use physical in separate VRF - mgmt0 interface can be used - every second - UDP 3200 - SVI interface and loopback are not recomended
- vPC domain - all about 2 switches - has a number - it influences virtual MAC
- Peer - praimary and secondary role according to priority - configured manually or 32000+MAC - manual is recomended. Operational status - primary or secondary, it can be different from role - transfers VLANs, CFS messages, BUM
- Member port - vPC port
- vPC
- Orphan port - host is connected only to one switch
