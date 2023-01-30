# Palo Alto

## Portfolio
- Strata - Enterprise Security
- Prisma - Cloud Security
- Cortex - Security Operations

### Strata
- PA-220, PA-800, PA-3200, PA-5200, and PA-7000 Series
- VM-Series
- Panorama

### Prisma
- Prisma Cloud
- Prisma Access Secure Access Service Edge (SASE)
- Prisma SaaS
- VM-Series ML-powered NGFWs

### Cortex
- Cortex XDR
- Cortex XSOAR
- Cortex Data Lake
- AutoFocus

### NGFW
- App-ID
- Content-ID
- User-ID
- Decryption
- Antivirus
- Anti-Spyware
- Vulnerability Protection
- URL filtering
- File blocking
- Wildfire
- Traps
- DoS
- Data Filtering

## Firewall components

### Zones
- Route based firewall - zones are simply an architectural or topological concept that helps identify which areas comprise the global network
- Zone absed firewall - use zones as a means to internally classify the source and destination in its state table  
  
- One zone per interface
- Intrazone traffic is allowed by default
- Interzone traffic is denied by default
- Rules can use these defined zones to allow or deny traffic, apply Quality of Service (QoS) policies, or perform network address translation (NAT)
- If the source zone has a protection profile associated with it, the packet is evaluated against the profile configuration
- Destination zone is determined by checking the Policy-Based Forwarding (PBF) rules and if no results are found, the routing table is consulted
- Lastly, the NAT policy is evaluated as the destination IP may be changed by a NAT rule action, thereby changing the destination interface and zone in the routing table. This would require a secondary forwarding lookup to determine the post-NAT egress interface and zone

### Security policy
- GlobalProtect Host Information Profile (HIP)
- Security zones
- Source and destination IP addresses
- Source and destination devices
- App-ID
- Source user (User-ID)
- Service (port)
- URL
- Security Profiles (Content-ID) - use signatures to identify known threats. Unknown threats are identified by WildFire

## HA
- Up to 16 firewalls as peer members of an HA cluster
- Active firewall has less priority
- Firewall-specific configuration such as management interface IP address or administrator profiles, HA specific configuration, log data, and the Application Command Center (ACC) information is not shared between peers

### The conditions that trigger a failover are:
- One or more of the monitored interfaces fail (Link Monitoring)
- One or more of the destinations specified on the firewall cannot be reached (Path Monitoring)
- The firewall does not respond to heartbeat polls (Heartbeat Polling and Hello messages)
- A critical chip or software component fails, known as packet path health monitoring

### HA prerequisites
- Model
- PAN-OS version
- UP-to-date application, URL, threat databases
- HA unterfaces types
- Licenses
- Slot configuration
- For VMs: HYpervisor, number of CPU cores

### Links
7 Links in total
- HA-1 control link - hello, heartbeats, HA state info, User-ID, config sync, L3 link, requires IP. ICMP is used to exchange heartbeats between HA peers. Ports used for HA1 — TCP port 28769 and 28260 for clear text communication; port 28 for encrypted communication (SSH over TCP) - Control Plane
- HA-2 data link - seesion info, forwarding tables, IPSec, ARP. Data flow on the HA2 link is always unidirectional (except for the HA2 keep-alive); it flows from the active or active-primary firewall to the passive or active-secondary firewall. The HA2 link is a Layer 2 link, and it uses ether type 0x7261 by default. Ports used for HA2—The HA data link can be configured to use either IP (protocol number 99) or UDP (port 29281) as the transport, and thereby allow the HA data link to span subnets - Data plane
- HA1 and HA2 Backup Links - Provide redundancy for the HA1 and the HA2 links. In-band ports can be used for backup links for both HA1 and HA2 connections when dedicated backup links are not available. Consider the following guidelines when configuring backup HA links: The IP addresses of the primary and backup HA links must not overlap each other, HA backup links must be on a different subnet from the primary HA links, HA1-backup and HA2-backup ports must be configured on separate physical ports, The HA1-backup link uses port 28770 and 28260, PA-3200 Series firewalls don’t support an IPv6 address for the HA1-backup link; use an IPv4 address
- HA3 - for active/active - The firewalls use this link for forwarding packets to the peer during session setup and asymmetric traffic flow. The HA3 link is a Layer 2 link that uses MAC-in-MAC encapsulation. It does not support Layer 3 addressing or encryption. You cannot configure backup links for the HA3 link, only LAG. The firewall adds a proprietary packet header to packets traversing the HA3 link, so the MTU over this link must be greater than the maximum packet length forwarded. Jumbo frames!
- HA4 - session cache synchronization among all HA cluster members having the same cluster ID
- HA4 BAckup

### Active/Passive
Configuration overview

#### Firewall states
- Initial - after boot-up and before it finds peer
- Active - normal traffic handling state
- Passive - normal traffic is discarded, except LACP and LLDP
- Suspended - administratively disabled
- Non Functional - error state

### Active/Active
4 types of design:
- Floating IP Address and Virtual MAC Address
- Floating IP Address Bound to Active-Primary Firewall
- Route-Based Redundancy
- ARP Load-Sharing

#### Virtual MAC address
- Manually configure different gateways on end systems or use load balancers
- Each firewall in the HA pair creates a virtual MAC address for each of its interfaces that has a floating IP address or ARP Load-Sharing IP address
- After the failed firewall recovers, by default the floating IP address and virtual MAC address move back to firewall with the Device ID [0 or 1] to which the floating IP address is bound
- When a new active firewall takes over, it sends gratuitous ARPs from each of its connected interfaces to inform the connected Layer 2 switches of the new location of the virtual MAC address. 

#### Route based redundancy
- Firewalls are connected  to routers, not switches
- Each firewall has separate IP addresses, sessions are synced
- If firewall fails, then based on routing protocol traffic is not sent to it
- No need to configure virtual MAC address/floating IP address, arp load sharing, failover conditions
<img width="602" alt="image" src="https://user-images.githubusercontent.com/116812447/215494580-eeaed00c-52a0-479c-b8db-909f8cce27fc.png">

#### ARP load sharing
- Use only when firewall is default gateway for end hosts
- Everytime different firewall replies on ARP request with its own virtual MAC, IP is the same for both firewalls
- ARP load sharing on LAN side and floating IP on the other

### Cluster

#### Configuration overview
- 2 HA4 interfaces(primary and backup) with type HA, IP address, mask
- On every device add all over devices with serial number, HA4 and HA4 backup IP addresses and sessions sync
- Enable cluster on all devices with the same cluster ID

#### Concepts
- Zone names should be identical
- All appliances should be configured on all devices with HA4 IP addresses
- Session is logged on that device, where it ended
- On Passive devices cluster is inactive
- TCP handshake should pass one firewall, otherwise asymmetric path bypass should enabled on internal zone
- Security checks cannot be done with asymmetric

#### Cluster Session Synchronization States  
- Pending → Synchronization is not triggered yet
- Unknown. → Device Serial Number and Peer IP is configured but session synchronization process has not started yet
- In-Progress  → Full session synchronization is running 
- Completed  → Full session synchronization is completed and new sessions will be synchronized in real time 
- Disabled → Session synchronization is disabled to the member or for HA peer

Show logs about HA4 sessions sync
```
show log system | match ha4
```

