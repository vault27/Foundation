# Palo Alto

## Portfolio

- Strata - Enterprise Security
- Prisma - Cloud Security
- Cortex - Security Operations

### Strata

- PA-220, PA-800, PA-3200, PA-5200, and PA-7000 Series
- VM-Series: 50, 100, 300, 500, 700
      - Amazon Web Services
      - Cisco ACI
      - Citrix NetScaler SDX
      - Google CloudPlatform
      - Kernel-based Virtual Machine (KVM)
      - Microsoft Azure and Microsoft Hyper-V
      - OpenStack
      - VMware ESXi, VMware NSX, and VMware vCloud Air
- Panorama

### Prisma

- Prisma Cloud - Cloud Security Posture Management (CSPM) - Prisma Cloud taps into the cloud providers’ APIs for read-only access to network traffic, user activity, and the configuration of systems and services.
      - Alibaba Cloud
      - Amazon Web Services
      - Docker EE
      - Google CloudPlatform
      - IBM Cloud
      - Kubernetes
      - Microsoft Azure
      - Rancher
      - Red Hat OpenShift
      - VMware Tanzu
- Prisma Access Secure Access Service Edge (SASE) - Users connect to Prisma Access to access the internet and cloud and data center applications safely, regardless of their location
- Prisma SaaS - multimode CASB service that allows you to govern any sanctioned software as a service (SaaS) application - complete visibility and granular enforcement across all user, folder, and file activity within the sanctioned SaaS applications
- VM-Series ML-powered NGFWs

### Cortex

Detection, investigation, automation, and response capabilities.
- Cortex XDR - Extended Detection and Response - detection and response platform that runs on integrated endpoint, network, and cloud data.  Immediate response actions. Define indicators of compromise (IOCs) and behavioral indicators of compromise (BIOCs).
- Cortex XSOAR - extended Security Orchestration, Automation, and Response - automate up to 95 percent of all of the response actions - gets data from XDR and Autofocus
- Cortex Data Lake - central log storage - Effortlessly run advanced artificial intelligence and ML with cloud-scale data - Constantly learn from new data sources to evolve defenses
- The following products can utilize Cortex Data Lake:
    - Prisma Access
    - Palo Alto Networks NGFWs and Panorama devices with the ability to connect to the cloud
service
    - Cortex XDR
    - Previous versions of Palo Alto Networks Traps for endpoint protection and response (now
Cortex XDR)
    - Traps running version 5.0+ with the Traps management service
- AutoFocus - cloud-based threat intelligence service - takes data from every where and provides it for XSOAR, XDR

## NGFW

- The Palo Alto Networks firewall was designed to use an efficient system known as next-generation processing. Next-generation processing enables packet evaluation, application identification, policy decisions, and content scanning in a single, efficient processing pass - Single Pass Architecture
- Zone based firewall
- Full hardware separate mgmt
- Best Practice Assessment (BPA) tool for Palo Alto Networks firewalls and Panorama. The two components of the BPA tool are the Security Policy Adoption Heatmap and the BPA assessment. The Heatmap **analyzes a Palo Alto Networks deployment**. The Heatmap can filter information by device groups, serial numbers, zones, areas of architecture, and other categories. The results chart the progress of security improvement toward a Zero Trust network.**The BPA assessment compares a firewall or Panorama configuration against best practices** and provides recommendations to strengthen the organization’s security posture by fully adopting the Palo Alto Networks prevention capabilities. More than 200 security checks are performed on the firewall or Panorama configuration

The Heatmap measures the adoption rate of the following Palo Alto Networks firewall features:
- WildFire
- Threat Prevention
- Anti-Spyware
- DNS Sinkhole
- Antivirus
- Vulnerability Protection
- URL Filtering
- File Blocking
- Data Filtering
- User-ID
- App-ID
- Service/Port
- Logging

Main features:
- App-ID
- Content-ID
- User-ID
- Device-ID

Features

