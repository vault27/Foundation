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

## Best Practice Assessment (BPA) tool

- BPA is available via Customer Support Portal
- After you gain access to the BPA, you can generate a BPA report for a Panorama appliance or for a next-generation firewal
- BPA for Palo Alto Networks firewalls and Panorama
- If possible, generate BPA reports for Panorama appliances instead of individual next-generation firewalls to gain complete visibility into all of the firewalls in your environment in one report. Generate reports on a regular basis to measure progress toward adopting security capabilities and security best practices
- The two components of the BPA tool are the Security Policy Adoption Heatmap and the BPA assessment
- Tech Support Files (Device > Support> Tech Support File or Panorama> Support > Tech Support File) are sent to the portal
- The BPA assessment compares a firewall or Panorama configuration against best practices and provides recommendations to strengthen the organization’s security posture by fully adopting the Palo Alto Networks prevention capabilities. More than 200 security checks are performed on the firewall or Panorama configuration
- The Best Practices Assessment Plus (BPA+) fully integrates with BPA to provide customers with the ability to easily remediate failed best practice checks and improve overall adoption and security posture
- Three class summaries for BPA: Technical, Operational, Management

### Heat map

- For every zone pair, for ezmple Internal > External, it shows in percents adoption rate for all features
- The Heatmap Measures Adoption Rate. The Heatmap can filter information by device groups, serial numbers, zones, areas of architecture, and other categories. The results chart the progress of security improvement toward a Zero Trust network
- All security profiles should be applied on all allow rules
- For most features adoption rate goal is 100%
- URL filtering and DNS sinkhole usually cannot be 100%

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

### BPA report

- Executive summary in Palo Alto web site
- Detailed HTML report is downloaded
- Best practises summary: NIST for example
- Security Profile Adoption
- Application and User control adoption
- Logging and zone protection adoption

## Main features

- App-ID
- Content-ID
- User-ID
- Device-ID

## Features

- The Palo Alto Networks firewall was designed to use an efficient system known as next-generation processing. Next-generation processing enables packet evaluation, application identification, policy decisions, and content scanning in a single, efficient processing pass - Single Pass Architecture
- Zone based firewall
- Full hardware separate mgmt
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

## Licenses

- Advanced Threat Protection
- Advanced URL filtering
- Global Protect
- Web Proxy
- DNS Security
- Support
- Wildfire
- IoT security
- Autofocus

## IPv6 support

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

## Configuration workflow

- You enable IPv6 on interface
- You configure address
- You enable Duplicate Address Detection
- You enable  NDP Monitoring - you can view the IPv6 addresses of devices on the link local network, their MAC address, associated username from User-ID, eachability Status of the address, and Last Reported date and time the NDP monitor received a Router Advertisement from this IPv6 address
- You enable RA-Router Advertisment
- You enable DNS support - include DNS information in Router Advertisment: Recursive DNS servers and lifetime, suffixes and lifetime, lifetime - the maximum length of time the client can use the specific RDNS Server to resolve domain names

## Artificial intelligence operations (AIOps)/Telemetry

- When enabled, Telemetry allows the firewall to collect and forward traffic information to Palo Alto Networks
- The data collected pertains to applications, threats, device health, and passive DNS information
- Data is sent to Cortex Data lake
- Device > Setup > Telemetry + enable Cortex Data Lake

## Management plane and Data Plane

- On physical appliances separate CPU, RAM, SSD for management plane: mgmt interface + console
- On virtual firewalls, these are still logically segregated
- The data plane connects directly to the traffic interfaces
- Field-programmable gate arrays (FPGAs) are used only on data-plane and only on high end devices
- PA-7000 has special acrchitecture: dedicated log collection and processing is implemented on a separate card, First packet processing and Switch fabric management in management plane

Management plane:

- Configuration management
- Logging
- Reporting functions
- User-ID agent process
- Route updates

Data plane:

