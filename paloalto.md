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
- HA-2 data link - seesion info, forwarding tables, IPSec, ARP. Data flow on the HA2 link is always unidirectional (except for the HA2 keep-alive); it flows from the active or active-primary firewall to the passive or active-secondary firewall. The HA2 link is a Layer 2 link, and it uses ether type 0x7261 by default.Ports used for HA2—The HA data link can be configured to use either IP (protocol number 99) or UDP (port 29281) as the transport, and thereby allow the HA data link to span subnets. - Data plane
- HA1 and HA2 Backup Links - Provide redundancy for the HA1 and the HA2 links. In-band ports can be used for backup links for both HA1 and HA2 connections when dedicated backup links are not available. Consider the following guidelines when configuring backup HA links: The IP addresses of the primary and backup HA links must not overlap each other, HA backup links must be on a different subnet from the primary HA links, HA1-backup and HA2-backup ports must be configured on separate physical ports, The HA1-backup link uses port 28770 and 28260, PA-3200 Series firewalls don’t support an IPv6 address for the HA1-backup link; use an IPv4 address.
- HA3 - for active/active - The firewalls use this link for forwarding packets to the peer during session setup and asymmetric traffic flow. The HA3 link is a Layer 2 link that uses MAC-in-MAC encapsulation. It does not support Layer 3 addressing or encryption. You cannot configure backup links for the HA3 link, only LAG. The firewall adds a proprietary packet header to packets traversing the HA3 link, so the MTU over this link must be greater than the maximum packet length forwarded. Jumbo frames!
- HA4 - session cache synchronization among all HA cluster members having the same cluster ID
- HA4 BAckup

### Active/Passive
Configuration overview

### Active/Active

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