- 6 Tulip stateful firewall
- App-ID - Scans traffic to identify the application involved, regardless of the protocol or port number used
- Content-ID - Scans traffic for security threats (e.g., data leak prevention and URL filtering, viruses, spyware, unwanted file transfers, specific data patterns, vulnerability attacks, and appropriate browsing access
- User-ID - Matches a user to an IP address (or multiple IP addresses
- Decryption
- Security profiles
  - Antivirus
  - Anti-Spyware - botnet
  - Vulnerability Protection - IPS
  - URL filtering - categories
  - File blocking - block files by types and applications
  - Wildfire - send file to cloud for check
  - Data Filtering - in files, patterns, credit card numbers
- Traps
- DoS - different protocols floods, port scans - can be configured for zone and in separate policy. In separate policy is configured per application using DOS profile
- NAT
- VPN
- QoS
- SD-WAN
- DHCP
- DNS-Proxy
- Routing
- Tags
- IP Tags
- VM Monitoring
- Dynamic Address Groups
- Dynamic Extrnal Lists
- XML API
- Device ID

Licenses

- Advanced Threat Protection
- Advanced URL filtering
- Global Protect
- Web Proxy
- DNS Security
- Support
- Wildfire
- IoT security
- Autofocus

IPv6 support

- Neighbor Discovery (ND) is enhanced
- The firewall by default runs NDP, which uses ICMPv6 packets to **discover and track the link-layer addresses** and status of neighbors on connected links
- Provision the IPv6 hosts with the Recursive DNS Server (RDNSS) option and DNS Search List (DNSSL) option, per RFC 6106, IPv6 Router Advertisement Options for DNS Configuration
- When you configure Layer 3 interfaces, you configure these DNS options on the firewall so it can provision the IPv6 hosts
- You don’t need a separate DHCPv6 server to provision the hosts
- The firewall sends IPv6 Router Advertisements (RAs) containing these options to the IPv6 hosts as part of their DNS configuration to fully provision them to reach internet services
- IPv6 hosts are configured with
    - The addresses of the RDNS servers that can resolve DNS queries
    - A list of domain names (suffixes) that the DNS client appends (one at a time) to an unqualified domain name before entering the domain name into a DNS query
- The IPv6 Router Advertisement for DNS configuration is supported for Ethernet interfaces, subinterfaces, Aggregated Ethernet interfaces, and Layer 3 VLAN interfaces on all of the PAN-OS platforms
- After you configure the firewall with the addresses of RDNS servers, the firewall provisions an IPv6 host (the DNS client) with those addresses
- An IPv6 Router Advertisement can contain multiple DNS Recursive Server Address options, each with the same or different lifetimes

Configuration of IPv6
- You enable IPv6 on interface
- You configure address
- You enable Duplicate Address Detection
- You enable  NDP Monitoring - you can view the IPv6 addresses of devices on the link local network, their MAC address, associated username from User-ID, eachability Status of the address, and Last Reported date and time the NDP monitor received a Router Advertisement from this IPv6 address
- You enable RA-Router Advertisment
- You enable DNS support - include DNS information in Router Advertisment: Recursive DNS servers and lifetime, suffixes and lifetime, lifetime - the maximum length of time the client can use the specific RDNS Server to resolve domain names

Artificial intelligence operations (AIOps)/Telemetry

- When enabled, Telemetry allows the firewall to collect and forward traffic information to Palo Alto Networks
- The data collected pertains to applications, threats, device health, and passive DNS information
- Data is sent to Cortex Data lake
- Device > Setup > Telemetry + enable Cortex Data Lake


## Zones

Firewall types
- Route based firewall - zones are simply an architectural or topological concept that helps identify which areas comprise the global network
- Zone based firewall - use zones as a means to internally classify the source and destination in its state table  
  
What we configure in zone:
- Log setting
- Type
- Interfaces
- Protection profile
- User-ID
- Device-ID

Zone types:
- L3
- L2
- Tap
- Virtualwire
- Tunnel

Concepts
- One zone per interface
- Zones are attached to a physical, virtual, or sub interface
- Intrazone traffic is allowed by default
- Interzone traffic is denied by default
- Rules can use these defined zones to allow or deny traffic, apply Quality of Service (QoS) policies, or perform network address translation (NAT)
- If the source zone has a protection profile associated with it, the packet is evaluated against the profile configuration
- Destination zone is determined by checking the Policy-Based Forwarding (PBF) rules and if no results are found, the routing table is consulted
- Lastly, the NAT policy is evaluated as the destination IP may be changed by a NAT rule action, thereby changing the destination interface and zone in the routing table. This would require a secondary forwarding lookup to determine the post-NAT egress interface and zone
- Remember that NAT policy evaluation happens after the initial zones have been determined, but before the security policy is evaluated
- Then Security Policy is checked
- It is best practice to use zones in all security rules and leveraging a clear naming convention
- Policy check relies on pre-NAT IP addresses
- Zone protection profile, flood protection: syn(random early drop - drops random syn packets, syn cookies - are always on) icmp, icmpv6, other ip, udp; reconnaissance - port scan, host sweep. All thresholds here are aggregate for all zone. + there is packet based protection. Then we apply it in zone configuration, usually for outside zone

Zone protection profile

- Flood protection
- Reconnaissance protection - port scans
- Packet based attack protection - check packet headers and drop undesirable
- Protocol protection - non-IP protocol-based attacks - block or allow non-IP protocols between security zones on a Layer 2 VLAN or on a virtual wire, or between interfaces within a single zone on a Layer 2 VLAN (Layer 3 interfaces and zones drop non-IP protocols so non-IP Protocol Protection doesn’t apply) - block is based on Ethertype field in Ethernet frame
- Ethernet SGT protection - droop traffic based on Security Group Tag (SGT) in Ethernet frame, when your firewall is part of a Cisco TrustSec network

Floods:
- Protects from floods: SYN, ICMP, ICMPv6, UDP, and other IP flood attacks
- Configure thresholds in CPS:
    - Alarm Rate - 15-20 % above normal CPS
    - Activate - start dropping
    - Maximum - 80-90 % load
- Random Early Drop (RED, also known as Random Early Detection) used for all floods 
- For SYN - SYN Cookies can be used besides RED

## Interfaces

- L2
- L3: IP address, zone, virtual router
- Virtual wire - no routing or switching, no MAC or IP addresses, blocking or allowing of traffic based on the virtual LAN (VLAN) tags
- It ignores any Layer 2 or Layer 3 addresses for switching or routing purposes
- A virtual wire interface does not use an Interface Management Profile
- All the firewalls that are shipped from the factory have two Ethernet ports (port 1 and port 2) preconfigured as virtual wire interfaces. These interfaces allow all of the untagged traffic
- TAP passively monitor traffic flows across a network by using a switch port analyzer (SPAN) or mirror port
- Subinterfaces: Layer 3, Layer 2, and VWIRE - using 802.1Q
- VWIRE subinterfaces also allow the use of IP classifiers to further this segregation
- Tunnel interfaces - virtual interfaces for VPN, should be in the same virtual router as physical - separate VPN zone for them is recomended. IP is required only when dynamic routing is used or for tunnel monitoring. Policy based VPN requires Proxy ID on both sides. 
- Aggregate interfaces - IEEE 802.1AX link aggregation - harwdware media can be mixed - interface type must be the same - 8 groups, some models - 16, 8 interfaces un each group
- Loopback interfaces - connect to the virtual routers in the firewall, DNS sinkholes, GlobalProtect service interfaces (such as portals and gateways)
- Decrypt mirror interfaces - routing of copied decrypted traffic through an external interface to another system, such as a data loss prevention (DLP) service
- VLAN interface


## Packet Flow Sequence

https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClVHCA0

<img width="1071" alt="image" src="https://user-images.githubusercontent.com/116812447/215520946-0255d873-1931-4799-b57e-4a62d4e48765.png">

## Policies

- Security
- NAT
- QoS
- Policy Based Forwarding
- Decryption
- Tunnel inspection
- Application Override
- Authentication
- DoS protection
- SD-WAN

### Security policy options

- Source
  - Zone
  - Address
  - User
  - Device
- Destination
  - Zone
  - Address
  - Device
  - Service
  - URL Category
- App-ID
- GlobalProtect Host Information Profile (HIP)
- Security Profiles (Content-ID) - use signatures to identify known threats. Unknown threats are identified by WildFire

### Security policy concepts

- Top to down
- Left to right
- New rule is created under currently selected rule
- More specific rules first
- Exceptions to policy rules must appear before the general policy
- Step 1: check security policy
- Step 2: apply Security Profiles: only if traffic is allowed
- Intrazone allow
- Interzone deny
- Three types: universal, intrazone, interzone: selects the type of traffic to be checked
- Use App-Id, not ports
- By default, traffic logging is disabled
- Separate rule for loging blocks
- Pre rules and post rules from Panorama
- Default rules
- Drop - silently, Deny - notify with ICMP + in App-Id data base there is a prefereable Deny action, Reset - send RST

The policy evaluation then uses the 'six tuple' (6-Tuple) to match establishing sessions to security rules:
1. Source IP
2. Source Port
3. Destination IP
4. Destination Port
5. Source Zone
6. Protocol

## Security profiles

<img width="712" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/1d86b533-ba26-4894-b550-35aa76e314da">

- Stream mode is used for scanning, not file
- Applied only for allowed rules
- All security profiles - is a Content-ID feature
- Wildfire license - updates are in real time
- Threat prevention license - updates are once in 24 hours
- We can create groups

Possible actions:

- default: For each threat signature and antivirus signature that is defined by Palo Alto Networks, a default action is specified internally. Typically, the default action is an alert or a reset-both. The default action is displayed in parenthesis—for example, default (alert) in the threat or antivirus signature.
- allow: This action permits the application traffic.
- alert: This action generates an alert for each application traffic flow. The alert is saved in the
Threat log.
- drop: This action drops the application traffic.
- reset-client: For TCP, this action resets the client-side connection. For UDP, it drops the
connection.
- reset-server: For TCP, this action resets the server-side connection. For UDP, it drops the
connection.
- reset-both: For TCP, this action resets the connection on both client and server ends. For
UDP, it drops the connection.

## Sessions

Session types
- FLOW

Session states
- INIT

Session end reasons
- threat
- policy-deny
- decrypt-cert-validation
- decrypt-unsupport-param
- decrypt-error
- tcp-rst-from-client
- tcp-rst-from-server
- resources-unavailable
- tcp-fin
- tcp-reuse
- decoder
- aged-out - no ARP of router, routing issues, no reply from server
- unknown
 
## App-ID

- 6-Tuple is checked against the security policy > known application signatures > check if it is SSH, TLS, or SSL > decryption policy (if exists) > checked again for a known application signature inside TLS > the application has not been identified (a maximum of 4 packets after the handshake, or 2,000 bytes) > will use the base protocol to determine which decoder to use to analyze the packets more deeply > unknown-tcp > check policy if unknown is allowed  
- SSL > Web-Browsing > flickr > flickr-uploading: NGFW continiously watches at traffic app, the more data it gets, then identificationis changed
- The application decoder will continuously scan the session for expected and deviant behavior, in case the application changes to a sub-application or a malicious actor is trying to tunnel a different application or protocol over the existing session
- If the protocol is unknown, App-ID will apply heuristics
- Use App-ID instead of service and protocols and port based
- App-ID without decryption identifies application based on server certificate: CN field, if it is exact, then it will be google-base for example, if there is a wildcard, it will be SSL app
- Application override - only for trusted traffic - create custom application based on zones, ips, ports... - used to decrease load on NGFW - it does not analyze App for certain traffic
- Create a custom app configuring its characteristics:
    - Charachteristics
    - Category and subcategory
    - Risk
    - Timeout
    - Port
    - Signatures
- Application groups for convenience
- Application filters - they are dynamic - based on categories or tags
- Dependenciescan be added to the same rule or other rule

Best pratice Moving from Port-Based to App-ID Security: set of rules that aligns with business goals, thus simplifying administration and reducing the chance of error
    - Assess your business and identify what you need to protect
    - Segment your network by using interfaces and zones
    - Identify allow list applications
    - Create user groups for access to allow list applications
    - Decrypt traffic for full visibility and threat inspection
    - Create best-practice Security Profiles for the internet gateway for all allow rules
    - Define the initial internet gateway Security policy, Using the application and user group inventory

App-ID database
- Description
- Depends on Applications
- Category
- Subcategory
- Risk
- Standard ports
- Technology 
- Deny action 

App-ID status in logs:
- Icomplete - three-way TCP handshake did not complete OR no enough data after the handshake - is not really an application
- Insufficient data - not enough data to identify the application - for example one data packet after the handshake
- unknown-tcp - firewall captured the three-way TCP handshake, but the application was not identified - custom app, no signatures
 - unknown-udp - custom app, no signatures
 - unknown-p2p - generic P2P heuristics
 - Not-applicable - port is blocked

## Decryption

We configure policy based on profile  
In profile we configure all SSL settings  
Than we mark one cert as forward proxy  

- Content-ID is impossible
- App-ID - works partially
- Decryption policies enable you to specify traffic for decryption according to destination, source, user/user group, or URL category

Configuration:

- Policies > Decryption
- Name: Sber
- Source address: 192.168.1.0/24
- Action: Decrypt
- Type: SSL Forward Proxy
- Decryption profile: Default
- Device > Certificate Management > Certificates
- Name: sber.ru
- Common Name: sber.ru
- Signed by - empty
- Certificate Authority
- After cert generation enable in it: Forward Trust Certificate, Forward Untrust Certificate, Trusted Root CA
- Export cert to client

## Tags

- Tags can be attached to the following objects: address objects, address groups, user groups, zones, service groups, and policy rules
- If we attach a Tag to a policy rule + specify fo rule which Tag to use to group it by + enable "View rulebase as Groups" the we can use it to see policy grouped by tag
- Tags can be painted or not
- In Panorama we can: Move rules in group to a different rulebase or device group
- We also can:
    - Change group of all rules
    - Move all rules in group
    - Delete all rules in group
    - Clone all rules in group

## IP Tags and Dynamic Address Group (DAG)

Sberbank case: script sends via XML API Tag + IP, based on this Tag IP is added to DAG, DAG is used in a policy as destination, or source  

- IP-Tag can be assigned to IP address via:
        - XML API
        - Log Forwarding Profile - For example, whenever the firewall generates a threat log, you can configure the firewall to tag the source IP address in the threat log with a specific tag name
        - Device > VM Information Sources - monitor VMware ESXi, vCenter Server, AWS-VPCs, and Google Compute Engines natively on the firewall
        - User-ID agent for Windows - monitor up to 100 VMware ESXi servers, vCenter Servers, or a combination of the two
        - Panorama Plugin - Azure or AWS public cloud 
        - VMware Service Manager - Integrated NSX solutions only
- IP Tags can be seen via Monitor > IP tag
- You can configure the firewall to dynamically unregister a tag after a configured amount of time using a timeout  

- Tags can be used in Dynamic Address Groups: Objects > Address Groups > Create Dynamic
- Tags are used as match criteria for groups
- Dynamic address groups are very useful if you have an extensive virtual infrastructure where changes in virtual machine location/IP address are frequent
- Dynamic address groups can also include statically defined address objects, we configure tag for static object
- PAN-OS only supports IPv4 IP subnets and ranges in dynamic address groups
- We create dynamic group and what it matches - it matches a tag - then we use this dynamic group in policy
- Dynamic tags are part of the runtime configuration
- This implies that a commit is not required to update dynamic tags
- Each registered IP address can have up to 32 tags
- We can view a list of addresses in DAG by pointing on DAG in Security Policy > Pressing Inspect > Pressing more OR going to Address Groups in Objects and pressing More
- If you want to delete all registered IP addresses, use the CLI command debug object registered-ip clear all and then reboot the firewall after clearing the tags

## External Dynamic List

- Text file that is hosted on an external web server so that the firewall can import objects—IP addresses, URLs, domains—included in the list and enforce policy
- Objects > External Dynamic Lists
- Used in Policy: Source/Destination Address, URL category
- Configure DNS Sinkholing for a List of Custom Domains
- Use an External Dynamic List in a URL Filtering Profile


## HA

Types:

- Active/Standby
- Active/Active
- Cluster

Concepts:

- Up to 16 firewalls as peer members of an HA cluster
- Configure HA then everything else: Interfaces, policies....
- Active firewall has less priority
- Firewall-specific configuration such as management interface IP address or administrator profiles, HA specific configuration, log data, and the Application Command Center (ACC) information is not shared between peers
- Any Layer 3 interface that is already active in the network will receive a new MAC address once HA is enabled (and committed), which could cause connectivity issues while switches and clients learn the new MAC associated with the firewall IPs. Some ARP tables may need to be cleared and static entries updated
- In Active/Passive mode, on Passive node interfaces are down by default
- In Active/Passive mode IPs and MACs are identical, when failover happens, gratuitous ARPs (GARPs) are sent. On hypervisors MACs are different, because they are set by Hypervisor, it can be changed in Palo Ato Settings
- After commit changes are automatically sent to Passive
- You can make changes on Passive, press Commit and it will go to Active

Failover reasons
- Link monitoring: If an interface goes down, the member fails
- Path monitoring: If an IP becomes unavailable, the member fails
- Heartbeat monitoring: The peers periodically send heartbeat packages and hello messages to verify they are up and running
- Hardware monitoring: The member continually performs packet path health monitoring on its own hardware and fails if a malfunction is detected

What is not synced?

- Mgmt interface settings
- Panorama settings
- SNMP
- Services
- Service routes
- Decryption certificates
- Decrypted SSL sessions (both inbound and outbound) that were established using PFS key exchange algorithms. In these cases, when a failover occurs, the passive device allows transferred sessions without decrypting them
- Decrypted, outbound SSL sessions using non-PFS key exchange algorithms
- Certificates
- Licenses
- Jumbo frames
- Log Export Settings

### HA prerequisites

- Model
- PAN-OS version
- UP-to-date application, URL, threat databases
- HA unterfaces types
- Licenses
- Slot configuration
- For VMs: HYpervisor, number of CPU cores

### Links

7 Links in total, all are configured in HA Communications section
- HA-1 control link (Control Plane) - should be HA type
    - L3 link, requires IP, mask, gateway - can be spanned via subnets
    - Hello, heartbeats, HA state info, User-ID, config sync
    - ICMP is used to exchange heartbeats between HA peers
    - Ports used for HA1 — TCP port 28769 and 28260 for clear text communication; port 28 for encrypted communication (SSH over TCP)     
    - Dedicated HA port should be used on big models, if not Management port is used
    - Monitor Hold Time (ms)— Enter the length of time, in milliseconds, that the firewall will wait before declaring a peer failure      due to a control link failure (range is 1,000 to 60,000; default is 3,000). This option monitors the physical link status of         HA1 ports
- HA-2 data link (Data plane) - HA type
    - Layer 2 link, ether type 0x7261 by default, available: IP (protocol number 99) or UDP (port 29281), can span subnets.The benefit of using UDP mode is the presence of the UDP checksum to verify the integrity of a session sync message
    - Session info, forwarding tables, IPSec, ARP
    - Data flow on the HA2 link is always unidirectional (except for the HA2 keep-alive); it flows from the active or active-primary firewall to the passive or active-secondary firewall. 
    - HA2 Keep-alive - recomended to enable. To monitor and maintain the HA2 connection. A log will be written in the event of a failure, or in Active/Active mode the action can be set to split datapath to instruct both peers to keep processing traffic while only maintaining a local state table until HA2 returns Plus configure action: Log for Active-passive, Split Datapath for Active/Active - each peer to take ownership of their local state and session tables when it detects an HA2 interface failure
- HA-1 and HA-2 Backup Links
    - Provide redundancy for the HA1 and the HA2 links
    - In-band ports can be used for backup links for both HA1 and HA2 connections when dedicated backup links are not available. 
    - The IP addresses of the primary and backup HA links must not overlap each other
    - HA backup links must be on a different subnet from the primary HA links
    - HA1-backup and HA2-backup ports must be configured on separate physical ports, 
    - The HA1-backup link uses port 28770 and 28260, PA-3200 Series firewalls don’t support an IPv6 address for the HA1-backup link; use an IPv4 address
- HA-3 - Packet forwarding link - for active/active - HA type?
    - Layer 2 link that uses MAC-in-MAC encapsulation
    - The firewalls use this link for forwarding packets to the peer during session setup and asymmetric traffic flow. 
    - It does not support Layer 3 addressing or encryption
    - You cannot configure backup links for the HA3 link, only LAG. 
    - The firewall adds a proprietary packet header to packets traversing the HA3 link, so the MTU over this link must be greater than the maximum packet length forwarded
- HA4
    - Layer 3 type no gateway, no spaning over subnets, HA type
    - Session cache synchronization among all HA cluster members having the same cluster ID + keep-alives between Cluster members
- HA4 BAckup

### Active/Passive

Supported deployments
- Virtual wire
- Layer 2
- Layer 3 

Configuration overview
- Enable Ping on management interface
- Configure HA type interface for HA2 link
- Enable HA and general options: Group-ID, mode, config sync, peer HA1 IP and backup IP: Device > HA > General
      - This ID needs to be identical on both members. The Group ID will also have an impact on the MAC addresses associated with each interface as they switch to a virtual MAC that both firewalls will be able to claim via gratuitous ARP in case one member fails
- Configure Active/PAssive options: Passive Link State  + Monitor Fail Hold Down Time (min) - By default, the passive device will have its interfaces in a shutdown state, meaning any connected devices will also see the link as being down. Depending on your environment, this could prevent other clusters from functioning properly, in which case you will need to set these to Auto (up but not accepting packets). Monitor Fail Hold Down Time keeps the firewall in a failed statefor the specified amount of time after an error was detected before setting the member to the passive state: Device > HA > General
      - You can enable Link Layer Discovery Protocol (LLDP) and Link Aggregation Control Protocol (LACP) in passive mode by accessing the interface's advanced tab
- Configure Election settings: 
      - Priority - the less the better
      - Preemptive - higher-priority firewall to resume active (active/passive) or active-primary (active/active) operation after recovering from a failure. You must enable the preemption option on both firewalls for the higher-priority firewall to resume active or active-primary operation upon recovery after a failure. If this setting is disabled, then the lower-priority firewall remains active or active-primary even after the higher-priority firewall recovers from a failure
      - Heartbeat backup - This will use the management interface to send a simple heartbeat to the remote peer
      - HA Timer settings - Use recomeneded - 7 timers in total:
            - Promotion Hold Time (ms) - how long passive will wait
            - Hello Interval (ms) - hello packets sent to verify that the HA program on the other firewall is operational
            - Heartbeat Interval (ms) - heartbeat messages in the form of an ICMP ping 
- Configure HA communications
      - HA1 port - management, or dedicated, on port with HA type - if not management is used, then configure IP, mask, gateway, possible encryption and Monitor Hold Time (ms)
      - HA2 port - select transport type - Ethernet - and nothing more should be configured - Interface type - HA. Also HA2 Keep alive is recomended to enable to monitor health of HA2 link and log if something happens
- Enable HA widget on a dashboard
- Sync config
- Manually suspend node: Device > High Availability > Operational Commands > Suspend local device

Out of sync state  
Possible when person makes change to active host, does not commit. Then someone from Panorama commits amd push configs to both devices. But panorama does not touch what we did locally. As a result new configuration only on Active device and we have out of sync state. Now we can sync from both devices, we need to choose which one is better for us.

### Firewall states

- Initial - after boot-up and before it finds peer
- Active - normal traffic handling state
- Passive - normal traffic is discarded, except LACP and LLDP
- Active-Primary - A/A only
- Active-Secondary - A/A only
- Tentative - A/A only
- Suspended - administratively disabled
- Non Functional - error state

### Active/Active

- Advanced design concepts
- Complex troubleshooting
- Additional configuration on both firewalls
- Recommended if each firewall needs its own routing instances and you require full, real-time redundancy out of both firewalls all the time
- Active/active mode has faster failover
- Can handle peak traffic flows better than active/passive mode because both firewalls actively process traffic

Supported deployments:
- L3
- Virtual Wire

Does not support the DHCP client. Furthermore, only the active-primary firewall can function as a DHCP Relay. If the active-secondary firewall receives DHCP broadcast packets, it drops them

4 types of design:
- Floating IP Address and Virtual MAC Address
- Floating IP Address Bound to Active-Primary Firewall
- Route-Based Redundancy
- ARP Load-Sharing

### Virtual MAC address

- Manually configure different gateways on end systems or use load balancers
- Each firewall in the HA pair creates a virtual MAC address for each of its interfaces that has a floating IP address or ARP Load-Sharing IP address
- After the failed firewall recovers, by default the floating IP address and virtual MAC address move back to firewall with the Device ID [0 or 1] to which the floating IP address is bound
- When a new active firewall takes over, it sends gratuitous ARPs from each of its connected interfaces to inform the connected Layer 2 switches of the new location of the virtual MAC address. 

### Route based redundancy

- Firewalls are connected  to routers, not switches
- Each firewall has separate IP addresses, sessions are synced
- If firewall fails, then based on routing protocol traffic is not sent to it
- No need to configure virtual MAC address/floating IP address, arp load sharing, failover conditions
<img width="602" alt="image" src="https://user-images.githubusercontent.com/116812447/215494580-eeaed00c-52a0-479c-b8db-909f8cce27fc.png">

### ARP load sharing

- Use only when firewall is default gateway for end hosts
- Everytime different firewall replies on ARP request with its own virtual MAC, IP is the same for both firewalls
- ARP load sharing on LAN side and floating IP on the other

### Cluster

- 2 HA4 interfaces(primary and backup) with type HA, IP address, mask
- On every device add all over devices with serial number, HA4 and HA4 backup IP addresses and sessions sync
- Enable cluster on all devices with the same cluster ID
- Zone names should be identical
- All appliances should be configured on all devices with HA4 IP addresses
- Session is logged on that device, where it ended
- On Passive devices cluster is inactive
- TCP handshake should pass one firewall, otherwise asymmetric path bypass should enabled on internal zone
- Security checks cannot be done with asymmetric
- HA peers in the cluster can be a combination of HA pairs and standalone cluster members
- Only the firewall that is the session owner creates a traffic log
- The new session owner (the firewall that receives the failed over traffic) creates the traffic log

Use cases
- HA peers are spread across multiple data centers
- One data center is active and the other is standby
- Horizontal scaling, in which you add HA cluster members to a single data center to scale security and ensure session survivability: Load balancer sends traffic to many NGFWs

Session Synchronization States
- Pending → Synchronization is not triggered yet
- Unknown. → Device Serial Number and Peer IP is configured but session synchronization process has not started yet
- In-Progress  → Full session synchronization is running 
- Completed  → Full session synchronization is completed and new sessions will be synchronized in real time 
- Disabled → Session synchronization is disabled to the member or for HA peer

Show logs about HA4 sessions sync
```
show log system | match ha4
```

## Routing

- All ingress traffic goes to firewall itself or virtual router object, vlan object or virtual wire object
- Legacy virtual routers: RIP, OSPF, OSPFv3, BGP, multicast, static routes, redistribution, administrative distances
- Advanced Route Engine of virtual routers supports the Border Gateway Protocol (BGP) dynamic routing protocol and static routes, can be only one - for large data centers, enterprises, ISPs, and cloud services
- IPsec tunnels are considered Layer 3 traffic segments for implementation purposes and are handled by virtual routers like any other network segments. Forwarding decisions are made by destination address, not by VPN policy
- There are limitations for the number of entries in the forwarding tables (forwarding information bases [FIBs]) and the routing tables (routing information bases [RIBs]) in either routing engine
- Lower administrative distanse is prefered
- ECMP: 4 routes max: no need to wait for RIB recalculation, load balancing, all links load
- Route monitoring
- PBF 
- Application-specific rules are not recommended for use with PBF because PBF rules might be applied before the firewall has determined the application
- Virtual routers can route to other virtual routers within the same firewall
- Each Layer 3 Ethernet, loopback, VLAN, and tunnel interface defined on the firewall must be associated with a virtual router
- Each model supporting a different maximum of virtual routers

## NAT

Separate policy. Regulated by:
- Zones
- Interfaces
- IP addresses
- App services - ports

First matched ruled is applied  
The advantage of specifying the interface in the NAT rule is that the NAT rule is automatically updated to use any address subsequently acquired by the interface.  

Supported  Source NAT types:
- Static IP
- Dynamic IP and port
- Dynamic IP

No NAT policy for exculsion  
Use session browser to find NAT rule name  
U-Turn NAT - user connects to Internal resource via external IP address and it is uturned on the firewall. Due to absence of internal DNS server for example. If we use regular Destination NAT for it, then traffic will be sent back to Internal network and web server will reply directly to client, causing assymetry. To avoid this Source NAT should be used as well, so the reply traffic will be sent to NGFW as well. Place the rule for it above all other

## User-ID

- Runs either on the firewall (agentless implementation)
- Separate process on a Microsoft Windows Server-based host
- Redirect HTTP requests to a Captive Portal login: Browser challenge: Uses Kerberos or NT LAN Manager (NTLM) or Web form, MFA, Client Cert
- Monitors Security Event logs for successful login and logout events on Microsoft domain controllers, Exchange servers, or Novell eDirectory
- Microsoft Terminal Services or Citrix environments - Agent - Source port is used
- Linux terminal servers - XML API to send user mapping information from login or logout events to User-ID
- Syslog Parse Profiles
- XFF headers: If a proxy server exists between users and a firewall
- Global Protect
- XML API
- Client probing: Windows Management Instrumentation or NetBIOS - not recomended
- 100 domain controllers or 50 syslog servers - MAX
- Firewalls share user mappings and authentication timestamps as part of the same redistribution flow
- Before a firewall or Panorama can collect user mappings, you must configure its connections to the User-ID agents or redistribution points
- Four domain controllers within an LDAP server profile for redundancy
- If you have universal groups, create an LDAP server profile to connect to the root domain of the global catalog server on port 3268 or 3269 for SSL. Then, create another LDAP server profile to connect to the root domain controllers on port 389 or 636 for SSL. This helps ensure that both user and group information is available for all the domains and subdomains
- Maximum of 512k users in a domain
- User-ID agent is launched under the same User name as it connects to AD
- Special User-ID log
- The User-ID agent queries the Domain Controller and Exchange server logs using Microsoft Remote Procedure Calls (MSRPCs)
- During the initial connection, the agent transfers the most recent 50,000 events from the log to map users
- On each subsequent connection, the agent transfers events with a timestamp later than the last communication with the domain controller

Use Agentless (PAN-OS)
- If you have a small-to-medium deployment with few users and 10 or fewer domain controllers or exchange servers
- If you want to share the PAN-OS-sourced mappings from Microsoft Active Directory (AD), Captive Portal, or GlobalProtect with other PA devices (maximum 255 devices)
- Saves network bandwidth

Use User-ID Agent (Windows)
- If you have a medium-to-large deployment with many users or more than 10 domain controllers
- If you have a multi-domain setup with a large number of servers to monitor
- Save processing cycles on the firewall’s management plane

### Configure managed service account on Windows AD

- Active Directory Users and Computers > Managed Service Accounts > New User
- Allow the service account to read the security log events
- Active Directory Users and Computers > Builtin > Event Log Readers > Add new managed service account
- Allow WMI: Active Directory Users and Computers > Builtin > Distributed COM USers - add amanged service account
- Add user-id managed service account to Server Operators group

AD has to generate logs for Audit Logon, Audit Kerberos Authentication Service, and Audit Kerberos Service Ticket Operations events. At a minimum, the source must generate logs for the following events:
- Logon Success (4624)
- Authentication Ticket Granted (4768)
- Service Ticket Granted (4769)
- Ticket Granted Renewed (4770)

### Configure agentless

- Enable User-ID in a zone options

### Configure via User-ID agent

- Install User-ID agent on supported Windows version according to instructions, configure it and launch
- Enable User-ID in zone configuration
- Device > Data Redistribution - Configure Agent host and port - verify that its status is connected

### Map users to groups

- Add LDAP server profile Device > Server > Profiles > LDAP
        - Port - 389
        - Base DN - DC=sber,DC=ru
        - Bind DN - Administrator@sber.ru
        - No SSL
- Enable Group Mapping Device > User Identification > Group Mapping Settings
        - Choose server profile
- Verify that the user and group mapping has correctly identified users Device > User Identification > Group Mapping > Group Include List
- To verify that all of the user attributes have been correctly captured, use the following CLI command:

```text
show user user-attributes user all
```

- Verify that the usernames are correctly displayed in the Source User column under Monitor > Logs > Traffic
- Verify that the users are mapped to the correct usernames in the User Provided by Source column under Monitor > Logs > User-ID.

### Configure User-ID Agent

- Configure according to Palo Alto documentation
- Enter username with domain and password

### Debug

Show logged in users

```text
debug dataplane show user all
```

Show log for agentkess connection to Active Directory
```
less mp-log useridd.log
```
Go to the end of the file by pressing Shift+G

## QOS

QoS is enforced on traffic as it egresses the firewall  

Unclassified traffic enters firewall > **QoS Policy** assignes **class** to traffic > **QoS Profile** on Egress interface prioritizes traffic accorsing to **QoS class**  

- QoS profile - matching traffic is then shaped based on the QoS profile class settings as it exits the physicalinterface. Each QoS profile rule allows you to configure individual bandwidth and priority settings for up to eight QoS classes, as well as the total bandwidth allowed for the eight classes combined. In every profile you configure priorities for every class. Then you apply a profile to an interface.
- QoS policy - define traffic you want to receive QoS treatment and assign that traffic a QoS class. QoS policy rule is applied to traffic after the firewall has enforced all other security policy rules, including Network Address Translation (NAT) rules.
- QoS egress interface - this is where you apply QoS profile. If you limit Youtube then Egress interface is Internal interface of FW. You apply it in separate section Network > QoS

Define a QoS policy rule to match to traffic based on:
- Applications and application groups
- Source zones, source addresses, and source users
- Destination zones and destination addresses
- Services and service groups limited to specific TCP and/or UDP port numbers
- URL categories, including custom URL categories
- Differentiated Services Code Point (DSCP) and Type of Service (ToS) values, which are used to indicate  the level of service requested for traffic, such as high priority or best effort delivery

## Logging

By default, the logs that the firewall generates reside only in its local storage  
Everything is in a Log Forwarding profile  
Objects > Log Forwarding  
Profile is attached to Security, Authentication, DoS Protection, and Tunnel Inspection policy rules  

- Several rules in one profile
- We configure all in one profile and then apply it to all rules, for example we can negate DNS and ICMP int it: ICMP and DNS are logged only locally to NGFW to lesses load on Panorama
- Also in this profile we configure to send logs simulteniusly to Syslog and Panorama
- Separate rule for logging blocks
- Log Forwarding Profile is configured for every rule:
        - Log type: Authentication, Data Filtering, GTP, SCTP, Threat, Traffic, Tunnel, URL Filtering, and WildFire
        - Filtration - based on any field in a log: App, Bytes In....
        - Forward Method
                - Panorama
                - SNMP (profile)
                - Email (profile)
                - Syslog (profile)
                - HTTP (profile)
        - Add/del tag for src/dst address or User

All other logs forwarding: Device > Log Settings - System, Configuration, User-ID....

## Panorama

Features:

- Policy management
- Device health: Panorama > Managed Devices > Health
- Objects configurations: addreses, profiles...
- NGFW configuration - SNMP, User-ID, LDAP, NTP...
- Database updates and software updates
- Logforwarding control
- Centralized visibility
- Network security insights
- Automated threat response
- Enterprise-level reporting and administration

Types:

- Management Only
- Log Collector
- Panorama: both

### Templates, stacks - to control configuration and updates
 
 <img width="576" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/813aef71-ce9f-401e-80a9-81e34f4c42c3">

- Configuration is written to template
- Template is addded to stack - 8 max
- NGFW is connected to max one stack
- A Panorama administrator can override the template settings at the stack level: add options to stack directly
- A local administrator can also perform overrides directly on an individual device if necessary - we chose an object and there is a button in the bottom: Override

### Device groups - to control policies and objects

- Device groups: for controlling all policies + all objects
- Tags can be applied to devices when add them to panorama
- Then these tags are used as targets in rule instead of sending to all devices in device group
- One NGFW only in one Device Group
- You can create a device group hierarchy to nest device groups in a hierarchy of up to four levels, with the lower-level groups inheriting the settings (policy rules and objects) of the higher-level groups
- Adds pre rules and post rules, which are read only on NGFW
- Devices must be added to device group
- PAN-OS doesn’t synchronize pushed rules across HA peers
- User-ID master in HA-group during adding to Device Group - This will be the only firewall in the device group from which Panorama gathers username and user group information
- Local rules are not touched, we just pre and post
- Rule is installed by default on all devices in device group, but we can choose exact firewalls or based on tags
- One giant device group consists of many subgroups
- Every device in panorama has its own tag or many tags


### Configuration

- Add Panorama and Secondary Panorama IP on device
- Insert auth key from Panorama: Panorama > Device Registration Auth Key 
- Commit
- Do the same for secondary device OR if it is already was in cluster, all setting will be commited from active device, except Auth key - it should be added manually
- Add both devices to Panorama > Managed devices using serials
- Group HA pair in panorama  
- Create a device group
- Commit and push
- Go to Policies, select device group and edit edit policy and push it

## CLI

Default username/pass - admin/admin  

Configure network
```
configure
set deviceconfig system ip-address <ip address> netmask <netmask> default-gateway <default gateway> dns-setting servers primary <DNS ip address>
set deviceconfig system type static
commit

show interface management
```

Show routing table
```
show routing route
show routing fib
```

Show sessions - with NAT data
```
show session all filter application ping

--------------------------------------------------------------------------------
ID          Application    State   Type Flag  Src[Sport]/Zone/Proto (translated IP[Port])
Vsys                                          Dst[Dport]/Zone (translated IP[Port])
--------------------------------------------------------------------------------
20           ping           ACTIVE  FLOW  NS   192.168.1.20[1]/Inside/1  (10.2.62.150[1])
vsys1                                          1.1.1.1[26]/Outside  (1.1.1.1[26])
```

Show detailed info about session: NAT, app, rule names, vsys, interfaces, bytes, type, state, user, QoS, end reason, logging...
```
admin@PA-1-1> show session id 25

Session              25

        c2s flow:
                source:      192.168.1.20 [Inside]
                dst:         1.1.1.1
                proto:       1
                sport:       1               dport:      31
                state:       INIT            type:       FLOW
                src user:    unknown
                dst user:    unknown

        s2c flow:
                source:      1.1.1.1 [Outside]
                dst:         10.2.62.150
                proto:       1
                sport:       31              dport:      1
                state:       INIT            type:       FLOW
                src user:    unknown
                dst user:    unknown

        start time                           : Sat May  6 09:58:41 2023
        timeout                              : 6 sec
        total byte count(c2s)                : 74
        total byte count(s2c)                : 0
        layer7 packet count(c2s)             : 1
        layer7 packet count(s2c)             : 0
        vsys                                 : vsys1
        application                          : ping  
        rule                                 : Allow ping
        service timeout override(index)      : False
        session to be logged at end          : True
        session in session ager              : False
        session updated by HA peer           : False
        address/port translation             : source
        nat-rule                             : Lan(vsys1)
        layer7 processing                    : enabled
        URL filtering enabled                : False
        session via syn-cookies              : False
        session terminated on host           : False
        session traverses tunnel             : False
        session terminate tunnel             : False
        captive portal session               : False
        ingress interface                    : ethernet1/1
        egress interface                     : ethernet1/3
        session QoS rule                     : N/A (class 4)
        tracker stage firewall               : Aged out
        end-reason                           : aged-out
```

Clear session
```
clear session id 27240
```

Show NAT policy
```
admin@PA-1-1> show running nat-policy

"Lan; index: 1" {
        nat-type ipv4;
        from any;
        source any;
        to Outside;
        to-interface  ;
        destination any;
        service 0:any/any/any;
        translate-to "src: ethernet1/3 10.2.62.150 (dynamic-ip-and-port) (pool idx: 1)";
        terminal no;
}
```

Ping
```
ping source 10.2.62.150 host 10.2.62.1
```

Show MAC addresses
The MAC addresses of the HA1 interfaces, which are on the control plane and synchronize the configuration of the devices are unique. The MAC addresses of the HA2 interfaces, which are on the data plane and synchronize the active sessions mirror each other.
```
show interface all - including VMAC for Active-Passive HA cluster
ethernet1/5             20    1000/full/up              00:1b:17:00:0b:14
HA Group ID = 0b Hex (11 Decimal) and Interface ID = 14 Hex (20 Decimal)

show interface ethernet1/1
show high-availability state - The following command displays the MAC addresses of an HA cluster
show high-availability virtual-address - displays VMAC and VIP for Active-Active HA cluster

```

To place the local HA peer into a suspended state and temporarily disable HA functionality on it
```
request high-availability state suspend
```

To place the suspended local HA peer back into a functional state
```
request high-availability state functional
```

Sync config to remote peer
```
request high-availability sync-to-remote running-config
```

## Packet capture

- Packets are captured on the dataplane vs on the interface
- Packet captures are session-based, so a single filter is capable of capturing both client2server and server2client
- Offloaded sessions can't be captured so offloading may need to be disabled temporarily. An offloaded session will display 'layer7 processing: completed' in the show session details
- When filtering is enabled, new sessions are marked for filtering and can be captured, but existing sessions are not being filtered and may need to be restarted to be able to capture them
- Allowed traffic can be seen in the following stages: Firewall, Transmit, Receive
- Dropped traffic can be seen in the following stages: Receive, Drop
- Receive stage is good to use if we need to make sure that traffic reaches FW in general
- Transmit stage is good to make sure that traffic successfully passed and left FW and how it was NATed


**Filters**
- Filters are not mandatory

**Stages**
- drop stage is where packets get discarded. The reasons may vary and, for this part, the global counters may help identify if the drop was due to a policy deny, a detected threat, or something else
- receive stage captures the packets as they ingress the firewall before they go into the firewall engine. When NAT is configured, these packets will be pre-NAT - only incoming packets
- transmit stage captures packets how they egress out of the firewall engine. If NAT is configured, these will be post-NAT - only outgoing packets
- firewall stage captures packets in the firewall stage - only incoming packets before NAT

If Ping is allowed you will see the following:
- Nothing in drop stage
- In Receive stage: Incoming packets before NAT on all interfaces involved for both request and response, no outgoing packets - only incoming
- In Firewall stage: The same as in Receive, if there is no filtering
- In Transmit stage: only outgoing packets after NAT

If ping is allowed you will see the following:
- Receive and drop stages are the same - all incoming requests are received and dropped
- No Firewall and Transmit stages



## Log filtering

Logical operators

- (proto neq udp) or ( addr.src notin 192.168.0.0/24 ) or !(addr in 1.1.1.1) или not (app eq ssl)
- AND: (port.src eq 23459) and (port.dst eq 22)
- OR: (port.src eq 23459) or (port.dst eq 22) 

Addresses

- (addr.src in 1.1.1.1)
- (addr.dst in 2.2.2.2)
- (addr in 1.1.1.1)

Protocols: (proto eq udp)

Ports

- (port.src eq 22)
- (port.dst eq 25)

Apps: (app eq ssh)

Users

- Unindentified user: (user.src eq ’’)
- User in group: (user.src in 'group1')

Action: (action eq allow)  

Date and time

Before date: (receive_time leq '2015/08/31 08:30:00’)
After date: (receive_time geq '2015/08/31 08:30:00')

## Troubleshooting

Show system logs

```text
show log system
```

## Wildfire

- Sandboxing platform
- Machine learning, static analysis, dynamic analiisis
- Reporting
- Integrates with firewalls, traps, Autofocus, unit 42 team, URL filtering
- Spreads signatures to all platforms
- Real Time updates for NGFW AV
- WF-500 applicance can work alone - updated manually
- Cloud query approach - samples do not leave the network
- Hybrid approach
- Integrated Logging, Reporting, and Forensics - via Panorama
- We can send files via API