- Signature match processor - exploits (IPS), antivirus, spyware, CC#
- All Content-ID and App-ID services
- Security processors
- Session management
- Encryption and decryption
- Compression and decompression
- Policy enforcement
- Network processor
- Route
- Address Resolution Protocol (ARP)
- MAC lookup
- QoS
- NAT
- Flow control

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
- Virtual wire - no routing or switching, no MAC or IP addresses, blocking or allowing of traffic based on the virtual LAN (VLAN) tags. You assign 2 physical interfaces to one virtual wire.
- It ignores any Layer 2 or Layer 3 addresses for switching or routing purposes
- A virtual wire interface does not use an Interface Management Profile
- All the firewalls that are shipped from the factory have two Ethernet ports (port 1 and port 2) preconfigured as virtual wire interfaces. These interfaces allow all of the untagged traffic
- TAP passively monitor traffic flows across a network by using a switch port analyzer (SPAN) or mirror port
- Subinterfaces: Layer 3, Layer 2, and Virtual Wire - using 802.1Q
- Virtual Wire Subinterfaces using VLAN tags only: You assign 2 physical interfaces to one virtual wire, on each interface you create sub interface with particular VLAN-ID. The same VLAN tag must not be defined on the parent virtual wire interface and the subinterface.
- Virtual Wire Deployment with Subinterfaces (VLAN Tags and IP Classifiers): First firewall looks on the VLAN tag and matches against proper subinterface, but several subinterfaces may use the same VLAN - 100, then it uses IP classifier: source IP address and this helps him to match proper subinterface. For return-path traffic, the firewall compares the destination IP address as defined in the IP classifier on the customer-facing subinterface and selects the appropriate virtual wire to route traffic through the accurate subinterface
- Tunnel interfaces - virtual interfaces for VPN, should be in the same virtual router as physical - separate VPN zone for them is recomended. IP is required only when dynamic routing is used or for tunnel monitoring. Policy based VPN requires Proxy ID on both sides. 
- Aggregate interfaces - IEEE 802.1AX link aggregation - harwdware media can be mixed - interface type must be the same - 8 groups, some models - 16, 8 interfaces un each group
- Loopback interfaces - connect to the virtual routers in the firewall, DNS sinkholes, GlobalProtect service interfaces (such as portals and gateways)
- Decrypt mirror interfaces - routing of copied decrypted traffic through an external interface to another system, such as a data loss prevention (DLP) service
- VLAN interface
- SD-WAN - ?

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

- Antivirus
- Antispyware
- Vulnerability Protection
- URL filtering
- File blocking
- Wildfire analysis
- Data filtering
- DoS protection

<img width="712" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/1d86b533-ba26-4894-b550-35aa76e314da">

Concepts

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
UDP, it drops the connection

### Antivirus

- Stream
- Default generates alerts for the SMTP, IMAP, and POP3 protocols while blocking for FTP, HTTP, and Server Message Block (SMB) protocols
- Minimize traffic inspection between trusted security zones
- Machine learning to PE - Portable executable, ELF (executable and linked format), and MS Office files and on the PowerShell and shell scripts in real time
- WildFire-based signatures
- WildFire inline ML, you must possess an active WildFire subscription

### Anti-Spyware

- Blocks connections to the external C2 servers
- Default profile uses default action inside a signature
- Block IP: This action blocks traffic from either a source or a source-destination pair. It is configurable for a specified period of time
- You can also enable the DNS Sinkholing action in the Anti-Spyware Profiles to enable the firewall to forge a response to a DNS query for a known malicious domain, thus causing the malicious domain name to resolve to an IP address that you define
- This feature helps to identify infected hosts on the protected network by using DNS traffic. Infected hosts can then be easily identified in the Traffic and Threat logs because any host that attempts to connect to the sinkhole IP address is most likely infected with malware

## Vulnerability Protection

- When the vulnerability protection action profile is set to reset-both, the associated threat log might display action as reset-server. As discussed earlier, this occurs when the firewall detects the threat at the beginning of a session and presents the client with a 503-block page. Since, the block place disallows the connection, only the server-side connection is reset
- The default Vulnerability Protection Profile protects clients and servers from all known critical-, high-, and medium-severity threats

### URL Filtering

