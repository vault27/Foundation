# Switching

## vPC
- Virtual port channel
- Active-active dual homed host connection
- Cisco technology for Nexus = MLAG, MCLAG
- The same as VSS on Catalyst, but more reliable
- Two switches maximum the same as in MLAG
- BUM traffic is replicated via peer link

### Components
- Peer link - LAG - no traffic - CFS Cisco protocol - sync vPC config + MAC table + ARP table
- Peer keep alive link - maybe virtual - used only for heartbeat - recomended to use physical in separate VRF - mgmt0 interface can be used - every second - UDP 3200 - SVI interface and loopback are not recomended
- vPC domain - all about 2 switches - has a number - it influences virtual MAC
- Peer - praimary and secondary role according to priority - configured manually or 32000+MAC - manual is recomended. Operational status - primary or secondary, it can be different from role - transfers VLANs, CFS messages, BUM. VLANS on vPC should be allowed on this link
- Member port - vPC port
- vPC - supports static and LACP - L2 only - trunk or access - configured as regular port channel - hust specify vPC number in it
- Orphan port - host is connected only to one switch
- Peer switch - feature - when it is enabled - both nodes reply to BPDU, not only primary - frpm STP point of view it is one logical box
- Peer gateway - feature - when it is enabled  - one vPC peer to locally route packets destined to the MAC address of the other vPC peer such that packets destined to the remote vPC peer do not need to egress the vPC Peer-Link in order to be routed - so secondary routes packets intended to primary
- 
