# Switching

## vPC
- Virtual port channel
- Active-active dual homed host connection
- Cisco technology for Nexus = MLAG, MCLAG
- The same models and soft
- The same as VSS on Catalyst, but more reliable
- Two switches maximum the same as in MLAG
- BUM traffic is replicated via peer link
- Configs on both switches should be consistent

### Components
- Peer link - LAG - no traffic - CFS Cisco protocol - sync vPC config + MAC table + ARP table - 2 High speed links are used - 40/100 Gbits
- Peer keep alive link - maybe virtual - used only for heartbeat - recomended to use physical in separate VRF - mgmt0 interface can be used - every second - UDP 3200 - SVI interface and loopback are not recomended
- vPC domain - all about 2 switches - has a number - it influences virtual MAC
- Peer - praimary and secondary role according to priority - configured manually or 32000+MAC - manual is recomended. Operational status - primary or secondary, it can be different from role - transfers VLANs, CFS messages, BUM. VLANS on vPC should be allowed on this link
- Member port - vPC port
- vPC - supports static and LACP - L2 only - trunk or access - configured as regular port channel - hust specify vPC number in it
- Orphan port - host is connected only to one switch
- Peer switch - feature - when it is enabled - both nodes reply to BPDU, not only primary - from STP point of view it is one logical box - very useful when we have back to back connection between 2 vPC
- Peer gateway - feature - when it is enabled  - one vPC peer to locally route packets destined to the MAC address of the other vPC peer such that packets destined to the remote vPC peer do not need to egress the vPC Peer-Link in order to be routed - so secondary routes packets intended to primary
- ARP/ND - synchronise - by default ARP tables are not synced - to avoid small traffic black holing

### Consistency checks
Type 1
- Interface parametres - Secondary switch shuts down vPC ports
- Global parametres - Secondary switch suspends affected ports
- STP mode, STP VLAN state, STP global settings, LACP mode, MTU

Type 2
- In case of inconsistency there is no service interaption
- Unpredictible traffic behavior is possible
- VLAN interface (SVI), ACL, QOS, IGMP snooping, HSRP