- Default profile that is configured to block threat-prone categories, such as malware, phishing, and adult content
- Configure user-credential detection so that users can submit credentials only to the sites in specified URL categories
- With the advanced URL filtering subscription, Inline Categorization enables real-time analysis of URL traffic by using firewall-based or cloud-based ML models, to detect and prevent malicious phishing variants and JavaScript exploits from entering the network

### Data Filtering

- Prevent sensitive information, such as credit card numbers or Social Security numbers, from leaving a protected network
- Filter on keywords, such as a sensitive project name or the word “confidential.”
- Predefined patterns: Filter for a list of over 20 predefined patterns, including Social Security numbers, national identity numbers from various nations, credit cards, and other useful patterns
- Regular expressions: Filter for a string of characters
- File properties: Filter for file properties and values based on file type

### File Blocking

- Specified session flow direction (inbound/outbound/both)
- Alert or block on upload or download, and you can specify which applications will be subject to the File Blocking Profile
- Custom response pages
- Possible actions
    - alert
    - block
    - continue: After the specified file type is detected, a customizable response page is
presented to the user. The user can click through the page to download the file. A log is also generated in the Data Filtering log. This type of forwarding action requires user interaction and is therefore only applicable for web traffic

### WildFire Analysis

- Forward unknown files or email links for WildFire analysis
- Specify files to be forwarded for analysis based on application, file type, and transmission direction (upload or download)
- WildFire public cloud or the WildFire private cloud (hosted with a WF-500 appliance)
- WildFire hybrid cloud deployment: WildFire appliance to analyze sensitive files (such as PDFs) locally, less-sensitive file types (such as PE files) or file types that are not supported for WildFire appliance analysis (such as APKs) to be analyzed by the WildFire public cloud
- Files are not quarantined pending WildFire evaluation. In cases of positive malware findings, the security engineer must use the information collected on the firewall and by WildFire to locate the file internally for remediation
- WildFire typically renders a verdict on a file within 5 to 10 minutes of receipt

### DoS Protection

- Control the number of sessions between interfaces, zones, addresses, and countries based on aggregate sessions or source and/or destination IP addresses
- Flood protection: Detects and prevents attacks in which the network is flooded with packets, which results in too many half-open sessions or services being unable to respond to each request. In this case, the source address of the attack is usually spoofed
- Resource protection: Detects and prevents session exhaustion attacks. In this type of attack, many hosts (bots) are used to establish as many fully established sessions as possible for consuming all of a system’s resources
- You can enable both types of protection mechanisms in a single DoS Protection profile
- Threshold settings for the synchronize (SYN), UDP, and Internet Control Message Protocol (ICMP) floods; enables resource protection; and defines the maximum number of concurrent connections. After configuring the DoS Protection profile, you attach it to a DoS policy rule

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
In profile we configure all SSL settings - avoid weak ciphers and protocols  
Than we mark one cert as forward proxy  

Policy includes:

- Source (IP, Zone, User, Device)
- Destination (Zone, address, device)
- Service/URL category
- DECRYPT OR NOT
- Type of decryption: Forward, Inbound or SSH
- Decryption profile
- Logging

Profile includes:

- Expired certs, untrusted certs
- Unsupported ciphers
- Client auth
- Key exchange algorithms, Protocols version, Encryption algorithms, Authentication algorithms
- Unsupported versions and algorithms in SSH

Concepts

- Content-ID is impossible
- App-ID - works partially
- Decryption policies enable you to specify traffic for decryption according to destination, source, user/user group, or URL category
- All encrypted traffic is SSL in App-ID
- Sometomes it can identify traffic without decryption using server cert
- Untrusted servers are sighned using special forward untrust certificate - ensures that clients are prompted with a certificate warning when attempting to access sites hosted by a server with untrusted certificates
- Decryption policy rules are compared against the traffic in sequence, so more specific rules must precede the more general ones
- The key used to decrypt SSH sessions is generated automatically on the firewall during bootup. With SSH decryption enabled, the firewall decrypts SSH traffic and blocks or restricts it based on your decryption policy and Decryption Profile settings. The traffic is re-encrypted as it exits the firewall

Three types of decryption policies

- SSL Forward Proxy to control outbound SSL traffic
- SSL Inbound Inspection to control inbound SSL traffic
- SSH Proxy to control tunneled SSH traffic

Three types of certificates are used

- Forward Trust (used for SSL Forward Proxy decryption)
- Forward Untrust (used for SSL Forward Proxy decryption)
- SSL Inbound Inspection - The certificates of the servers on your network for which you want to perform SSL Inbound Inspection of traffic destined for those servers. Import the server certificates onto the firewall

Decryption policy can apply to

- HTTPS
- IMAPS
- POP3S
- SMTPS
- FTPS
- SSH - inbound and outband

SSH decryption does not require certificates  
  
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

### User mapping methods

- Server monitoring - User-ID agent, PAN-OS built-in, AD, Exchange, Novell eDirectory, Sun ONE Directory Server
- Port mapping - Microsoft Terminal Services - Citrix Environments - Palo Alto Networks Terminal Services agent - the source port of each client connection to map each user to a session. Linux terminal servers do not support the Terminal Services agent and must use the XML API to send user mapping information from login or logout events to User-ID
- Syslog- The Windows-based User-ID agent and the PAN-OS integrated User-ID agent both use Syslog Parse Profiles to interpret login and logout event messages that are sent to syslog servers from the devices that authenticate users. Such devices include wireless controllers, 802.1x devices, Apple Open Directory servers, proxy servers, and other network access control devices
- XFF headers - IP address of client in additional header
- Authentication policy and Captive Portal - ny web traffic (HTTP or HTTPS) that matches an Authentication policy rule forces the user to authenticate via one of the following three Captive Portal authentication methods:ny web traffic (HTTP or HTTPS) that matches an Authentication policy rule forces the user to authenticate via one of the following three Captive Portal authentication methods:
    - Browser challenge: Uses Kerberos or NT LAN Manager (NTLM)
    - Web form: Uses multi-factor authentication (MFA), security assertion markup
language (SAML) single sign-on (SSO), Kerberos, terminal access controller access control system plus (TACACS+), remote authentication dial-in user service (RADIUS), LDAP, or local authentications
    - Client CA
- GlobalProtect
- XML API
- Client probing - in a Microsoft Windows environment - User-ID agent probes client systems by using Windows Management Instrumentation or NetBIOS. Client probing is not a recommended method for user mapping - WMI is recomended - probes are sent ebery 20 mins to verify that user is still loged in - client probes can be sent outside - large amount of network traffic

### Concepts

- 100 domain controllers or 50 syslog servers - MAX - per agent or per PAN-OS
- Firewalls share user mappings and authentication timestamps as part of the same redistribution flow
- Before a firewall or Panorama can collect user mappings, you must configure its connections to the User-ID agents or redistribution points
- Four domain controllers within an LDAP server profile for redundancy
- If you have universal groups, create an LDAP server profile to connect to the root domain of the global catalog server on port 3268 or 3269 for SSL. Then, create another LDAP server profile to connect to the root domain controllers on port 389 or 636 for SSL. This helps ensure that both user and group information is available for all the domains and subdomains
- Maximum of 512k users in a domain
- Special User-ID log
- Source NAT destroys User-ID

### Agentless (PAN-OS)

Use Agentless (PAN-OS)
- If you have a small-to-medium deployment with few users and 10 or fewer domain controllers or exchange servers
- If you want to share the PAN-OS-sourced mappings from Microsoft Active Directory (AD), Captive Portal, or GlobalProtect with other PA devices (maximum 255 devices)
- Saves network bandwidth

Configure

- Enable User-ID in a zone options

- Verify that the usernames are correctly displayed in the Source User column under Monitor > Logs > Traffic
- Verify that the users are mapped to the correct usernames in the User Provided by Source column under Monitor > Logs > User-ID.

### User-ID Agent (Windows)

Use User-ID Agent (Windows)
- If you have a medium-to-large deployment with many users or more than 10 domain controllers
- If you have a multi-domain setup with a large number of servers to monitor
- Save processing cycles on the firewall’s management plane

Concepts

- The User-ID agent queries the Domain Controller and Exchange server logs using Microsoft Remote Procedure Calls (MSRPCs)
- User-ID agent is launched under the same User name as it connects to AD
- During the initial connection, the agent transfers the most recent 50,000 events from the log to map users
- On each subsequent connection, the agent transfers events with a timestamp later than the last communication with the domain controller

Configure User-ID Agent

- Configure according to Palo Alto documentation
- Enter username with domain and password
- Install User-ID agent on supported Windows version according to instructions, configure it and launch
- Enable User-ID in zone configuration
- Device > Data Redistribution - Configure Agent host and port - verify that its status is connected

### User-ID redistribution

- If you configure an Authentication policy, you have to configure firewall to redistribute mappings + timestamps to other firewalls
- In Device > Data Redistribution > Agents you can configure other Firewall, Panorama or Windows agent as agent
- In Device > Data Redistribution > Collector Settings you can configure firewall as a redistribuion point for other firewalls and VSYSs
- Connection to agent is done via pre-shared key
- It is possible to redistribute not only User-IP mappings, but also:
    - IP tags
    - User tags
    - HIP
    - Quarantine list
- You can include/exclude networks for IP-Tag and IP-user in Device > Data Redistribution > Include/Exlcude networks, as I understand it is both for collector and client

### Map users to groups via LDAP

- Add LDAP server profile Device > Server > Profiles > LDAP
        - Port - 389
        - Base DN - DC=sber,DC=ru
        - Bind DN - Administrator@sber.ru
        - No SSL
- 4 servers in one profile MAX
- Enable Group Mapping: Device > User Identification > Group Mapping Settings
        - Choose server profile
- Verify that the user and group mapping has correctly identified users Device > User Identification > Group Mapping > Group Include List
- If you have universal groups, create an LDAP server profile to connect to the root domain of the global catalog server on port 3268 or 3269 for SSL
- To verify that all of the user attributes have been correctly captured, use the following CLI command:

```text
show user user-attributes user all
```

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

### Authentication portal

MFA profile > Authentication profile > Authentication enforcement object > Authentication Policy + Captive Portal settings in paralell + Authentication sequence in parallel 

### Multi-Factor authentication

- Device > Server Profiles > Muli Factor Authentication
- Create a profile
- Configure Certificate profile, choose vendor (DUO for example) and configure options for vendor
- The MFA factors that the firewall supports include push, Short Message Service (SMS), voice, and one-time password (OTP) authentication
- These profiles are connected as Factors to Authentication profile, several Factors can be addded

### Authentication profile

Types:

- Cloud - ?
- Local Database
- Radius
- LDAP
- TACAS+
- SAML
- Kerberos - single sign on + keytab

Device > Authentication Profile > What to configure:

- Type
- MFA profiles, several can be added
- Allow list
- Failed attempts
- User domain

## Authentication sequence

- Device > Authentication Sequence
- We can create several
- We add different authentication profiles to a sequence
- Order of profiles matter

### Authentication enforcement object

- Objects > Authentication
- Is assigned to Authentication policy rules
- We configure here method, authentication profile, and text messgae for user
- Methods:
    - browser-challenge — The firewall transparently obtains user authentication credentials. If you select this action, the Authentication Profile you select must have Kerberos SSO enabled or else you must have configured NTLM in the Captive Portal settings . If Kerberos SSO authentication fails, the firewall falls back to NTLM authentication. If you did not configure NTLM, or NTLM authentication fails, the firewall falls back to web-form authentication
    - web-form — To authenticate users, the firewall uses the certificate profile you specified when configuring Captive Portal or the Authentication Profile you select in the authentication enforcement object. If you select an Authentication Profile , the firewall ignores any Kerberos SSO settings in the profile and presents a Captive Portal page for the user to enter authentication credentials
    - no-captive-portal — The firewall evaluates Security policy without authenticating users
- Authetication profile my be none, then one in Captive portal settings is used


### Captive Portal - Authentication Portal

Device > User Identification > Authentication Portal Settings  

- Timers - Idle + How log to store User-IP mapping
- GlobalProtect Network Port for Inbound Authentication Prompts (UDP) - To facilitate MFA notifications for non-HTTP applications (such as Perforce) on Windows or macOS endpoints, a GlobalProtect app is required. When a session matches an Authentication policy rule, the firewall sends a UDP notification to the GlobalProtect app with an embedded URL link to the Authentication Portal page. The GlobalProtect app then displays this message as a pop up notification to the user
- SSL/TLS service profile - redirect requests over TLS
- Authentication profile - global setting, can be overrided by Authentication policy
- Mode
    - Transparent - impersonates the original destination URL, issuing an HTTP 401 to invoke authentication. However, because the firewall does not have the real certificate for the destination URL, the browser displays a certificate error to users attempting to access a secure site. Therefore, use this mode only when absolutely necessary, such as in Layer 2 or virtual wire deployments
    - Redirect - intranet hostname (a hostname with no period in its name) that resolves to the IP address of the Layer 3 interface on the firewall to which web requests are redirected. The firewall intercepts unknown HTTP or HTTPS sessions and redirects them to a Layer 3 interface on the firewall using an HTTP 302 redirect to perform authentication. This is the preferred mode because it provides a better end-user experience (no certificate errors). If you use Kerberos SSO or NTLM authentication, you must use Redirect mode because the browser will provide credentials only to trusted sites. Redirect mode is also required if you use Multi-Factor Authentication to authenticate Captive Portal users
- Certificate authentication profile - for authenticating users via certificate

### Authentication policy

Basicly it defines whom to show captive portal.

Policies > Authentication

- Source in all forms
- Destination in all forms
- Service/URL category
- Authentication enforcement object
- Logging

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

## Site-to-Site tunnels

Palo Alto Supports 3 VPN deployments:

- Site-to-site VPN: IPSec or GRE or GRE inside IPSec(For multicast and broadcast)
- Remote-user-to-site VPN: SSL
- Large scale VPN (LSVPN) - This deployment uses the Palo Alto Networks GlobalProtect LSVPN. It provides a scalable mechanism to provide a hub-and-spoke VPN for up to 1,024 branch offices

All tunnels are configured in Network section  

### IPSec tunnels

How traffic is routed:

- Option 1: You create a tunnel, no IPs, you create static routes specifing only interface, and it works
- Option 2: You create a tunnel, configure IPs on both ends, use dynamic routing or static routing, and it works
- Option 3: You create a tunnel, configure Proxy-IDs, and it works, without IPs, without routing - policy based VPN - only with third party devices, legacy - as I understand does not work on Palo Alto to Palo Alto

Concepts

- The tunnel interface must belong to a security zone to apply policy, and it must be assigned to a virtual router 
- Tunnel interface and the physical interface are assigned to the same virtual router
- Tunnel interface can be in VPN zone and physical interface in External zone, for example
- An IP address is only required if you want to enable tunnel monitoring or if you are using a dynamic routing protocol to route traffic across the tunnel
- With dynamic routing, the tunnel IP address serves as the next hop IP address for routing traffic to the VPN tunnel
- All tunnels require IPsec and Crypto Profiles for Phase 1 and Phase 2 connectivity
- Route-based VPNs - virtual router decides where to send what
- On Palo Alto OSPF works without enabling GRE....somehow
- Monitor profile can be used to monitor IPSec tunnel or next hop device, failover action is available
- The tunnel comes up only when there is interesting traffic destined to the tunnel

#### Policy-based VPN and Proxy-ID

- Palo Alto to Palo Alto policy based VPN is not supported
- Policy-based VPN only for connection with third party devices, old ones, you must configure a local and remote Proxy ID for them
- Proxy-ID: Local Subnet, Remote Subnet, Protocol, Name
- Tunnel interface can have a maximum of 250 Proxy IDs
- Proxy IDs force splitting the single configuration into multiple IPSec tunnels
- Creating multiple tunnels through proxy IDs will spread the load over more cores
- When multiple Proxy IDs are configured, the naming of the Policy IDs is important because the order of the proxy ID matching depends on the string order of the proxy ID name
- Proxy-IDs may overlap
- For proxy IDs with overlapping subnets, define the proxy ID names so that a more specific proxy ID name is above the broader Proxy ID name, as per String Sorting
- Proxy-IDs are referenced during quick mode/IKE phase 2 negotiation, and are exchanged as proxy IDs in the first or the second message of the process 
- Proxy-IDs should match completely
- If the proxy ID is not configured, because the Palo Alto Networks firewall supports route-based VPN, the default values used as proxy ID are source ip: 0.0.0.0/0, destination ip: 0.0.0.0/0 and application: any
- Each proxy ID is counted as a VPN tunnel, and therefore counted towards the IPSec VPN tunnel capacity of the firewall
- The advantage with the proxy IDs is the ability to get granular with protocol numbers or TCP/UDP port numbers if you have specific traffic you want to travel over the VPN tunnel only. Proxy IDs easily enable such granularity
- Because there are 2 versions of IKE, the behavior with proxy IDs is different:
    - With IKEv1, Palo Alto Networks devices support only proxy-ID exact match. In the event where the Peer's Proxy ID's do not match, then there will be problems with the VPN working correctly.
    - With IKEv2, there is support traffic selector narrowing when the proxy ID setting is different on the two VPN gateways

#### Configuration

Configuration overview

- IKE crypto profile
- IPSec crypto pfofile
- IKE gateway
- Create tunnel Interface
- Create IPSec tunnel
- Configure routing: static or dynamic
- Add proper rules in policy

Configuration details

- Step 1: Create phase 1 crypto profile or use default: Network | Network Profiles | IKE Crypto
    - Here we configure typical IPSec options:
    - DH group: 1-20 - for key exchange - the more the better
    - Encryption algorithm, for example AES + mode + key length
    - Authentication used in MAC or HASH algorithm
    - Key life-time
- Step 2: Create IPSec crypto profile or use default: Network | Network Profiles | IPSec Crypto
    - Here we configure:
    - Protocol: ESP or AH
    - Authentication for MAC
    - DH group - elliptic curve can be chosen
    - Life time
- Step 3: Create IKE Gateway: Network | Network Profiles | IKE Gateways - connect IKE crypto profile to it + connect physical interface to it
    - Here we configure
    - Name
    - IKE mode: 1 or 2
    - IPv4 or IPv6
    - Interface - can be loopback
    - Local IP
    - Peer IP or FQDN or Dynamic (peer IP is uknown, can be any)
    - Peer address
    - Authentication: Preshared or Cert
    - Local Identification - can be none - used for Phase 1 negotiation
    - Peer Identification - can be none - used for Phase 1 negotiation
    - Passive mode - accept connection only
    - NAT traversal
    - IKE crypto profile
- Step 4: Create tunnel Interface
    - You create tunnel.1 and it creates tunnel automatically - ???
    - Add it to proper virtual router and zone
- Step 5: Create IPSec tunnel
    - Here you combine everything: Tunnel interface, IKE Gateway, IPSec crypto profile + Proxy IDs + GRE encapsulation + Replay protection + Tunnel Monitor
- Step 6: Allow IKE negotiation and IPSec/ESP packets. By default the IKE negotiation and IPSec/ESP packets would be allowed via the intrazone default allow
- Step 7: Configure routing: static or dynamic. If static, we may avoid ip addresses on tunnel interfaces, so we configure route with Tunnel interface as a next hop. For dynamic routing we need configure IP on Tunnel interfaces
- Step 8: Allow required traffic between sites

If we need another site, we:

- Create new IKE Gateway
- Create new IP Sec tunnel
- Enable dynamic routing on this tunnel
- Add required rules

#### Redundancy

- Two different ISPs - 2 different tunnels
- Tunnel.1 is configured for Primary VPN tunnel
- Tunnel.2 is configured for Secondary VPN tunnel 
- Both tunnel interfaces are configured under Security Zone "L3-VPN"

There are three methods to do VPN tunnel traffic automatic failover. Any one of the below methods can be used. 

- Failover using Tunnel Monitoring
- Failover using Static Route Path monitoring
- Dynamic routing protocol

#### Verify

Test gateway

```
test vpn ike-sa gateway <gateway_name>
```

Show IKE phase 1

```
show vpn ike-sa gateway <gateway_name>
```

Test IKE Phase 2

```
test vpn ipsec-sa tunnel <tunnel_name>
```

Show IKE Phase 2

```
show vpn ipsec-sa tunnel <tunnel_name>
```

Show general info about all tunnels:total amount, IPs, interfaces

```
show vpn flow
```

Filter the logs in System section

```
subtype eq vpn
```

Follow logs

```
> tail follow yes mp-log ikemgr.log
> tail follow yes mp-log cryptod.log
```

### GRE tunnels

- The firewall encapsulates the tunneled packet in a GRE packet, and so the additional 24 bytes of GRE header automatically result in a smaller MSS in the MTU. If you don’t change the IPv4 MSS adjustment size for the interface, the firewall reduces the MTU by 64 bytes by default (40 bytes of IP header + 24 bytes of GRE header)
- GRE tunneling does not support NAT between the GRE tunnel endpoints
- A GRE tunnel does not support QoS
- Networks | GRE Tunnels
- All you need to configure
    Name
    Source interface
    Source IP
    Destination IP
    Tunnel interface
    TTL (default 64)
    Keepalive
- You don’t need a Security policy rule for the GRE traffic that the firewall encapsulates. However, when the firewall receives GRE traffic, it generates a session and applies all of the policies to the GRE IP header in addition to the encapsulated traffic. The firewall treats the received GRE packet like any other packet

## GlobalProtect

### MFA

 - It is possible to request MFA for a certain application access, not only for VPN connection or User-ID
 - For example User > External Palo Alto Global Protect Gate way > LAN > Internal MFA Gateway > Application Server
 - Internal MFA Gateway may request second factor for particular application
 - Authentication policy is used, which generates captive portal for browser based apps
 - And sends notifications to global protect client for non browser apps
 - To facilitate MFA notifications for non-HTTP applications (such as Perforce) on Windows or macOS endpoints, a GlobalProtect app is required. When a session matches an Authentication policy rule, the firewall sends a UDP notification to the GlobalProtect app with an embedded URL link to the Authentication Portal page. The GlobalProtect app then displays this message as a pop up notification to the user

### Xauth

- Xauth (Extended Authentication within IKE) is what Palo Alto Networks use to support third party VPN software using the Globalprotect Gateway
- It allows the third party VPN client to authenticate through the Globalprotect auth profile as part of the IKE negotiation
- IKE V.1 must be used on the 3rd party clients: iOS, Android
- The Palo Alto Network firewall uses the OpenSSL crypto library
- Globalprotect IPsec crypto profiles aren't used for the X-auth clients
- Troubleshooting of the tunnel is done much the same way as any IPSec tunnel would be troubleshot

## VSYS

### Inter-vsys routing

- Special external Zone is created on every VSYS
- Interface is added to it
- Routes are added, next hop is VR - and you choose wich one
- Rules are created to allow communication between VSYS

## Certificates

### SSL/TLS service profile

- Used by Captive portal, GlobalProtect portals and gateways, inbound traffic on the management (MGT) interface, the URL Admin Override feature, and the User-ID™ syslog listening service
- Device > Certificate Management > SSL/TLS Service Profile
- Certificate
- TLS versions

### Certificate profile

- User and device authentication for Captive Portal, multi-factor authentication (MFA), GlobalProtect, site-to-site IPSec VPN, external dynamic list (EDL) validation, Dynamic DNS (DDNS), User-ID agent and TS agent access, and web interface access to Palo Alto Networks firewalls or Panorama
- Specify which certificates to use, how to verify certificate revocation status, and how that status constrains access
- Username field
- User domain
- CA certs
- CRL
- OCSP - takes precedence over CRL

## Service routes

- By default mgmt interface is used for all service communications: DNS, LDAP, updates...
- It can be configured via any interface separatly for every service route
- Can be configured per VSYS
- By default VSYS inherits settings from global

## Management Profiles

- Network > Network Profiles > Interface Mgmt
- Ping, Telnet, SSH, HTTP, HTTP OCSP, HTTPS, or SNMP
- Response Pages (for Authentication Portal or URL Admin Override)
- User-ID (to redistribute data and authentication timestamps)
- User-ID Syslog Listener-SSL or User-ID Syslog Listener-UDP (to configure User-ID to monitor syslog senders for user mapping over SSL or User Datagram Protocol [UDP]traffic)

