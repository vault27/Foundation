# Palo Alto

All you need to know about Palo Alto firewalls and for PCNSE exam in short and structured form

## Data Sources

- Technical documentation - https://docs.paloaltonetworks.com
- [Knowledge Base](https://knowledgebase.paloaltonetworks.com)
- Application Database - https://applipedia.paloaltonetworks.com
- Learning center Beacon - https://beacon.paloaltonetworks.com
- Live community - https://live.paloaltonetworks.com
- Security Advisories - https://security.paloaltonetworks.com
- Education services - https://www.paloaltonetworks.com/services/education
- Reference architechtures - https://www.paloaltonetworks.com/resources/reference-architectures
- Panorama Sizing and Design Guide - https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000Clc8CAC
- How to Design and Size Panorama Log Collector Environments - https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA14u000000HBw7CAG
- PAN-OS CLI Quick Start Guide
- PAN-OS Upgrade Guide
- PAN-OS New Features Guide
- SD-WAN Administrator’s Guide
- Certification Management - https://cp.certmetrics.com/paloaltonetworks/en/login
- Pearson Vue Palo Alto - https://home.pearsonvue.com/paloaltonetworks
- Book "Mastering Palo Alto Networks: Build, configure, and deploy network solutions for your infrastructure using features of PAN-OS", 2nd Edition
- GlobalProtect Administrator's Guide - 670 pages - whole world
- PAN-OS® Administrator’s Guide - 1542 pages
- PAN-OS Web Interface References
- Panorama Admin Guide
- Compatibility Matrix - https://docs.paloaltonetworks.com/compatibility-matrix
- Palo Alto General Logs and Log files that are in the managment, data and control planes overview/review - https://live.paloaltonetworks.com/t5/general-topics/knowledge-sharing-palo-alto-general-logs-and-log-files-that-are/td-p/410110
- Best Practises: https://docs.paloaltonetworks.com/best-practices
- Palo Alto Networks LIVEcommunity Youtube channel
- All release notes - https://docs.paloaltonetworks.com/release-notes
- Support PAN-OS Software Release Guidance - https://live.paloaltonetworks.com/t5/customer-resources/support-pan-os-software-release-guidance/ta-p/258304
- Everything about hardware - https://docs.paloaltonetworks.com/hardware

## Portfolio

- Strata - Enterprise Security
- Prisma - Cloud Security
- Cortex - Security Operations

**Strata**

- PA-220, PA-800, PA-3200, PA-5200, and PA-7000 Series
- PA-7500 (1.5 Tbps), PA-5445, PA-45OR, PA-415-5G, PA-455
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
- Strata Cloud Manager
- SD-WAN
- PAN-OS
- CN-Series - for Kubernetes - secure traffic between pods in different trust zones and namespaces, for protection against known and zero-day malware, and to block data exfiltration from your containerized environments

**Prisma**

- **Prisma Cloud** - Cloud Security Posture Management (CSPM) - Prisma Cloud taps into the cloud providers’ APIs for read-only access to network traffic, user activity, and the configuration of systems and services.
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
- **Prisma Access Secure Access Service Edge (SASE)** - Users connect to Prisma Access cloud with GP client to access the internet and cloud and data center applications, IPSec tunnels from cloud to ON-prem, Panorama or CLoud managed
- **Prisma SaaS** - multimode CASB service that allows you to govern any sanctioned software as a service (SaaS) application - complete visibility and granular enforcement across all user, folder, and file activity within the sanctioned SaaS applications
- **VM-Series** ML-powered NGFWs
- **Prisma Access Browser**
- **Autonomous Digital Experience Management (ADEM)**

**Cortex**

Detection, investigation, automation, and response capabilities.

- Cortex XDR - Extended Detection and Response - detection and response platform that runs on integrated endpoint, network, and cloud data.  Immediate response actions. Define indicators of compromise (IOCs) and behavioral indicators of compromise (BIOCs)
- Cortex XSOAR - extended Security Orchestration, Automation, and Response - automate up to 95 percent of all of the response actions - gets data from XDR and Autofocus
- Cortex Data Lake - central log storage - Effortlessly run advanced artificial intelligence and ML with cloud-scale data - Constantly learn from new data sources to evolve defenses. The following products can utilize Cortex Data Lake:
    - Prisma Access
    - Palo Alto Networks NGFWs and Panorama devices with the ability to connect to the cloud service
    - Cortex XDR
    - Previous versions of Palo Alto Networks Traps for endpoint protection and response (now Cortex XDR)
    - Traps running version 5.0+ with the Traps management service
- Xpanse - active attack surface management solution
- Xsiam - ?

- AutoFocus - cloud-based threat intelligence service - takes data from every where and provides it for XSOAR, XDR

## Features

- Device-ID
- Dynamic address groups, user groups, external lists
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
- DoS - in three places! Zone protection profiles - protect whole zones + port scan protection only there. Separate DoS policy. DoS security profile applied to Security rule!
- NAT
- Site-to-site IPSec or GRE or GRE inside IPSec tunnels
- Global Protect RA VPN via IPSec or SSL
- Global Protect Satelite
- Global Protect HIP
- QoS - support App-ID and Users - defined in QoS policy
- SD-WAN
- DNS-Proxy
- Tags
- IP Tags
- VM Monitoring
- Dynamic Address Groups
- Dynamic External Lists
- XML API - full control of every aspect of your security, and build deep integrations with a variety of other systems. You can make XML API calls directly to the firewall, directly to Panorama, or to a firewall via Panorama
- REST API - simplifies access to resources as high-level URIs. You can use this API to create, change, and delete resources
- VSYS
- Support the Common Criteria and the Federal Information Processing Standard 140-2 (FIPS 140-2), which are security certifications
- Decryption mirror
- Decryption broker
- Network Packet Brocker
- Best Practice Assessment (BPA)
- IoT Security
- DNS Security
- Autofocus
- Cortex Data Lake
- DLP
- SAAS Security Inline
- IPv4/v6
- TAP mode
- Virtual Wire
- L2/L3 mode
- VLAN subinterfaces
- LACP
- Bonjour reflector
- Virtual routers
- Logical routers
- Service routes
- Static routing
- BGP
- OSPF
- RIP
- IP Multicast (PIM-SM, PIM-SSM, IGMP v1, v2, and v3)
- Route redistribution
- DHCP Client/PPPoE/Static
- DHCP Server/DHCP Relay/Static
- Dynamic DNS (DDNS)
- NPTv6 
- NDP Proxy 
- NAT64
- ECMP
- LLDP
- BFD
- Tunnel Content Inspection
- FQDNs

## Configuration hierarchy

- Policies: Policies section - all about traffic control
- Policies use objects and security profiles: Objects section - everything that is used in policies
- Objects
    - Addresses, Address groups, Dynamic Address groups
    - Dynamic User Groups
    - Applications, Application Groups, Application Filters
    - Services, services groups
    - Tags
    - External Dynamic Lists
- All about networks is in Network section
    - Interfaces
    - Zones
    - VLANs
    - Virtual wires
    - Virtual routers
    - IPSec tunnels
    - GRE tunnels
    - DHCP
    - DNS proxy
    - Global Protect
    - QoS - apply QoS profile to interface
    - LLDP - copy of CDP - status - enable
    - Network Profiles: All profiles connected with network: IPSec Crypto, IKE crypto, Monitors, Interface Mgmt, Zone protection, QoS, LLDP, BFD, IKE gateways
    - SD-WAN
- All other infrastructure: Device Secion: Users, User-ID, Certificates, HA...

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

## PAN-OS naming convention

- The first number indicates the major version number, the second one indicates the minor version number and the last one indicates the maintenance release version. For instance, 10.1.10 means that it is a release from major version 10, minor version 1 and maintenance release 10
- Each maintenance release is cumulative, that means it contains all the fixes from all the previous maintenance releases. 10.1.10 contains all fixes from 10.1.0.
- The higher the maintenance release version number is, the more mature the version is
- Major version and minor version numbers are to distinguish the amount of features : PAN-OS 10.0 will have more features than PAN-OS 8.1, there is no relation to the software stability
  
## Bootstraping

Bootstrap allows you to automatically config, upgrade, update signatures, license a device during initial boot.

- Attach the virtual disk, virtual CD-ROM, or storage bucket to the firewall
- Firewall scans for a bootstrap package
- Each time firewall boots from a factory default state, it checks for the presence of bootstrap volume
- If one exists, the firewall uses the settings defined in the bootstrap package
- If you have included a Panorama server IP address in the file, the firewall connects with Panorama. If the firewall has Internet connectivity, it contacts the licensing server to update the universally unique identifier (UUID) and obtain the license keys and subscriptions
- If the firewall does not have internet connectivity, it either uses the license keys that you included in the bootstrap package or connects to Panorama, which retrieves the appropriate licenses and deploys them to the managed firewalls
- If you intend to pre-register the VM-Series firewalls with Panorama with bootstrapping, you must generate a VM authorization key on Panorama and include the generated key in the init-cfg file
- The bootstrap package that you create must include the /config, /license, /software, and /content folders, even if empty, as follows:
    - /config folder: This folder contains the configuration files. The folder can hold two files, init-cfg.txt and bootstrap.xml
    - /license folder: This folder contains the license keys or authorization codes for the licenses and subscriptions that you intend to activate on the firewalls. If the firewall does not have internet connectivity, you must either manually obtain the license keys from the Palo Alto Networks Support Portal or use the Licensing API to obtain the keys and then save each key in this folder
    - /software folder: This folder contains the software images that are required to upgrade a newly provisioned VM-Series firewall to the desired PAN-OS version for the network
    - /content folder: This folder contains the Applications and Threats updates and WildFire updates for the valid subscriptions on the VM-Series firewall. You must include the minimum content versions that are required for the desired PAN-OS version
    - /plugins folder: This optional folder contains a single VM-Series plugin image

## Master key

- Is it enabled by default? - Yes default one is used everywhere
- Palo Alto Networks recommends you configure a new master key instead of using the default key, store the key in a safe location, and periodically change it
- After you enter a new key you will need it only during changing it
- On physical and virtual Palo Alto Networks devices, you can configure the master key to use the AES-256-CBC or the AES-256-GCM (introduced in PAN-OS 10.0) encryption algorithm to encrypt data such as keys and passwords. AES-256-GCM provides stronger encryption than AES-256-CBC and improves your security posture
- Master Key - Every firewall and Panorama management server has a **default master key** that encrypts all the private keys and passwords in the configuration to secure them (such as the private key used for SSL Forward Proxy Decryption
- In HA and in Panorama everywhere should be the same Masterkey and algorithm
- The only way to restore the default master key is to perform a factory reset
- **Device > Master Key and Diagnostics** - create a new Master Key + Lifetime
- You must configure a new master key before the current key expires. If the master key expires, the firewall or Panorama automatically reboots in Maintenance mode
- Time for Reminder - firewall generates an expiration alarm - The firewall automatically opens the System Alarms dialog to display the alarm
- Auto Renew Master Key to configure the firewall to automatically renew the master key for a specified number of days and hours so just to avoid expiration! - it is not a replacement for configuring a new key if the existing master key lifetime expires soon
- HSM can be used to encrypt the master key:  **Device > Setup > HSM**
- Master Key can be controlled centrally from Panorama: **Panorama > Managed Devices > Summary and Deploy Master Key**
- It cannot be edited via Templates

## Packet Flow Sequence

https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClVHCA0

<img width="1071" alt="image" src="https://user-images.githubusercontent.com/116812447/215520946-0255d873-1931-4799-b57e-4a62d4e48765.png">

- Palo Alto Networks next-generation firewalls use a unique Single Pass Parallel Processing (SP3) Architecture + Parallel Processing hardware
- A  firewall session consists of two unidirectional flows, each uniquely identified
- The ingress and forwarding/egress stages handle network functions and make packet—forwarding decisions on a per-packet basis
- The remaining stages are session-based security modules highlighted by App-ID and Content-ID

**Stages:**

- Ingress
- Firewall session lookup
- FW Session Setup SlowPath - For New sessions
- FW Fastpath - For existing sessions
- Application identification
- Content Inspection
- Forwarding/Egress

**1. Ingress**

- Any inconsistencies, errors, mismatches will be dropped
- Layer 2,3,4 headers are parsed
- Tunnel decapsulation, IPSec decryption
- Layer 3 headers of packets inside tunnel are parsed
- IP fragments are parsed
- Ingress port, 802.1q tag, and destination MAC address are used as keys to lookup the ingress logical interface. If the interface is not found, the packet is discarded. The hardware interface counter "receive error" and global counter  “flow_rcv_dot1q_tag_err” are incremented
- Some traffic maybe dropped: broadcast on L3 interface, almost all traffic on TAP interface
- Some traffic maybe forwarded without inspection: broadcast on L2 interface
- If the packet is subject to firewall inspection next stages are involved

**2. Firewall session lookup**

- Session (flow) lookup based on 6 tuple
- Each flow has a client and server component, where the client is the sender of the first  packet of the session from firewall’s perspective, and the server is the receiver of this first packet
- If session does not exist, packet goes to Stage 3
- If session exists, packet goes to Stage 4

**3. FW new session setup - slow path**

- Zone protection checks

- TCP state check

- Determine  the  packet-forwarding path: TAP - Discard, VW - Exit interface, L2 - MAC table, L3 - next hop

- NAT

- User-ID, Group mapping

- DoS protection Policy

- Security Policy Lookup - checks 6 Tuples with App - Any - Pre-NAT

- Session allocation - Session state changes from INIT (pre-allocation) to OPENING (post-allocation)

- Session is added to the flow lookup table for both C2S and S2C flows and firewall changes the session’s state from  OPENING to ACTIVE

- The firewall then sends the packet into Session Fast Path phase for security processing

**4.FW Fastpath**

- Session refresh

- TCP reassembly

- NAT

- SSL Decryption

- Captive Portal

**5.App-ID**

- Part of the fast path
- Application override policy first
- Application signatures
- Check security policy again, now with known App
- QoS policy lookup, assigns QoS class
- Mark session to be decrypted if needed

**6.Content inspection**

- Apply security Profile Action
- Re-encrypt packet

**7.Egress**

- Identify forwarding domain: L2, L3, TAP, Virtual Wire
- QoS shaping
- IP fragmentation according to MTU, if needed
- IPSec encryption
  
## Subscriptions

**15 in Total**

- URL Filtering
- Advanced URL filtering - cloud-based ML-powered web security engine to perform ML-based inspection of web traffic in real-time
- SD-WAN - Panorama + Centralized configuration management, Automatic VPN topology creation, Traffic distribution,Monitoring and troubleshooting
- Global Protect - By default, you can deploy GlobalProtect portals and gateways (without HIP checks) without a license - HIP checks and related content updates, the GlobalProtect Mobile App, IPv6 connections, or a GlobalProtect Clientless VPN
- Web Proxy - ?
- DNS Security - DNS sinkholing capabilities by querying DNS Security, cloud-based service, Threat Prevention license is prerequisite
- Support
- Wildfire - more frequent updates, advanced file type forwarding (APK, PDF, Microsoft Office, and Java Applet), WF-500, 10000 samples per day
- Advanced Wildfire - access to Intelligent Run-time Memory Analysis: a cloud-based advanced analysis engine that complements static and dynamic analysis, to detect and prevent evasive malware threats
- IoT security - Internet of Things - discover and maintain a real-time inventory of the IoT devices. automatic generation of policy recommendations to control IoT device traffic, as well as the automatic creation of IoT device attributes for use in firewall policies
- Autofocus - graphical analysis of firewall traffic logs and identifies potential risks to your network using threat intelligence from the AutoFocus portal
- Threat Prevention - Antivirus, anti-spyware (command-and-control), and vulnerability protection + basic WildFire
- Advanced Threat Protection - Threat Prevention + inline cloud-based threat detection and prevention engine
- Cortex Data Lake - cloud-based, centralized log storage and aggregation
- Virtual Systems - perpetual license - on PA-3200 - increase the number of virtual systems beyond the base number
- Enterprise Data Loss Prevention (DLP) - cloud-based protection against unauthorized access, misuse, extraction, and sharing of sensitive information
- SaaS Security Inline - works with Cortex Data Lake to discover all of the SaaS applications in use on your network

## AIOps

- When enabled, Telemetry allows the firewall to collect and forward traffic information to Palo Alto Networks
- The data collected pertains to applications, threats, device health, and passive DNS information
- Data is sent to Cortex Data lake every 5 minutes by default
- **Device > Setup > Telemetry** + enable Cortex Data Lake
- Install device certificate. It is used for connection with cloud services. It is installed from the cloud via OTP. Some firewall models already have it. OTP is generated on support portal for particular Serial
- Be sure that the device is registered in the Customer Support Portal
- Activate AIOps for NGFW (Free): https://apps.paloaltonetworks.com/hub > Toggle View by Support Account > AIOps > Activate > for NGFW > Create tenant
- Add device to particular Tenant in an account: Hub https://apps.paloaltonetworks.com/apps > Toggle View by Support Account > Common Services > Device Associations > Add appliance choosing via Serial
- Log in to AIOps for NGFW by clicking on its icon in the hub

Addresses

- *.prod.di.paloaltonetworks.cloud
- *.paloaltonetworks.com
- *.prod.di.paloaltonetworks.com
- *.prod.reporting.paloaltonetworks.com
- *.receiver.telemetry.paloaltonetworks.com
- https://storage.googleapis.com
- http://br-prd1.us.cdl.paloaltonetworks.com/ - for US

Troubleshooting

```
phiph@PA(passive)> show device-telemetry details 
Device telemetry details:
    Send interval       : 60 minutes
    Timestamp for send  : 00:06:41
    End point           : br-prd1.us.cdl.paloaltonetworks.com

phiph@PA(passive)> show device-telemetry settings 
Device Telemetry Settings:
    device-health-performance: yes
    product-usage: yes
    threat-prevention: yes
    region: Americas
    status: Device Certificate is valid 

phiph@PA2(passive)> show device-telemetry stats all 
Device Telemetry Statistics:
    device-health-performance: 
        last-attempt: Thu Feb  1 02:28:20 HKT 2024
        last-success: Mon Jan  8 10:37:56 HKT 2024
        num-of-failed-attempts: 2263
        reason: Server not reachable
        status: failed
    product-usage: 
        last-attempt: Thu Feb  1 02:28:20 HKT 2024
        last-success: Mon Jan  8 10:37:56 HKT 2024
        num-of-failed-attempts: 2263
        reason: Server not reachable
        status: failed
    threat-prevention: 
        last-attempt: Thu Feb  1 02:28:20 HKT 2024
        last-success: Mon Jan  8 10:37:56 HKT 2024
        num-of-failed-attempts: 2263
        reason: Server not reachable
        status: failed
```

## Configuration management

Configuration files:

- running-config.xml
- .snapshot.xml - save the candidate configuration as a default snapshot file
- custom-named snapshot file
- configuration versions, generated after every commit

Concepts:

- Firewall settings are stored in the XML configuration files that can be archived, restored, and managed
- A firewall contains both a running configuration that contains all of the settings that are currently active and a candidate configuration
- The candidate configuration is a copy of the running configuration, which also includes any settings changes that are not yet committed
- Changes made using the management web interface, the CLI, or the XML API are staged in the candidate until you perform commit
- During a commit operation, the candidate configuration replaces the running configuration
- When Panorama has a management relationship with a firewall, Panorama can obtain copies of both Panorama-managed and locally managed configurations
- After a commit on a local firewall a backup is sent of the running configuration to Panorama
- By default, Panorama stores up to 100 backups for each firewall although this is configurable
- To store Panorama and firewall configuration backups on an external host, you can schedule exports from Panorama or complete an export on demand
- The saved configuration files can be restored to the firewall at any time by an administrator by using the Panorama > Managed Devices > Summary
- The new versions of the running config are generated every time you make a change or click Commit
- When you edit a setting and click OK, the firewall updates the candidate configuration, but does not save a backup snapshot

In the right upper corner you can:

- Сommit: all or by me: candidate-config > running-config
- Preview all the changes: exact changes in xml configuration
- Changes summary: high level picture
- Validate commit
- Lock: take it or view
- Save changes: all or by me - .snapshot.xml - you can use it lately in "Revert to last saved config" - the same as do "Save candidate config" in Device > Setup > Operations - it will be saved after reboot
- Revert changes: all or by me - put everything back, what you changed, but did not commited

  Auto commit

  - Immediately after restarting, every Palo Alto Networks firewall performs an auto-commit. This takes place in the background and can last up to 30 minutes. The firewall can be accessed from the management interface during that time, but the data plane will be down and the physical interfaces will be down
  - To check the status of the auto-commit on the CLI, run the following command and look for the AutoCom job:

```
  > show jobs processed

Enqueued  ID  Type     Status  Result  Completed

-------------------------------------------------

10:25:02  1   AutoCom  ACT     PEND    26%
```

- If auto commit fails, we need to launch force commit - it causes the entire configuration to be parsed and pushed to the dataplane, instead of difference only

```
configure
commit force
```

## Backup

- Device > Setup > Operations
- Revert
    - Revert to last saved config - restores the config from snapshot.xml file - The current candidate configuration is overwritten - you need to do Commit after this
    - Revert to running config restores the config from running-config.xml file - The current running configuration is overridden
- Save
    - Save named configuration snapshot - saves the candidate configuration to a file - does not override running config - You can either enter a file name or select an existing file to be overwritten. Note that the current active configuration file (running-config.xml) cannot be overwritten
    - Save candidate config - Saves the candidate configuration in flash memory (same as clicking Save at the top of the page)
- Load
    - Load named configuration snapshot - Loads a candidate configuration from the active configuration (running-config.xml) or from a previously imported or saved configuration. Select the configuration file to be loaded. The current candidate configuration is overwritten
    - Load configuration version - Loads a specified version of the configuration
- Export
    - Export named configuration snapshot - Exports the active configuration (running-config.xml) or a previously saved or imported configuration - you will get a very large XML file
    - Export configuration version - choose among auto saved configurations
    - Export device state - tgz archive - not available in Panorama - running configuration, device group and template settings pushed from Panorama, certificate information, a list of satellites, and satellite authentication information
- Import    
    - Import named config snapshot - Imports a configuration file from any network location
    - Import device state (firewall only) - Import the device state information that was exported using the Export device state option. This includes the current running config, Panorama templates, and shared policies. If the device is a Global Protect Portal, the export includes the Certificate Authority (CA) information and the list of satellite devices and their authentication information

## Reboot

- Backup both devices **Device > Setup > Operations > Export device state**
- On both devices gather all possible information:
    - Check ongoing throughput and amount of sessions on active device: **show system statistics sessions**
    - Check all active IPSec VPN tunnels on Active device: **show vpn ike-sa**
    - Check all BGP peers on Active device: **show routing protocol bgp summary | match Established**
    - Check active physical interfaces on both devices: **show interface all**
    - Check status of aggregation groups on both devices: **show lacp aggregate-ethernet all**
    - Check total amount of routes on active device: **show routing summary**
    - Check connection to User-ID agents on Active device: **show user user-id-agent state all**
    - Check group mappings on Active device: **show user group-mapping state all**
    - Check chassis: **show chassis status**
    - Check ARP table and amount of records: **show arp all**
- Reboot Passive device: request shutdown/restart system
- Unplug power cords
- Reconnect both power cords of the FW (this will automatically boot up FW)
- Monitor AutoCommit is complete by doing: **show jobs all**
- Monitor if raid status is healthy: **show system raid detail**
- Verify that it has status Passive after reboot
- Verify that config is synced
- Verify that all network cards are ok for chassis: **show chassis status**
- Failover to passive: **request high-availability state suspend**
- On new Active device reset VPNs:
    - **clear vpn ike-sa**
    - **clear vpn ipsec-sa**
    - **test vpn ike-sa**
    - **test vpn ipsec-sa**
- Check all parametres: *throughput, amount of sessions, IPSec VPN tunnels, BGP peers, physical interfaces, aggregation groups, total amount of routes, User-ID agents, group mappings, chassis*
- Reboot Active device: **request shutdown/restart system**
  
## Dynamic updates

**Device > Dynamic Updates**  

Update types:

- Apps and threats - monthly
- Antivirus - every 24 hours
- URL filtering
- Wildfire - evry 5 minutes - You can set the firewall to check for new updates as frequently as every minute to ensure that the firewall retrieves the latest WildFire signatures within a minute of availability - only with Wildfire subscription
- GlobalProtect Clientless VPN - new and updated application signatures to enable Clientless VPN access to common web applications from the GlobalProtect portal
- Global protect Data file - Contains the vendor-specific information for defining and evaluating host information profile (HIP) data returned by GlobalProtect apps. You must have a GlobalProtect gateway subscription in order to receive these updates. In addition, you must create a schedule for these updates before GlobalProtect will function
- Device Dictionary
- WF-Private

Configure for every Update type:

- Recurrance
- Minutes past half an hour
- Action: Download only/Download and install
- Disable new apps - you can first prepare policy updates for newly identified applications, then safely enable new applications that may be treated differently following the update. You can see all disabled applications in **Objects > Applications > Disabled Applications**
- Threshold - hours - Content releases must be available on the Palo Alto Networks update server at least this amount of time before the firewall can retrieve the release and perform the Action you configured
- New App ID Threshold - hours
- Sync to peer
- All these options may arrive via Panorama

Action types:

- Download
- Install
- Review policies - shows policies from Security, QoS, PBF, SD-WAN with modified and new apps
- Review apps - shows new and modified apps
- Release notes - future changes + New apps + modified apps + modified decoders + new vulnerability signatures + modified vulnerability signatures + new file types
- Revert - to previous version
- Commit is not required

Best Practices for Content Updates 2 types:

- Mission-Critical 
- Security-First

Mission critical

- Always review Content Release Notes
    -  Customer Support Portal > Preferences > Subscribe to Content Update Emails
    -  Content Release Notes for apps and threats on the Palo Alto Networks Support Portal
    -  Firewall: Device > Dynamic Updates > Release Note
    -  Notes section of Content Release Notes: future important updates - you can account for any policy impact in advance of the release
- Always review the new and modified App-IDs that a content release introduces - 
- Critical content alerts are logged as system log entries with the following Type and Event: (subtype eq dynamic-updates) and (eventid eq palo-alto-networks-message) - configure forwarding of these events to personell
- Test new Applications and Threats content updates on a test firewall
- Schedule content updates so that they download-and-install automatically. Then, set a Threshold that determines the amount of time the firewall waits before installing the latest content. In a mission-critical network, schedule up to a 48 hour threshold
- Create a security policy rule to always allow New App Ids in certain categories, for example auth-service, it is done here: **Objects > Application Filters > Add > Apply to New App-IDs only**
- Deploy updates in small branches first to test
- Use New App-ID Threshold option and Threshold

Forcefully install dynamic updates

```
request content upgrade install force yes commit no file panupv2-all-contents-8827-8653.tgz
```

## Upgrade

**High level plan**

- Verify upgrade path
- Download images
- Backup
- Prepare local admin password
- Prepare console cable
- Person on-site
- Pro-active vendor case
- Disable monitoring system
- System prechecks on all devices
- Active prechecks on active devices
- Send notification email
- Upgrade passive device
- Reboot Verifications
- Failover
- Failover verifications
- Upgrade second device
- Reboot verifications
- Failover
- Failover verifications
- Enable monitoring system
- Send notification
- Backout plan
- Backout verifications

**Upgrade path**

- We need to fully understand where we can jump in terms of version, what will be fixed
- Devices with different versions can work in HA pair

**Download images**

- Downloaded versions are kept on the device, until deleted

**Backup**

- Backup both devices **Device > Setup > Operations > Export device state**

**System pre checks**

On both devices in HA pair

- Check that Preemptive is disabled **Device > High Availability > Election Settings**
- Check HA Status on Dashboard
- Log all SSH output
- Disable pager - set cli pager off
- show system info | match version
- show chassis status - only for Chassis
- show system raid detail - where applicable
- show interface all
- show lacp aggregate-ethernet all
- show system statistics session - Sessions synchronization works
- show system disk-space
- debug software disk-usage cleanup deep threshold 90
- show system state | match aggressive

**Active Prechecks**

- show vpn ike-sa - where applicable
- show routing protocol bgp summary | match Established
- show routing summary

?
- show user user-id-agent state all | match Agent\|Status - where applicable
- show user group-mapping state all - where applicable
- show user ip-user-mapping all - where applicable
- show user group list - where applicable
- show global-protect-gateway current-user | match users - where applicable

**Upgrade Passive Device**

- request system software check
- request system software download version <insert version number>
- show jobs id <insert ID>
- debug swm history (Shift+G to go to bottom of page, and confirm download or installation is successful)
- request system software install version <insert version number>
- show jobs id <insert ID> or show jobs all
- request restart system  
- System Prechecks after reboot

- Failover, run on Active Device:
    - request high-availability state suspend
    - request high-availability state functional
- Reset VPN connections if applicable

```
clear vpn ike-sa
clear vpn ipsec-sa
test vpn ike-sa
test vpn ipsec-sa
```

- Perform Active Prechecks on new Active (former Passive) device
- Upgrade Passive (Former Active) Device
- Switch back Active one and perform Active Checks

Show history off all upgrades

```
debug swm history
```
Shift+G to go to bottom of page  
Even with a factory reset, this command can still get a history of the software first installed and subsequent upgrades and downgrades.

## Disk Space

Some common symptoms of the root partition getting filled up are:

- Unable to log in or access Web UI
- Certain daemons processes not starting
- Incomplete tech support bundles
- System log alerts with "Disk usage for / exceeds limit,  X percent in use, cleaning file system"
- Root partition is high
- Automatic cleaning of disk-space is done only when the disk-space reaches 95% and this 95% is fixed and cannot be currently changed

Some of the common causes of a filled partition:

- An admin troubleshooting certain processes and creates core files. These files are stored on the root and remain there until deleted by the administrator
- Enabling of diagnostic logs for the dataplane (packet diags) can also take up space on the root partition

```
show system disk-space
```

Has to be run manually to bring the disk usage to below 90%. It is designed for platforms when 95% automatic disk clean up is not sufficient to hold TSF generated. It includes cleanup by deleting backup logfiles.  If you need this command run periodically, an external periodic script may be invoked.

```
debug software disk-usage cleanup deep threshold <90%-100%>
```

Automatically applied when 95% disk usage is detected and more aggressive cleaning is applied, including removing more backup log files.  
This will automatically truncate all old log files (entries under all *var/log/pan directories matching *.1, ... *.4, *.log.old) if the 95% occupancy alarm is tripped

```
debug software disk-usage aggressive-cleaning enable
> show system state | match aggressive-cleaning
cfg.debug-sw-du.config: { 'aggressive-cleaning': True, }
```

```
delete content cache old-content
```

Check Core files:

```
show system files
/opt/dpfs/var/cores/:
total 4.0K
drwxrwxrwx 2 root root 4.0K Jun 10 20:05 crashinfo

/opt/dpfs/var/cores/crashinfo:
total 0
 
/var/cores/:
total 115M
drwxrwxrwx 2 root root 4.0K Jun 10 20:15 crashinfo
-rw-rw-rw- 1 root root 867M Jun 12 13:38 devsrvr_4.0.3-c37_1.gz
-rw-rw-rw- 1 root root  51M Jun 12 13:39 core.20053
 
/var/cores/crashinfo:
total 16K
-rw-rw-rw- 1 root root 15K Jun 10 20:15 devsrvr_4.0.3-c37_0.info
```

Delete unnecessary core files. A core file can be deemed unnecessary if investigation around the core file is complete or they are very old files.

```
> delete core management-plane file devsrvr_4.0.3-c37_1.gz
```

Limit amount of dowmloaded software images

```
> set max-num-images count x ( x can be any number between 2 to 64)
```

SMART monitoring

```
debug system disk-smart-info disk-1 | match Media_Wearout_Indicator
```

## Performance

**CPU**

- Resource widget: both datalane and management CPU
- show running resource-monitor - data plane, per core, per group of resources

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

**Heat map**

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

**BPA report**

- Executive summary in Palo Alto web site
- Detailed HTML report is downloaded
- Best practises summary: NIST for example
- Security Profile Adoption
- Application and User control adoption
- Logging and zone protection adoption

## Network

### Zones

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

- L3: L3 interfaces, VLAN, Loopback, Tunnel
- L2: L2 interfaces
- Tap: tap interfaces
- Virtualwire: virtual wire interfaces
- Tunnel: no interfaces, 

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
- Zone protection profile, usually for outside zone

**Zone protection profile**

Features:

- Enablement of zone protection should be very cautious, it main ruin your network
- If zone protection drops traffic, it is in Threat logs, it is in special counters without specifics about IPs because it drops traffic on very early stages
- Check drop counters:

```
show zone-protection zone trust
```

- Show amount of land attacks

```
show interface ethernet1/1 
```

- Outputs for packets dropped by DOS protection and zone protection

```
show counter global 
```

There are 5 sections in a profile:

- Flood protection
- Reconnaissance protection - port scans
- Packet based attack protection - check packet headers and drop undesirable
- Protocol protection - non-IP protocol-based attacks - block or allow non-IP protocols between security zones on a Layer 2 VLAN or on a virtual wire, or between interfaces within a single zone on a Layer 2 VLAN (Layer 3 interfaces and zones drop non-IP protocols so non-IP Protocol Protection doesn’t apply) - block is based on Ethertype field in Ethernet frame
- Ethernet SGT protection - drop traffic based on Security Group Tag (SGT) in Ethernet frame, when your firewall is part of a Cisco TrustSec network - you configure which tags to drop
- L3 & L4 Header Inspection - only when enabled globally - write custom threat (vulnerability) signatures based on Layer 3 and Layer 4 header fields (such as IP flags, acknowledgment numbers, etc)
    - Device > Setup > Session - enable globally
    - Configure L3 & L4 Header Inspection in Zone Protection Profile
    - You configure several rules, for example: destination port, source IP, some field in the header
    - Add profile to Zone + in Zone enable Enable Net Inspection

Floods:

- The firewall measures the aggregate amount of each flood type entering the zone in new connections per second (CPS) and compares the totals to the thresholds you configure in the Zone Protection profile
- For each flood type, you set three thresholds for new CPS entering the zone
- You can set a drop Action for SYN floods: Random Early Drop (RED) - simple Drop basically or SYN cookies
- 5 Flood types configurable: SYN, ICMP, ICMPv6, UDP, and other IP flood attacks
- Configure thresholds in CPS:
    - Alarm Rate - 15-20 % above normal CPS
    - Activate - start dropping
    - Maximum - 80-90 % load
- Random Early Drop (RED, also known as Random Early Detection) used for all floods 
- For SYN - SYN Cookies can be used besides RED
- SYN Cookies — Causes the firewall to act like a proxy, intercept the SYN, generate a cookie on behalf of the server to which the SYN was directed, and send a SYN-ACK with the cookie to the original source. Only when the source returns an ACK with the cookie to the firewall does the firewall consider the source valid and forward the SYN to the server. This is the preferred Action
- Random Early Drop drops traffic randomly, so RED may affect legitimate traffic
- SYN Cookies is more resource-intensive
- Monitor the firewall, and if SYN Cookies consumes too many resources, switch to RED
- Port Scan Protection is available only in zone protection profile, not in DoS profile

### Interfaces

**Physical interfaces types**

- L2
     - There are: **L2 interface, VLAN interface, VLAN, subinterface based on VLAN**
- L3: IP address, zone, virtual router
- Virtual wire - no routing or switching, no MAC or IP addresses, blocking or allowing of traffic based on the virtual LAN (VLAN) tags. You assign 2 physical interfaces to one virtual wire.
    - It ignores any Layer 2 or Layer 3 addresses for switching or routing purposes
    - A virtual wire interface does not use an Interface Management Profile
    - All the firewalls that are shipped from the factory have two Ethernet ports (port 1 and port 2) preconfigured as virtual wire interfaces. These interfaces allow all of the untagged traffic
- TAP passively monitor traffic flows across a network by using a switch port analyzer (SPAN) or mirror port
- HA
- Aggregate interfaces - IEEE 802.1AX link aggregation - harwdware media can be mixed - interface type must be the same - 8 groups, some models - 16, 8 interfaces un each group - naming: ae.1-8
- Decrypt Mirror - routing of copied decrypted traffic through an external interface to another system, such as a data loss prevention (DLP) service

**Logical interfaces rypes**

- Subinterfaces: Layer 3, Layer 2, and Virtual Wire - using 802.1Q
    - On one physical aggegate interface we can create many L3 or L2 subinterfaces, based on VLAN ID
    - **Aggegate/Ethernet interface type should match all subinterfaces types**
    - When you you create a subinterface, you cannot even choose its type, it is taken from physical interface
    - Virtual Wire Subinterfaces using VLAN tags only: You assign 2 physical interfaces to one virtual wire, on each interface you create sub interface with particular VLAN-ID. The same VLAN tag must not be defined on the parent virtual wire interface and the subinterface
    - Virtual Wire Deployment with Subinterfaces (VLAN Tags and IP Classifiers): First firewall looks on the VLAN tag and matches against proper subinterface, but several subinterfaces may use the same VLAN - 100, then it uses IP classifier: source IP address and this helps him to match proper subinterface. For return-path traffic, the firewall compares the destination IP address as defined in the IP classifier on the customer-facing subinterface and selects the appropriate virtual wire to route traffic through the accurate subinterface
- Tunnel interfaces - virtual interfaces for VPN, should be in the same virtual router as physical - separate VPN zone for them is recomended. IP is required only when dynamic routing is used or for tunnel monitoring. Policy based VPN requires Proxy ID on both sides. 
- Loopback interfaces - connect to the virtual routers in the firewall, DNS sinkholes, GlobalProtect service interfaces (such as portals and gateways)
- VLAN interface - this is L3 interface, connected to a VLAN, like in Cisco
- SD-WAN - ?

**VLANs**

- Each Layer 2 interface defined on the firewall can be associated with a VLAN
- The same VLAN can be assigned to multiple Layer 2 interfaces but each interface can belong to only one VLAN
- In VLAN configuration we add L2 interfaces
- We also add static MAC configuration: which MAC on which interface
- And we assign VLAN interface - this is like on Cisco, so VLAN has an IP address

**MAC addresses + speed/duplex**

The MAC addresses of the HA1 interfaces, which are on the control plane and synchronize the configuration of the devices are unique.   
The MAC addresses of the HA2 interfaces, which are on the data plane and synchronize the active sessions mirror each other

```
show interface all - including VMAC for Active-Passive HA cluster
ethernet1/5             20    1000/full/up              00:1b:17:00:0b:14
HA Group ID = 0b Hex (11 Decimal) and Interface ID = 14 Hex (20 Decimal)

show interface ethernet1/1
show high-availability state - The following command displays the MAC addresses of an HA cluster
show high-availability virtual-address - displays VMAC and VIP for Active-Active HA cluster
```

**Physical media connected to a port**

```
show system state filter-pretty sys.s(x).p(y).phy [x=slot number and y=port number]
show system state filter-pretty sys.s1.p1.phy
sys.s1.p1.phy: {
link-partner: { },
media: CAT5,
type: Ethernet,
}
```

**Interface counters**

```
show system state filter-pretty sys.s(x).p(y).stats [x=slot number and y=port number]
show system state filter-pretty sys.s1.p1.stats
sys.s1.p1.stats: {
rx-broadcast: 0,
rx-bytes: 0,
rx-multicast: 0,
rx-unicast: 0,
tx-broadcast: 0,
tx-bytes: 0,
tx-multicast: 0,
tx-unicast: 0,
}
```
### Routing

- All forwarding is based on FIB, FIB is generated based on RIB
- Another Virtual Router can be used as next hop, then packet will be forwarded according to that VR FIB
- Other possible next hops: FQDN, Discard - for black hole, None - for Tunnel interfaces
- Route tables for static routes: Unicast, Multicast, Both
- All ingress traffic goes to firewall itself or virtual router object, vlan object or virtual wire object
- Legacy virtual routers: RIP, OSPF, OSPFv3, BGP, multicast, static routes, redistribution, administrative distances
- Advanced Route Engine of virtual routers supports the Border Gateway Protocol (BGP) dynamic routing protocol and static routes, can be only one - for large data centers, enterprises, ISPs, and cloud services
- IPsec tunnels are considered Layer 3 traffic segments for implementation purposes and are handled by virtual routers like any other network segments. Forwarding decisions are made by destination address, not by VPN policy
- There are limitations for the number of entries in the forwarding tables (forwarding information bases [FIBs]) and the routing tables (routing information bases [RIBs]) in either routing engine
- Lower administrative distanse is prefered
- ECMP: 4 routes max: no need to wait for RIB recalculation, load balancing, all links load, disabled by default
- Route monitoring
- PBF 
- Application-specific rules are not recommended for use with PBF because PBF rules might be applied before the firewall has determined the application
- Virtual routers can route to other virtual routers within the same firewall
- Each Layer 3 Ethernet, loopback, VLAN, and tunnel interface defined on the firewall must be associated with a virtual router
- Each model supporting a different maximum of virtual routers
- To prioritise one OSPF path over another we have to lower its interface metric, the lower the metric the better
- Metric is used for all routing protocols, including static routes
- For static routes we can configure metric and administrative distance during creation
- If we have 2 redundant links between 2 PAs with OSPF there might be assymetry in traffic - pings work fine
- OSPF cost is called metric here
- 2 reduntant IPSec tunnels + OSPF - if main fails - it takes 5 pings to rebuild routing table
- Static routes support BFD and Path monitoring
- Path monitoring is configured inside route: Src IP, Dst IP, Ping interval, Ping Count, can be several rules, Any or All logic, preemtive hold time min: number of minutes a downed path monitor must remain in Up state before the firewall reinstalls the static route into the RIB - to avoid flapping
- There is a special static routes monitoring tab in routing stats
- Policy rules do not influence these pings
- Redistribution example: create redistribution profile, choose static, enter required destination prefix, choose redistribute, set priority: Profiles are matched in order (lowest number first), apply this path to OSPF and set metric that will be sent to OSPF

### BGP

BGP states

- IDLE
- Connect - 3-way handshake only - if stuck here - the problem is with the TCP
- Active- - if stuck here - the problem is with the TCP
- Open-sent - BGP_OPEN message sent with all parametres
- Open-confirm - reply from neighbor received
- Established - keepalive message received after Open-confirm

Restart/Refresh BGP Sessions  
Restarting a BGP session will build the BGP routing table from scratch (intrusive). Refreshing the session will only fetch/ look out for new routes (non-intrusive)  

For self initiation:

```
> test routing bgp virtual-router default restart self   (for restarting BGP connections)
> test routing bgp virtual-router default refresh self   (for refreshing BGP connections)
```

From Peer side:
```
> test routing bgp virtual-router default restart peer <BGP peer>  (for restarting BGP connections)
> test routing bgp virtual-router default refresh peer <BGP peer>  (for refreshing BGP connections)
```

### Dual ISP design

- One default gateway to ISP-1 with metric 10 - primary one
- Second default gateway to ISP-2 metric 50 - backup one
- Add a rule to Policy Based Forwarding Policy: non-crytical applications send to ISP2, attach a monitoring profile, then if ISP2 is down, PBF rule will be disabled

### IPv6

- To enable IPv6 on firewall:
    - Enable IPv6 on the interface
    - Add IPv6 address
    - Device > Setup > Session > Enable IPv6 firewalling
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

**IPv6 Configuration workflow**

- You enable IPv6 on interface
- You configure address
- You enable Duplicate Address Detection
- You enable  NDP Monitoring - you can view the IPv6 addresses of devices on the link local network, their MAC address, associated username from User-ID, eachability Status of the address, and Last Reported date and time the NDP monitor received a Router Advertisement from this IPv6 address
- You enable RA-Router Advertisment
- You enable DNS support - include DNS information in Router Advertisment: Recursive DNS servers and lifetime, suffixes and lifetime, lifetime - the maximum length of time the client can use the specific RDNS Server to resolve domain names

### Service routes

- Device > Setup > Services > Global > Service Route Configuration
- Can be customized for VSYS
- Virtual systems that do not have specific service routes configured inherit the global service and service route settings for the firewall
- Modification of an Interface IP Address to a different IP address or Address Object will not update a corresponding Service Route Source Address
- You can configure IPv4, IPv6 and Destination Service Route
- You choose service and configure Source Interface and Source IP address
- By default mgmt interface is used for all service communications: DNS, LDAP, updates...
- It can be configured via any interface separatly for every service route
- Can be configured per VSYS
- By default VSYS inherits settings from global
- You can select a virtual router for a service route in a virtual system; you cannot select the egress interface
- Destination service routes are available under the Global tab only
- You can use a destination service route to add a customized redirection of a service that is not supported on the customized list of services
- A destination service route is a way to set up routing to override the FIB route table. Any settings in the destination service routes override the route table entries. They could be related or unrelated to any service

### DHCP Relay

- Network > DHCP > DHCP Relay
- Maximum of eight external IPv4 DHCP servers and eight external IPv6 DHCP servers
- A client sends a DHCPDISCOVER message to all configured servers
- Firewall relays the DHCPOFFER message of the first server that responds back to the requesting client
- You can add many DHCP relays
- You configure interface where it will listen for requests + IPv4 Server addresses + IPv6 Server Addresses

### Monitor profiles

- Network > Network Profiles > Monitor
- Monitor IPSec tunnels and to monitor a next-hop device for policy-based forwarding (PBF)
- Monitor profiles are optional
- Action
    - wait-recover—Wait for the tunnel to recover; do not take additional action. Packets will continue to be sent according to the PBF rule
    - fail-over—Traffic will fail over to a backup path, if one is available. The firewall uses routing table lookup to determine routing for the duration of this session
- Interval - time between heartbeats
- Threshold - number of heartbeats to be lost

## Policies

**10 in total**

- Security
- NAT
- QoS
- Policy Based Forwarding
- Decryption
- Tunnel inspection - inspect GRE, non-encrypted IPSec, GTP-U, VXLAN
- Application Override
- Authentication - whom to show captive portal
- DoS protection - ?
- SD-WAN - ?

### Security policy 

Options

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

Concepts

- Top to down
- Left to right
- New rule is created under currently selected rule
- Mandatory match criterias: Source Zone and Destination Zone
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

Policy optimizer

- Enable Policy Rule Hit Count
- Policies > Security > Left Down part of screen
- Rules without apps
- Unused apps
- Unused rules
- App viewer
- Highlight Unused Rules - Any rules not used since the dataplane started up will be highlighted

**Show unused rules from CLI**

```
admin@Lab-2(active)> show running rule-use highlight vsys vsys1 rule-base security type unused
```

### NAT

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

Rule types:

- ipv4
- nat64
- nptv6 - IPv6-to-IPv6 Network Prefix Translation

### QoS

QoS is enforced on traffic as it egresses the firewall   

Unclassified traffic enters firewall > **QoS Policy** assignes **class** to traffic > **QoS Profile** on Egress interface prioritizes traffic accorsing to **QoS class**  

You can also mark traffic in a security policy - in a security rule  
Enables the firewall to mark traffic with the same DSCP value that was detected at the beginning of a session (in this example, the firewall would mark return traffic with the DSCP AF11 value). While configuring QoS allows you to shape traffic as it egresses the firewall, enabling this option in a Security rule allows the other network devices intermediate to the firewall and the client to continue to enforce priority for DSCP-marked traffic  

- Self-contained system local to the firewall
- Can consider existing QoS packet markings but does not act directly on them
- Ingress traffic cannot be managed
- QoS profile - matching traffic is then shaped based on the QoS profile class settings as it exits the physical interface. Each QoS profile rule allows you to configure individual bandwidth and priority settings for up to eight QoS classes, as well as the total bandwidth allowed for the eight classes combined. In every profile you configure priorities for every class. Then you apply a profile to an interface.
- QoS policy - define traffic you want to receive QoS treatment and assign that traffic a QoS class. QoS policy rule is applied to traffic after the firewall has enforced all other security policy rules, including Network Address Translation (NAT) rules.
- QoS egress interface - this is where you apply QoS profile. If you limit Youtube then Egress interface is Internal interface of FW. You apply it in separate section Network > QoS
- DSCP classification allows you to both honor DSCP values for incoming traffic and mark a session with a DSCP value as session traffic exits the firewall
  

**QoS policy**  

**Policies > QoS**  
Define a QoS policy rule to match to traffic based on:

- Applications and application groups
- Source zones, source addresses, and source users
- Destination zones and destination addresses
- Services and service groups limited to specific TCP and/or UDP port numbers
- URL categories, including custom URL categories
- Differentiated Services Code Point (DSCP) and Type of Service (ToS) codepoints, consist of codepoint type and value, which are used to indicate  the level of service requested for traffic, such as high priority or best effort delivery
    - Expedited Forwarding (EF) Type: Can be used to request low loss, low latency, and guaranteed bandwidth for traffic. Packets with EF codepoint values are typically guaranteed the highest-priority delivery - one value only
    - Assured Forwarding (AF): Can be used to provide reliable delivery for applications. Packets with AF codepoint indicate a request for the traffic to receive higher priority treatment than what the best-effort service provides (although packets with an EF codepoint continue to take precedence over those with an AF codepoint) - many possible values
    - Class Selector: Can be used to provide backward compatibility with network devices that use the IP precedence field to mark priority traffic - 8 possible values
    - IP Precedence (ToS): Can be used by legacy network devices to mark priority traffic (the IP precedence header field was used to indicate the priority for a packet before the introduction of the DSCP classification) - 8 possible values
    - Custom Codepoint: Can be used to match to traffic by entering a codepoint name and binary value
- At the end you define a class for this traffic: 1 of 8 + schedule
  

**QoS profile**

**Network > Network Profiles > QoS Profile**

- For the profile you configure Egress Max and Egress guaranteed 
- For every class which you defined in QoS Policy you configure Priority, Egress MAX and Egress Guaranteed
- Egress MAX and Egress Guaranteed are in Mbps or percentage
- **Network > QoS**: combine interface + profile
- Can be applied only to physical interface
- You may configure Egress MAX here as well
- You configure Default QoS profile for regular (ClearText) traffic and Tunnel traffic
- For both ClearText and Tunnel traffic you can configure many rules with many profiles besides Default, based on Source interface and Source subnet
- For both ClearText and Tunnel traffic you can configure Egress MAX and Egress Guaranteed
- Egress guaranteed specifies the amount of bandwidth guaranteed for matching traffic. When the egress-guaranteed bandwidth is exceeded, the firewall passes traffic on a best-effort basis. Bandwidth that is guaranteed but is unused continues to remain available for all of the traffic
- Egress max specifies the overall bandwidth allocation for matching traffic. The firewall drops the traffic that exceeds the egress max limit set

### Policy Based Forwarding

- Separate policy: **Policy > Policy Based Forwarding**
- Source conditions: Zone, Interface, Address, User + Negate
- Destination conditions: Address, Application, Service + Negate
- Actions: Forward, Discard, No PBF - for exceptions
- Egress interface, Next hop
- Monitor based on monitor profile and destination address
- Enforce Symmetric Return or Return to Sender feature: This feature forwards the packet to the MAC address from where the SYN or lost packet was received
- Example: Request from Internet client arrives via ISP1, but reply is sent via ISP2 - because it is a default route
- We create a PBF rule: source interface of ISP1, destination address of Internal server, Action forward to interface where Internal server is connected, enable "Enforce Symmetric Return" and add Next Hop Address of ISP1
- After this sessions from ISP1 to internal server will be monitored and return traffic will be sent to MAC address of ISP1 router, despite the default route to ISP2
- Adding Next Hop Address is not mandatory - for example when Internet client is on the same subnet

**Show all PBF rules**

```
> show pbf rule all

Rule       ID    Rule State Action   Egress IF/VSYS  NextHop                                 NextHop Status
========== ===== ========== ======== =============== ======================================= ==============
ISP2_webac 1     Active     Forward  ethernet1/2     172.16.31.1                             UP     
```

**Show all PBF policy**

```
> show running pbf-policy

ISP2_webaccess {
        id 1;
        from trust;
        source any;
        destination any;
        user any;
        application/service [ ftp/tcp/any/21 web-browsing/tcp/any/80 ];
        action Forward;
        symmetric-return no;
        forwarding-egress-IF/VSYS ethernet1/2;
        next-hop 172.16.31.1;
        terminal no;
}
```

**Test PBF policy**

```
> test pbf-policy-match from trust application web-browsing source 192.168.0.7 destination 93.184.216.34 protocol 6 destination-port 80

ISP2_webaccess {
        id 1;
        from trust;
        source any;
        destination any;
        user any;
        application/service [ ftp/tcp/any/21 web-browsing/tcp/any/80 ];
        action Forward;
        symmetric-return no;
        forwarding-egress-IF/VSYS ethernet1/2;
        next-hop 172.16.31.1;
        terminal no;
```

**Show all sessions for PBF policy**

```
> show session all filter pbf-rule ISP2_webaccess

--------------------------------------------------------------------------------
ID          Application    State   Type Flag  Src[Sport]/Zone/Proto (translated IP[Port])
Vsys                                          Dst[Dport]/Zone (translated IP[Port])
--------------------------------------------------------------------------------
9873         web-browsing   ACTIVE  FLOW  NS   192.168.0.7[4015]/trust/6  (172.16.31.2[7914])
vsys1                                          93.184.216.34[80]/ISP2  (93.184.216.34[80])
```

### Decryption

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
- SSH - inbound and outbound - called SSH proxy - does not require certificates

**Without decryption**

- Application in traffic logs: SSL or Youtube base (Based on cert or SNI)
- No Decrypted tick in log details
- URL filtering works, but does not show block page, just drops
- Safe search enforcement does not work
- App-ID does work partially: server cert
- Content-ID does not work
- The firewall can’t decrypt traffic inside an SSH tunnel

**Policy includes**

- Source (IP, Zone, User, Device)
- Destination (Zone, address, device)
- Service/URL category
- DECRYPT OR NOT
- Type of decryption: Forward, Inbound or SSH
- Decryption profile
- Logging

**Profile includes**

- Expired certs, untrusted certs
- Unsupported ciphers
- Client auth
- Key exchange algorithms, Protocols version, Encryption algorithms, Authentication algorithms
- Unsupported versions and algorithms in SSH

**Concepts**

- We can use Decryption policy with action No decrypt in order to Block untrusted certs + Expired certs
- You can block all the SSH tunnel traffic by configuring a Security policy rule for the application ssh-tunnel with the Action set to **Deny** (along with a Security policy rule to allow traffic from the ssh application)
- When you apply an SSH Decryption profile to traffic, for each channel in the connection, the firewall examines the App-ID of the traffic and identifies the channel type. The channel type can be one of the following:
    - session
    - X11
    - forwarded-tcpip
    - direct-tcpip
- When the channel type is session, the firewall identifies the traffic as allowed **SSH traffic**, such as SFTP or SCP
- When the channel type is X11, forwarded-tcpip, or direct-tcpip, the firewall identifies the traffic as **SSH tunneling** traffic and blocks it
- It is recomended to configure Decryption profile: block unsupported versions and algorithms for SSH
- If firewall uses Forward Untrust certificate to decrypt normal website, then this website does not send intermediate certificate and firewall cannot trace its server cert to CA cert
- Decryption policies enable you to specify traffic for decryption according to destination, source, user/user group, or URL category
- Untrusted servers are sighned using special forward untrust certificate - ensures that clients are prompted with a certificate warning when attempting to access sites hosted by a server with untrusted certificates
- Decryption policy rules are compared against the traffic in sequence, so more specific rules must precede the more general ones
- The key used to decrypt SSH sessions is generated automatically on the firewall during bootup. With SSH decryption enabled, the firewall decrypts SSH traffic and blocks or restricts it based on your decryption policy and Decryption Profile settings. The traffic is re-encrypted as it exits the firewall
- Decryption can be performed only on the **virtual wire, Layer 2, or Layer 3 interfaces**
- Decrypting traffic based on URL categories is a best practice for both URL Filtering and Decryption

**Configuration** 

We configure policy based on profile  
In profile we configure all SSL settings - avoid weak ciphers and protocols  
Than we mark one cert as forward proxy  

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

Palo Alto Networks provides a predefined SSL Decryption Exclusion list that excludes hosts with applications and services that are known to break decryption technically (pinned certificate, an incomplete certificate chain, unsupported ciphers, or mutual authentication) from SSL Decryption by default  
You can add more sites to this list  
**Device > Certificate management > SSL Decryption Exclusion**  
You can also force some of these sites to be decrypted

**Troubleshooting**

- Enable Log at session start for security rule for connectivity troubleshooting
- **ACC > SSL Activity**: successful and unsuccessful decryption activity in your network, including decryption failures, TLS versions, key exchanges, and the amount and type of decrypted and undecrypted traffic
- **Monitor > Logs > Decryption**: comprehensive information about individual sessions that match a Decryption policy, use a No Decryption policy for traffic you don’t decrypt, and GlobalProtect sessions when you enable Decryption logging in GlobalProtect Portal or GlobalProtect Gateways configuration
- SSL Decryption Exclusion List -  from Palo Alto - Automatically Updated
- Local Decryption Exclusion Cache - automatically adds the servers that local users encounter that break decryption for technical reasons and excludes them from decryption - when Decryption Profile allows unsupported modes
- Custom Report Templates for Decryption

### Tunnel Inspection

### Application Override

### Authentication policy

Basicly it defines whom to show captive portal.

**Policies > Authentication**

- Source in all forms
- Destination in all forms
- Service/URL category
- Authentication enforcement object
- Logging

The following logical objects are used to support Authentication Policy:  
**MFA profile > Authentication profile > Authentication enforcement object > Authentication Policy + Captive Portal settings in paralell + Authentication sequence in parallel**

**Multi-Factor authentication**

- **Device > Server Profiles > Muli Factor Authentication**
- Create a profile
- Configure Certificate profile, choose vendor (DUO for example) and configure options for vendor
- The MFA factors that the firewall supports include push, Short Message Service (SMS), voice, and one-time password (OTP) authentication
- These profiles are connected as Factors to Authentication profile, several Factors can be addded

**Authentication profile**

Types:

- Cloud - ?
- Local Database
- Radius
- LDAP
- TACAS+
- SAML
- Kerberos - single sign on + keytab

**Device > Authentication Profile** > What to configure:

- Type - ?
- MFA profiles, several can be added
- Allow list
- Failed attempts
- User domain

**Authentication sequence**

- **Device > Authentication Sequence**
- We can create several
- We add different authentication profiles to a sequence
- Order of profiles matter

**Authentication enforcement object**

- **Objects > Authentication**
- Is assigned to Authentication policy rules
- We configure here method, authentication profile, and text message for user
- Methods:
    - browser-challenge — The firewall transparently obtains user authentication credentials. If you select this action, the Authentication Profile you select must have Kerberos SSO enabled or else you must have configured NTLM in the Captive Portal settings . If Kerberos SSO authentication fails, the firewall falls back to NTLM authentication. If you did not configure NTLM, or NTLM authentication fails, the firewall falls back to web-form authentication
    - web-form — To authenticate users, the firewall uses the certificate profile you specified when configuring Captive Portal or the Authentication Profile you select in the authentication enforcement object. If you select an Authentication Profile , the firewall ignores any Kerberos SSO settings in the profile and presents a Captive Portal page for the user to enter authentication credentials
    - no-captive-portal — The firewall evaluates Security policy without authenticating users
- Authetication profile my be none, then one in Captive portal settings is used

**Captive Portal - Authentication Portal**

**Device > User Identification > Authentication Portal Settings**  

- Timers - Idle + How log to store User-IP mapping
- GlobalProtect Network Port for Inbound Authentication Prompts (UDP) - To facilitate MFA notifications for non-HTTP applications (such as Perforce) on Windows or macOS endpoints, a GlobalProtect app is required. When a session matches an Authentication policy rule, the firewall sends a UDP notification to the GlobalProtect app with an embedded URL link to the Authentication Portal page. The GlobalProtect app then displays this message as a pop up notification to the user
- SSL/TLS service profile - redirect requests over TLS
- Authentication profile - global setting, can be overrided by Authentication policy
- Mode
    - Transparent - impersonates the original destination URL, issuing an HTTP 401 to invoke authentication. However, because the firewall does not have the real certificate for the destination URL, the browser displays a certificate error to users attempting to access a secure site. Therefore, use this mode only when absolutely necessary, such as in Layer 2 or virtual wire deployments
    - Redirect - intranet hostname (a hostname with no period in its name) that resolves to the IP address of the Layer 3 interface on the firewall to which web requests are redirected. The firewall intercepts unknown HTTP or HTTPS sessions and redirects them to a Layer 3 interface on the firewall using an HTTP 302 redirect to perform authentication. This is the preferred mode because it provides a better end-user experience (no certificate errors). If you use Kerberos SSO or NTLM authentication, you must use Redirect mode because the browser will provide credentials only to trusted sites. Redirect mode is also required if you use Multi-Factor Authentication to authenticate Captive Portal users
- Certificate authentication profile - for authenticating users via certificate


### DoS Protection

Describes to which traffic apply DOS protection profile - aggregate or classified or both + Logging + Schedule+  
DoS profiles are the same as for Security Profile  

- Control the systems to which the firewall applies DoS protection
- What action to take when traffic matches the criteria
- How to log DoS traffic
- Use Zone Protection profiles to protect entire zones against floods and other attacks. DoS Protection policy rules provide granular matching criteria so that you have the flexibility to define exactly what you want to protect
- Specifying services limits DoS protection to those services, but doesn’t block other services
- You can Schedule when a DoS Protection policy rule is active
- One use case for scheduling is to apply different flood thresholds at different times of the day or week

Actions:

- Deny — The firewall denies access and doesn’t apply a DoS Protection profile. Traffic that matches the rule is blocked.
- Allow - The firewall permits access and doesn’t apply a DoS Protection profile. Traffic that matches the rule is allowed.
- Protect — The firewall protects the devices defined in the DoS Protection policy rule by applying the specified DoS Protection profile or profiles thresholds to traffic that matches the rule. A rule can have one aggregate DoS Protection profile and one classified DoS Protection profile, and for classified profiles, you can use the source IP, destination IP, or both to increment the flood threshold counters, as described in Classified Versus Aggregate DoS Protection. Incoming packets count against both DoS Protection profile thresholds if the they match the rule. 

The Allow and Deny actions enable you to make exceptions within larger groups  

**DoS profile Objects > Security Profiles > DoS Protection**

- Two types: Aggregate or Classified


### SD-WAN

## Security profiles

All Security Profiles are in Objects > Security Profiles  
10 profiles in total  
7 are applied in a security policy  
Threat exceptions for antivirus, vulnerability, spyware, and DNS signatures (sub type of AntiSpyware signatures) can be added in a profile  
For Spyware, Vulnerability signatures  you can change default Action: Drop, Reset....

- Antivirus
- Antispyware
    - DNS security
    - Advanced Threat Protection
- Vulnerability Protection
- URL filtering
    - User credential protection
- File blocking
- Wildfire analysis
- Data filtering
- DoS protection - separate DoS policy
- SCTP protection - Stream Control Transmission Protocol (SCTP) Protection - mobile networks
- Mobile Network Protection - inspect GTP traffic - mobile networks

<img width="712" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/1d86b533-ba26-4894-b550-35aa76e314da">

Three types of signatures:

- Antivirus - malware and viruses, including worms, Trojan horses, and spyware downloads - the daily antivirus content update + this update includes DNS (C2) signatures
- Anti-spyware - C2 spyware on compromised hosts that try to phone-home or beacon out to an external C2 server - The Applications and Threats content updates
- Vulnerability - detect exploit system vulnerabilities - The Applications and Threats content updates

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
- drop: This action drops the application traffic
- reset-client: For TCP, this action resets the client-side connection. For UDP, it drops the
connection.
- reset-server: For TCP, this action resets the server-side connection. For UDP, it drops the
connection.
- reset-both: For TCP, this action resets the connection on both client and server ends. For
UDP, it drops the connection

**Antivirus**

- Protect against viruses, worms, trojans, spyware downloads
- Enable protocol decoders: ftp, http, imap, pop3, smb, smtp
- For every decoder 3 types of actions needed to be chosen + Wildfire Inline ML model:
    - Signature action
    - Wildfire signature action
    - Wildfire Inline ML action
- Choose application exceptions
- Choose signatures exceptions
- Configure Wildfire ML
- Stream-based malware prevention engine, which inspects traffic the moment the first packet is received - good performance
- Default generates alerts for the SMTP, IMAP, and POP3 protocols while blocking for FTP, HTTP, and Server Message Block (SMB) protocols
- Minimize traffic inspection between trusted security zones
- Machine learning is used to identify malware in real time in: Portable executable, ELF (executable and linked format), and MS Office files, PowerShell, shell scripts
- WildFire-based signatures are used in addition to Antivirus
- WildFire inline ML, you must possess an active WildFire subscription

**Anti-Spyware**

- Several policies in one Profile
- Signatures are added to Policy by severity and by name and by category
- One action for all signatures in Policy, or default
- Signature exceptions: enable or disable + change action
- DNS exceptions
- DNS white domains
- Blocks connections to the external C2 servers
- Default profile uses default action inside a signature
- Block IP: This action blocks traffic from either a source or a source-destination pair. It is configurable for a specified period of time
- You can also enable the DNS Sinkholing action in the Anti-Spyware Profiles to enable the firewall to forge a response to a DNS query for a known malicious domain, thus causing the malicious domain name to resolve to an IP address that you define
- This feature helps to identify infected hosts on the protected network by using DNS traffic. Infected hosts can then be easily identified in the Traffic and Threat logs because any host that attempts to connect to the sinkhole IP address is most likely infected with malware
- In this profile DNS Security is also configured - Palo Alto Networks DNS Security service, a cloud-based analytics platform providing your firewall with access to DNS signatures generated using advanced predictive analysis and machine learning, with malicious domain data from a growing threat intelligence sharing community
- Active DNS Security and Threat Prevention (or Advanced Threat Prevention) subscription is required

**Advanced Threat Prevention**

- Advanced Threat Prevention is a cloud-delivered security service that works in conjunction with the existing Threat Prevention license to deliver protections for advanced and evasive C2 threats
- No update packages required
- ML based engines
- Uses Wildfire bases + humans
- Support the analysis of C2-based threats over HTTP, HTTP2, SSL, unknown-UDP, and unknown-TCP applications
- Advanced Threat Prevention is enabled and configured under inline cloud analysis in the Anti-Spyware Profile
- In addition to signatre based, inline detection system to prevent unknown and evasive C2 threats

**Vulnerability Protection**

- Create profile, Add rules and exceptions too profile
- Signatures are added to rule, based on CVE, Vendor ID, Severity, Category
- Packet capture can be enabled
- Action for all signatures in a rule or Default
- Host type can be configured: client or server 
- When the vulnerability protection action profile is set to reset-both, the associated threat log might display action as reset-server. As discussed earlier, this occurs when the firewall detects the threat at the beginning of a session and presents the client with a 503-block page. Since, the block place disallows the connection, only the server-side connection is reset
- The default Vulnerability Protection Profile protects clients and servers from all known critical-, high-, and medium-severity threats

### URL Filtering

- Works without decryption, but does not show Block Page - just drops
- Without decryption Application in URL filtering logs is always SSL  
- By default, categories set to allow do not generate URL filtering log entries. The exception is if you configure log forwarding
- If you want the firewall to log traffic to categories that you allow but would like more visibility into, set Site Access for these categories to alert in your URL Filtering profiles
- We cannot see domains in traffic logs
- Separate logs vault: **Monitor > URL Filtering**
- In traffic logs blocked URLs will appear as Allow action, but session end reason will be Threat
- **Device > Setup > Content-ID > URL-filtering >  Category lookup timeout (sec)** + all other timers are there
- **Device > Setup > Content-ID > URL Admin Override** - enter password, after this user can with this password visit the URL - To create a URL admin override, set the action for a category to override
- You can also use URL categories as match criteria in Security policy rules
- You can also use URL categories to enforce different types of policy, such as Authentication, Decryption, QoS, and Security
- Every URL can have up to four categories
- Brightcloud database can also be used

**What it does**

- For every category 2 options: Site Access (alert, allow, block, continue, override, none) and User Credential Submission (alert, allow, block, continue)
- Safe Search Enforcement
- Log container page only
- HTTP header logging: User-Agent, Referer, X-Forwarded-For
- User Credential Detection Options + logging it with particular severity
- HTTP Header Insertion
- Inline ML or Advanced URL filtering
- Custom URL categories

**Control access to site**

Actions for site access:

- alert - log
- allow
- block - block page is displayed
- continue - Block page is displayed - then user access site
- override - Displays a response page that prompts the user to enter a valid password to gain access to the site. Configure URL Admin Override settings (Device > Setup > Content ID) to manage password and other override settings
- none - custom URL category only

**Credential detection**

- Configure user-credential detection so that users can submit credentials only to the sites in specified URL categories
- Credential phishing prevention works by scanning username and password submissions to websites and comparing those submissions against valid corporate credentials. You can choose which websites you want to allow or block corporate credential submissions based on the URL category of the website
- How firewall knows which credentials are prohibited to enter on physhing sites and that they are enterprise:
    - IP address-to-username mapping - what User-ID has collected, only username is checked
    - Group mapping (using PAN-OS integrated agent) - firewall gets via LDAP all groups and users and use this data as well
    - Domain credential filter (using Windows-based agent): The User‐ID agent is installed on a Read-Only Domain Controller. The User‐ID agent collects password hashes that correspond to users for whom you want to enable credential detection, and it sends these mappings to the firewall. The firewall then checks if the source IP address of a session matches a username and if the password submitted to the web page belongs to that username. With this mode, the firewall only blocks or alerts on the submission when the submitted password matches a user password
- Windows User-ID agent configured with the User-ID credential service add-on

Actions for credential detections:

- alert - log
- allow
- block - block page is displayed
- continue - Anti Physhing continue page is displayed - then user may enter credentials

**Safe search enforcement**

- Palo Alto Networks enforces filtering based only on search engine providers filtering mechanisms
- If users search using Google, Bing, Yahoo, Yandex, or YouTube search engines and they did not set their safe search setting to the strictest setting, then your firewall responds in one of two ways
    - Blocks Search Results When Strict Safe Search Is Off (Default
    - Forces Strict Safe Search - The firewall automatically and transparently enforces the strictest safe search settings

**HTTP Header Insertion**

In URL filtering Objects > Security Profiles > URL Filtering > HTTP Header Insertion HTTP header insertion is supported  
The firewall supports header insertion for HTTP/1.x traffic only  
The firewall does not support header insertion for HTTP/2 traffic  
HTTP Header Insertion for certain SaaS applications that can prevent users from accessing private instances of a SaaS application while having access to the organization’s sanctioned environment  
HTTP header insertion can only be performed by using the following methods:

- GET
- POST
- PUT
- HEAD

**Custom categories**

- Objects > Custom objects > URL Category
- URL list
- Category match: specifying two or more PAN-DB categories of which the new category will consist, allows you to target enforcement for a website or page that matches all of the categories specified in the custom URL category object

**Inline ML or Advanced URL Filtering**

- Advanced URL Filtering is a subscription service that works natively with the Palo Alto Networks NGFW
- Advanced URL Filtering uses ML to analyze URLs in real time and classify them into benign or malicious categories
- The inline web security engine enables real-time analysis and categorization of URLs that are not present in PAN-DB, Palo Alto Networks cloud-based URL database
- URLs Analyzed in real-time using the cloud-based Advanced URL Filtering detection modules. This is in addition to URLs being compared to entries in PAN-DB. The ML-powered web protection engine detects and blocks the malicious websites that PAN-DB cannot
- URLs Inspected for phishing and malicious JavaScript using local inline categorization, a firewall-based analysis solution, which can block unknown malicious web pages in real-time
- If network security requirements in your enterprise prohibit the firewalls from directly accessing the Internet, Palo Alto Networks provides an offline URL filtering solution with the PAN-DB private cloud. You can deploy a PAN-DB private cloud on one or more M-600 appliances that function as PAN-DB servers within your network; however, the private cloud does not support any of the cloud-based URL analysis features provided by the Advanced URL Filtering solution
- Own analysis, Wildfire
- Advanced URL Filtering prevents 40 percent more threats than traditional web-filtering databases
- Select Inline ML and define an Action for each inline ML model
- Add URL exceptions to your URL Filtering profile if you encounter false-positives

**Using URL Categories as Match Criteria vs. Applying URL Filtering Profile to a Security Policy Rule**

Use URL categories as match criteria in the following cases:

- To create an exception to URL category enforcement
- To assign a particular action to a custom or predefined URL category. For example, you can create a Security policy rule that allows access to sites in the personal sites and blogs category.

Use a URL Filtering profile in the following cases:

- To record traffic to URL categories in URL filtering logs
- To specify more granular actions, such as alert, on traffic for a specific category
- To configure a response page that displays when users access a blocked or blocked-continue website.

### Data Filtering

- Prevent sensitive information, such as credit card numbers or Social Security numbers, from leaving a protected network
- Filter on keywords, such as a sensitive project name or the word “confidential.”
- Predefined patterns: Filter for a list of over 20 predefined patterns, including Social Security numbers, national identity numbers from various nations, credit cards, and other useful patterns
- Regular expressions: Filter for a string of characters
- File properties: Filter for file properties and values based on file type

### File Blocking

- Create profile, add rules
- Every rule has application, file types, direction and action
- Specified session flow direction (inbound/outbound/both)
- Alert or block on upload or download, and you can specify which applications will be subject to the File Blocking Profile
- Custom response pages
- Possible actions
    - alert
    - block
    - continue: After the specified file type is detected, a customizable response page is presented to the user. The user can click through the page to download the file. A log is also generated in the Data Filtering log. This type of forwarding action requires user interaction and is therefore only applicable for web traffic
- Monitor > Logs > Data Filtering - All File Block logs are here

### WildFire

Operation workflow

<img width="889" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/acccb91d-fb34-40a9-a1df-d1f151054bb2">

Platform in general:

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
- Updates every day, with Wildfire license 5 mins after appearing
- Monitor > Logs > WildFire Submissions to see if any internal custom-built programs trigger WildFire signatures
- WildFire can discover zero-day malware in web traffic (HTTP/HTTPS), email protocols (SMTP, IMAP, and POP), and FTP
- WildFire cloud—global, regional, and private
- As soon as the firewall downloads and installs the new signature, the firewall can block the files that contain that malware (or a variant of the malware). Malware signatures do not detect malicious and phishing links; to enforce these links, you must have a PAN-DB URL Filtering license
- If not done already, enable the firewall to perform decryption and Forward Files for Advanced WildFire Analysis Select Device > Setup > Content-ID
- Wildfire check is skipped if: file is signed by a trusted signer, file has matched a previous submission, file larger than 50 mbs
- WF-500 does not support bare-metal analysis - suspicious files are sent to a real, racked-and-stacked hardware environment where they are detonated, and any response is observed for malicious behavior
- Wf-500 does not support apk, mac-os, linux, scripts, archives
- Files are not quarantined pending WildFire evaluation. In cases of positive malware findings, the security engineer must use the information collected on the firewall and by WildFire to locate the file internally for remediation
- WildFire typically renders a verdict on a file within 5 to 10 minutes of receipt
- Wildfire never quarantine files

**Configuration workflow**

- Create profile, add rules
- Every rule has application, file types, direction and anaylysis type: public cloud or private cloud
- Forward unknown files or email links for WildFire analysis
- Specify files to be forwarded for analysis based on application, file type, and transmission direction (upload or download)
- WildFire public cloud or the WildFire private cloud (hosted with a WF-500 appliance)
- WildFire hybrid cloud deployment: WildFire appliance to analyze sensitive files (such as PDFs) locally, less-sensitive file types (such as PE files) or file types that are not supported for WildFire appliance analysis (such as APKs) to be analyzed by the WildFire public cloud

**Verdicts**

- Benign
- Grayware - do not pose a direct security threat but might display otherwise obtrusive behavior. Grayware can include adware, spyware, and Browser Helper Objects (BHOs)
- Phishing
- Malicious

File sizes

<img width="827" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/9b8ad671-00d7-47e8-93f4-78e8e21b953f">

**Licenses**

- The basic WildFire service is included as part of the Palo Alto Networks next generation firewall and does not require an Advanced WildFire or WildFire subscription
    - Firewall can forward portable executable (PE) files for analysis: EXE, DLL, SCR, FON, etc...
    - Can retrieve Advanced WildFire signatures only with antivirus and/or Threat Prevention updates which are made available every 24-48 hours
- Advanced WildFire license
    - Advanced WildFire signature updates - Real time
    - Advanced WildFire Inline ML
    - Advanced file type forwarding: APKs, Flash files, PDFs, Microsoft Office files, Java Applets, Java files (.jar and .class), and HTTP/HTTPS email links contained in SMTP and POP3 email messages
    - WildFire private cloud analysis does not support APK, Mac OS X, Linux (ELF), archive (RAR/7-Zip), and script (JS, BAT, VBS, Shell Script, PS1, and HTA) files
    - WildFire API
    - Local WildFire appliance
- Advanced WildFire subscription
    - Advanced cloud-based detector
- Standalone subscription that provides API-only access

**DoS Protection**

- In a profile you configure: Type, Flood protection, Resources protection
- Profile is not applied in security policy, it is applied in separate DoS policy
- Types:
    - Aggregated - you want to apply extra constraints on specific subnets, users, or services
    - Classified - Sets flood thresholds that apply to each individual device specified in a DoS Protection policy rule. For example, if you set a Max Rate of 5,000 CPS, each device specified in the rule can accept up to 5,000 CPS before it drops new connections.
- 5 Flood protections, as in zone protection profile:
    - SYN
    - UDP
    - ICMP
    - ICMPv6
    - Other IP
- For every flood you configure 4 parametres:
    - Alarm Rate
    - Activate Rate
    - Max Rate
- For SYN flood you also configure Action: RED or SYN-cookies
- For resources protection you configure only Max Concurent Sessions
- Control the number of sessions between interfaces, zones, addresses, and countries based on aggregate sessions or source and/or destination IP addresses
- Flood protection: Detects and prevents attacks in which the network is flooded with packets, which results in too many half-open sessions or services being unable to respond to each request. In this case, the source address of the attack is usually spoofed
- Resource protection: Detects and prevents session exhaustion attacks. In this type of attack, many hosts (bots) are used to establish as many fully established sessions as possible for consuming all of a system’s resources
- You can enable both types of protection mechanisms in a single DoS Protection profile
- Threshold settings for the synchronize (SYN), UDP, and Internet Control Message Protocol (ICMP) floods; enables resource protection; and defines the maximum number of concurrent connections. After configuring the DoS Protection profile, you attach it to a DoS policy rule

Global Packet Buffer Protection — The firewall monitors sessions from all of the zones (regardless of whether Packet Buffer Protection is enabled in a zone) and how those sessions utilize the packet buffer. You must configure Packet Buffer Protection globally (Device > Setup > Session Settings) to protect the firewall and to enable it on individual zones. When packet buffer consumption reaches the configured Activate percentage, the firewall uses Random Early Drop (RED) to drop packets from the offending sessions (the firewall doesn’t drop complete sessions at the global level)  

Per-Zone Packet Buffer Protection — Enable Packet Buffer Protection on each zone (Network > Zones) to layer in a second level of protection. When packet buffer consumption crosses the Activate threshold and global protection begins to apply RED to session traffic, the Block Hold Time timer starts. The Block Hold Time is the amount of time in seconds that the offending session can continue before the firewall blocks the entire session. The offending session remains blocked until the Block Duration time expires

## Sessions

- Session is defined by two uni-directional flows each uniquely identified by a 6-tuple key: source-address, destination-address, source-port, destination-port, protocol, and security-zone
- First flow as client-to-server(c2s) and the returning flow as server-to-client(s2c)

Show all sessions

```
show session all
```

Show one session in details
- Offload yes - Marks the traffic for which the application has been identified already and it will be processed in hardware.
- Layer7 processing - If enabled, then App-ID has been enabled on the traffic flow and the application is constantly identified. If Layer7 processing is set to complete, then the application has been identified

```
show session id [ID]
```

Show general configuration and statistics

```
show session info
```

Show maximum number of sessions for each VSYS

```
show session meter
```

**Session types**

- Flow - Regular type of session where the flow is the same between c2s and s2c (ex. HTTP, Telnet, SSH)
- Predict - This type is applied to sessions that are created when Layer7 Application Layer Gateway (ALG) is required. The application has been identified and there is need for a new session to be allowed on the firewall without any additional security rule (ex. FTP active/passive, voice protocols h323/sip etc). These sessions may be created with a 0 as source/destination IP/port, since that information may not be known yet. Packets that match the Predict sessions will then change to normal FLOW session

Show all predict sessions - show only the predict sessions that are currently pending to be matched by packets

```
show session all filter type predict
```

**Session flow**

- Init > Opening > Active > Discard/Closing > Closed > Free
- If the session timeout has been reached, the session will timeout and transition to Closing
- If the traffic has been denied due to a security rule or a threat has been detected(with the action set to drop), the session will transition to Discard

**Stable session states**

- INIT - Every session begins, by default, in INIT state. A session in the INIT state is part of the free pool and can be used at anytime. The session may been used previously, but has now been returned back into the free pool
- ACTIVE - Any session that matches a particular traffic flow, and has been processed for inspection and forwarding.
- DISCARD - Traffic that has been matched by a session but is denied due to a security policy, threat detection

**Transient session states**

Sessions in Transient states are difficult to see as they make the transition to one of the Stable states very quickly

- Opening
- Closing
- Closed
- Free

**Session Flags**

- NS - There has been Source NAT applied on the session
- ND - There has been Destination NAT applied on the session
- NB -There has been Both Source + Destination NAT applied on the session
- No flag - There is no NAT applied on the session.

**Session end reasons**

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

**Session timeouts**

- Timeout - The specific timeout configured for the application
- Time to live - The time left until the session will expire. In the example, there are 2 seconds left until the session will expire and session state will change
- Session in session ager - For each session there is a flow ager, which is an aging process that keeps track of the lifetime of sessions. As long as the session is Active and time to live did not reach 0 sec, the session in session ager will be marked as True

**Sessions in HA deployment**

The user can tell if a session has not been created on the local firewall by looking at the session synced from HA peer from
>show session id

A session created locally on the firewall will have the False value and one created on the peer device and synchronized to the local firewall will have the True value

## App-ID

- 6-Tuple is checked against the security policy > known application signatures > check if it is SSH, TLS, or SSL > decryption policy (if exists) > checked again for a known application signature inside TLS > the application has not been identified (a maximum of 4 packets after the handshake, or 2,000 bytes) > will use the base protocol to determine which decoder to use to analyze the packets more deeply > unknown-tcp > check policy if unknown is allowed  
- **SSL > Web-Browsing > flickr > flickr-uploading**: NGFW continiously watches at traffic app, the more data it gets, then identificationis changed
- The application decoder will continuously scan the session for expected and deviant behavior, in case the application changes to a sub-application or a malicious actor is trying to tunnel a different application or protocol over the existing session
- App-ID database does not require license for upgrade
- New App-IDs are released on the third Tuesday of every month
- Application and threat signatures are delivered in a single package
- If the protocol is unknown, App-ID will apply heuristics
- Use App-ID instead of service and protocols and port based
- App-ID without decryption identifies application based on server certificate: CN field, if it is exact, then it will be google-base for example, if there is a wildcard, it will be SSL app
- Application override - only for trusted traffic - create custom application based on zones, ips, ports... - used to decrease load on NGFW - it does not analyze App for certain traffic
- To configure App override configure the following:
- Create a custom app configuring its characteristics:
    - Charachteristics
    - Category and subcategory
    - Risk
    - Timeout
    - Port
    - Signatures
- Add rule to Override policy: Policies > Application Override > Specify source and destination of traffic + port and configure newly created App
- Application Override bypasses App-ID (including threat and content inspection), create an Application Override policy for only the specific business-critical application, and specify sources and destinations to limit the rule
- The exception to this is when you override to a pre-defined application that supports threat inspection
- Application override - used for custom applications
- Application groups for convenience
- Application filters - they are dynamic - based on categories or tags
- Custom application signature is always prefereable over downloaded
- Application Block Page works for the applications that needs CTD (Content-ID Decoder) inspection but "web-browsing" or "ssl" application is classified earlier than the transaction in CTD
- App-ID blocks can be seen in Traffic Logs
- Best pratice Moving from Port-Based to App-ID Security: set of rules that aligns with business goals, thus simplifying administration and reducing the chance of error:
      - Assess your business and identify what you need to protect
      - Segment your network by using interfaces and zones
      - Identify allow list applications
      - Create user groups for access to allow list applications
      - Decrypt traffic for full visibility and threat inspection
      - Create best-practice Security Profiles for the internet gateway for all allow rules
      - Define the initial internet gateway Security policy, Using the application and user group inventory

**App-ID database**

- Description
- Depends on Applications
- Category
- Subcategory
- Risk
- Standard ports
- Technology 
- Deny action 

**App-ID status in logs**

- Incomplete - three-way TCP handshake did not complete OR no enough data after the handshake - is not really an application
- Insufficient data - not enough data to identify the application - for example one data packet after the handshake
- unknown-tcp - firewall captured the three-way TCP handshake, but the application was not identified - custom app, no signatures
 - unknown-udp - custom app, no signatures
 - unknown-p2p - generic P2P heuristics
 - Not-applicable - port is blocked

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
- If you want to delete all registered IP addresses, use the CLI command

```
debug object registered-ip clear all
then reboot the firewall after clearing the tags
```
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
- HA Lite

HA Lite:

- Active/Passive
- PA-200
- No sessions sync
- No HA-2
- Synchronization of IPsec security associations

**HA Concepts**

- Up to 16 firewalls as peer members of an HA cluster
- Configure HA then everything else: Interfaces, policies....
- Active firewall has less priority
- Firewall-specific configuration such as management interface IP address or administrator profiles, HA specific configuration, log data, and the Application Command Center (ACC) information is not shared between peers
- Any Layer 3 interface that is already active in the network will receive a new MAC address once HA is enabled (and committed), which could cause connectivity issues while switches and clients learn the new MAC associated with the firewall IPs. Some ARP tables may need to be cleared and static entries updated
- In Active/Passive mode, on Passive node interfaces are down by default
- In Active/Passive mode IPs and MACs are identical, when failover happens, gratuitous ARPs (GARPs) are sent. On hypervisors MACs are different, because they are set by Hypervisor, it can be changed in Palo Ato Settings
- After commit changes are automatically sent to Passive
- You can make changes on Passive, press Commit and it will go to Active
- ICMP sessions are not synced

Failover reasons

- Link monitoring: If an interface goes down, the member fails - you just create Link Group - add there many interfaces - Any of them or All should fail to trigger failover
- Path monitoring: If an IP becomes unavailable, the member fails - you create a path group with a list of IP addresses - separate for VLAN, Virtual Wire, Virtual router - all or any should fail
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

**Prerequisites**

- Model
- PAN-OS version
- UP-to-date application, URL, threat databases
- HA unterfaces types
- Licenses
- Slot configuration
- For VMs: HYpervisor, number of CPU cores


**Links**

7 Links in total, all are configured in HA Communications section
- HA-1 control link (Control Plane) - should be HA type or management
    - L3 link, requires IP, mask, gateway - can be spanned via subnets
    - Hello, heartbeats, HA state info, User-ID, config sync
    - ICMP is used to exchange heartbeats between HA peers
    - Ports used for HA1 — TCP port 28769 and 28260 for clear text communication; port 28 for encrypted communication (SSH over TCP)
    - Dedicated HA port should be used on big models, if not Management port is used
    - Monitor Hold Time (ms)— Enter the length of time, in milliseconds, that the firewall will wait before declaring a peer failure due to a control link failure (range is 1,000 to 60,000; default is 3,000). This option monitors the physical link status of HA1 ports
- HA-2 data link (Data plane) - HA type
    - Layer 2 link, ether type 0x7261 by default, available: IP (protocol number 99) or UDP (port 29281), can span subnets. The benefit of using UDP mode is the presence of the UDP checksum to verify the integrity of a session sync message
    - Session info, forwarding tables, IPSec, ARP
    - Data flow on the HA2 link is always unidirectional (except for the HA2 keep-alive); it flows from the active or active-primary firewall to the passive or active-secondary firewall 
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
    - The firewalls use this link for forwarding packets to the peer during session setup and asymmetric traffic flow 
    - It does not support Layer 3 addressing or encryption
    - You cannot configure backup links for the HA3 link, only LAG 
    - The firewall adds a proprietary packet header to packets traversing the HA3 link, so the MTU over this link must be greater than the maximum packet length forwarded
- HA4
    - Layer 3 type no gateway, no spaning over subnets, HA type
    - Session cache synchronization among all HA cluster members having the same cluster ID + keep-alives between Cluster members
- HA4 Backup

**CLoud limitations**

- The VM-Series firewall on Azure and VM-Series firewall on AWS only support active/passive HA
- When you deploy the firewall with the Amazon Elastic Load Balancing (ELB) service on AWS, it does not support HA (in this case, ELB service provides the failover capabilities
- The VM-Series firewall on Google Cloud Platform does not support traditional HA
### Active/Passive

Supported deployments

- Virtual wire
- Layer 2
- Layer 3 

Configuration workflow

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

**Firewall states**

8 in total

- Initial - after boot-up and before it finds peer - A/P or A/A
- Active - normal traffic handling state - A/P
- Passive - normal traffic is discarded, except LACP and LLDP - A/P
- Active-Primary - A/A only
- Active-Secondary - A/A only - A firewall in active-secondary state does not support DHCP relay
- Tentative - A/A only - Failure, monitored object (a link or path), firewall leaves suspended or non-functional state - 
- Suspended - administratively disabled - A/P or A/A 
- Non Functional - error state - A/P or A/A - Failure - In active/passive mode, all of the causes listed for Tentative state cause non-functional state

**Troubleshoot**

Show HA logs in **Monitor > System**

```
( subtype eq ha ) and ( severity neq informational )
```

**Show logs in CLI about state change only**

```
show log system direction equal backward subtype equal ha eventid equal state-change
```

## Active/Active

- Advanced design concepts
- Complex troubleshooting
- Additional configuration on both firewalls
- Recommended if each firewall needs its own routing instances and you require full, real-time redundancy out of both firewalls all the time
- Active/active mode has faster failover
- Can handle peak traffic flows better than active/passive mode because both firewalls actively process traffic
- Session owner: either the firewall that receives the First Packet of a new session from the end host or the firewall that is in active-primary state (the Primary device)
- If Primary device is configured, but the firewall that receives the first packet is not in active-primary state, the firewall forwards the packet to the peer firewall (the session owner) over the HA3 link
- The session owner performs all Layer 7 processing, such as App-ID, Content-ID, and threat scanning for the session. The session owner also generates all traffic logs for the session
- If the session owner fails, the peer firewall becomes the session owner
- Palo Alto Networks recommends setting the Session Owner to First Packet and the Session Setup to IP Modulo
- Setting the Session Owner to First Packet reduces traffic across the HA3 link and helps distribute the dataplane load across peers

Supported deployments:

- L3
- Virtual Wire

Does not support the DHCP client. Furthermore, only the active-primary firewall can function as a DHCP Relay. If the active-secondary firewall receives DHCP broadcast packets, it drops them

4 types of design:

- Floating IP Address and Virtual MAC Address
- Floating IP Address Bound to Active-Primary Firewall
- Route-Based Redundancy
- ARP Load-Sharing

Configuration workflow

- Enable HA
- Choose Active/Active
- Choose device ID: 0 or 1 - ?
- Enable Configsync
- Configure Peer HA1 IP
- By default they both work, just syncing configs and sessions
- If it is needed: Configure Floating IPs
    - Every IP will be floating or ARP load sharing
    - Floating IP can be bound to Active Primary Device
    - OR Device priority can be configured for devices 0 and 1 - ?

**Virtual MAC address**

- Manually configure different gateways on end systems or use load balancers
- Each firewall in the HA pair creates a virtual MAC address for each of its interfaces that has a floating IP address or ARP Load-Sharing IP address
- After the failed firewall recovers, by default the floating IP address and virtual MAC address move back to firewall with the Device ID [0 or 1] to which the floating IP address is bound
- When a new active firewall takes over, it sends gratuitous ARPs from each of its connected interfaces to inform the connected Layer 2 switches of the new location of the virtual MAC address. 

**Route based redundancy**

- Firewalls are connected  to routers, not switches
- Each firewall has separate IP addresses, sessions are synced
- If firewall fails, then based on routing protocol traffic is not sent to it
- No need to configure virtual MAC address/floating IP address, arp load sharing, failover conditions
  

<img width="602" alt="image" src="https://user-images.githubusercontent.com/116812447/215494580-eeaed00c-52a0-479c-b8db-909f8cce27fc.png">

**ARP load sharing**

- Use only when firewall is default gateway for end hosts
- Everytime different firewall replies on ARP request with its own virtual MAC, IP is the same for both firewalls
- ARP load sharing on LAN side and floating IP on the other

## Cluster

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

## User-ID

Can be used in:

- Authentication policy
- Decryption policy
- DoS policy
- Policy-Based Forwarding Policy
- QoS policy
- Security policy
- Tunnel inspection policy

**User mapping methods**

- Server monitoring - User-ID agent, PAN-OS built-in, AD, Exchange, Novell eDirectory, Sun ONE Directory Server
- Port mapping - Microsoft Terminal Services - Citrix Environments - Palo Alto Networks Terminal Services agent - the source port of each client connection to map each user to a session. Linux terminal servers do not support the Terminal Services agent and must use the XML API to send user mapping information from login or logout events to User-ID
- Syslog- The Windows-based User-ID agent and the PAN-OS integrated User-ID agent both use Syslog Parse Profiles to interpret login and logout event messages that are sent to syslog servers from the devices that authenticate users. Such devices include wireless controllers, 802.1x devices, Apple Open Directory servers, proxy servers, and other network access control devices
- XFF headers - IP address of client in additional header
- Authentication policy and Captive Portal - any web traffic (HTTP or HTTPS) that matches an Authentication policy rule forces the user to authenticate via one of the following three Captive Portal authentication methods:
    - Browser challenge: Uses Kerberos or NT LAN Manager (NTLM)
    - Web form: Uses multi-factor authentication (MFA), security assertion markup language (SAML) single sign-on (SSO), Kerberos, terminal access controller access control system plus (TACACS+), remote authentication dial-in user service (RADIUS), LDAP, or local authentications
    - Client CA
- GlobalProtect
- XML API
- Client probing - in a Microsoft Windows environment - User-ID agent probes client systems by using Windows Management Instrumentation or NetBIOS. Client probing is not a recommended method for user mapping - WMI is recomended - probes are sent ebery 20 mins to verify that user is still loged in - client probes can be sent outside - large amount of network traffic

**Concepts**

- 100 domain controllers or 50 syslog servers - MAX - per agent or per PAN-OS
- Firewalls share user mappings and authentication timestamps as part of the same redistribution flow
- Before a firewall or Panorama can collect user mappings, you must configure its connections to the User-ID agents or redistribution points
- Four domain controllers within an LDAP server profile for redundancy
- If you have universal groups, create an LDAP server profile to connect to the root domain of the global catalog server on port 3268 or 3269 for SSL. Then, create another LDAP server profile to connect to the root domain controllers on port 389 or 636 for SSL. This helps ensure that both user and group information is available for all the domains and subdomains
- Maximum of 512k users in a domain
- Special User-ID log
- Source NAT destroys User-ID

**Agentless (PAN-OS)**

- If you have a small-to-medium deployment with few users and 10 or fewer domain controllers or exchange servers
- If you want to share the PAN-OS-sourced mappings from Microsoft Active Directory (AD), Captive Portal, or GlobalProtect with other PA devices (maximum 255 devices)
- Saves network bandwidth
- Uses WinRM or WMI
- Retrieve less data then User-ID agent
- Accept and parse Syslog

Configure

- Enable User-ID in a zone options

- Verify that the usernames are correctly displayed in the Source User column under Monitor > Logs > Traffic
- Verify that the users are mapped to the correct usernames in the User Provided by Source column under Monitor > Logs > User-ID.

**User-ID Agent (Windows)**

Use User-ID Agent (Windows)

- If you have a medium-to-large deployment with many users or more than 10 domain controllers
- If you have a multi-domain setup with a large number of servers to monitor
- Save processing cycles on the firewall’s management plane

Concepts

- The User-ID agent queries the Domain Controller and Exchange server logs using Microsoft Remote Procedure Calls (MSRPCs)
- User-ID agent is launched under the same User name as it connects to AD
- During the initial connection, the agent transfers the most recent 50,000 events from the log to map users
- On each subsequent connection, the agent transfers events with a timestamp later than the last communication with the domain controller
- Accepts and parses Syslog
- It is not recomended to install it on a domain controller
- Windows Log Forwarding - multiple domain controllers export their login events to a single domain member from which a User-ID agent collects the user mapping information

Configure User-ID Agent

- Configure according to Palo Alto documentation
- Enter username with domain and password
- Install User-ID agent on supported Windows version according to instructions, configure it and launch
- Enable User-ID in zone configuration
- Device > Data Redistribution - Configure Agent host and port - verify that its status is connected

**User-ID redistribution**

- If you configure an Authentication policy, you have to configure firewall to redistribute mappings + timestamps to other firewalls, time stamps are sent automatically, no additional configuration
- In **Device > Data Redistribution > Agents** you can configure other Firewall, Panorama or Windows agent as agent
- In **Device > Data Redistribution > Collector Settings** you can configure firewall as a redistribuion point for other firewalls and VSYSs
- Connection to agent is done via pre-shared key
- It is possible to redistribute not only User-IP mappings, but also:
    - IP tags
    - User tags
    - HIP
    - Quarantine list
- You can include/exclude networks for IP-Tag and IP-user in Device > Data Redistribution > Include/Exlcude networks, as I understand it is both for collector and client

Display the status of the User-ID service - Collector - Redistributor:

```
show user user-id-service status
```

Display the clients/firewalls that are connected to the collector

```
show user user-id-service client all
```

Show connections to agents - for new Pan versions

```
show redistribution agent state all
```

Log files for old and new verions

```
less mp-log useridd.log
less mp-log distributord.log
```

Netstat

```
netstat -na | findstr 5007
```

Search in System logs

```
show log system direction equal backward subtype equal userid
```

**Dynamic User Groups**

- Objects > Dynamic User Groups
- For every group you create match criteria
- Match criteria: AND OR statements + Tags
- You click More and add users, for example from AD, connected to firewall
- Earlier you could use only static user groups
- You must commit firewall configuration after creating a DUG and adding it to a policy rule
- You do not have to perform a commit when users are added to or removed from a DUG
- User membership in a DUG is dynamic and controlled through the tagging and untagging of usernames
- Usernames can also be tagged and untagged by using the auto-tagging feature in a Log Forwarding Profile
- PAN-OS XML API commands to tag or untag usernames
- Event in a log > log forwarding action assignes a tag to a user > User added to a DUG > User is blocked according to a policy
- Auto-remediation in response to user behavior and activity
- We can add tieme exiring tags, so in some time user left DUG
- To dynamically register a tag with a username, you can use Panorama, the XML API, a remote User-ID agent, or the web interface (Objects > Dynamic User Groups and click more)
- A firewall can forward the username and tag registration information to Panorama, and Panorama can distribute this information to the other firewalls
- Another example: user goes to URL from anonymous-proxy category, URL filtering logs it and user added to Anonymous group


**Map users to groups via LDAP**

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
- If OU is changed for group, rules will stop working, we need to readd the group
- To verify that all of the user attributes have been correctly captured, use the following CLI command:

```text
show user user-attributes user all
```

Show all received groups

```
show user group list
```

**Configure managed service account on Windows AD**

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

**Authentication portal**

MFA profile > Authentication profile > Authentication enforcement object > Authentication Policy + Captive Portal settings in paralell + Authentication sequence in parallel 

**Multi-Factor authentication**

- Device > Server Profiles > Muli Factor Authentication
- Create a profile
- Configure Certificate profile, choose vendor (DUO for example) and configure options for vendor
- The MFA factors that the firewall supports include push, Short Message Service (SMS), voice, and one-time password (OTP) authentication
- These profiles are connected as Factors to Authentication profile, several Factors can be addded

**Authentication profile**

Types:

- Cloud - ?
- Local Database
- Radius
- LDAP
- TACAS+
- SAML
- Kerberos - single sign on + keytab

**Device > Authentication Profile** > What to configure:

- Type
- MFA profiles, several can be added
- Allow list
- Failed attempts
- User domain

**Authentication sequence**

- **Device > Authentication Sequence**
- We can create several
- We add different authentication profiles to a sequence
- Order of profiles matter

**Authentication enforcement object**

- Objects > Authentication
- Is assigned to Authentication policy rules
- We configure here method, authentication profile, and text messgae for user
- Methods:
    - browser-challenge — The firewall transparently obtains user authentication credentials. If you select this action, the Authentication Profile you select must have Kerberos SSO enabled or else you must have configured NTLM in the Captive Portal settings . If Kerberos SSO authentication fails, the firewall falls back to NTLM authentication. If you did not configure NTLM, or NTLM authentication fails, the firewall falls back to web-form authentication
    - web-form — To authenticate users, the firewall uses the certificate profile you specified when configuring Captive Portal or the Authentication Profile you select in the authentication enforcement object. If you select an Authentication Profile , the firewall ignores any Kerberos SSO settings in the profile and presents a Captive Portal page for the user to enter authentication credentials
    - no-captive-portal — The firewall evaluates Security policy without authenticating users
- Authetication profile my be none, then one in Captive portal settings is used

**Captive Portal - Authentication Portal**

Device > User Identification > Authentication Portal Settings  

- Timers - Idle + How log to store User-IP mapping
- GlobalProtect Network Port for Inbound Authentication Prompts (UDP) - To facilitate MFA notifications for non-HTTP applications (such as Perforce) on Windows or macOS endpoints, a GlobalProtect app is required. When a session matches an Authentication policy rule, the firewall sends a UDP notification to the GlobalProtect app with an embedded URL link to the Authentication Portal page. The GlobalProtect app then displays this message as a pop up notification to the user
- SSL/TLS service profile - redirect requests over TLS
- Authentication profile - global setting, can be overrided by Authentication policy
- Mode
    - Transparent - impersonates the original destination URL, issuing an HTTP 401 to invoke authentication. However, because the firewall does not have the real certificate for the destination URL, the browser displays a certificate error to users attempting to access a secure site. Therefore, use this mode only when absolutely necessary, such as in Layer 2 or virtual wire deployments
    - Redirect - intranet hostname (a hostname with no period in its name) that resolves to the IP address of the Layer 3 interface on the firewall to which web requests are redirected. The firewall intercepts unknown HTTP or HTTPS sessions and redirects them to a Layer 3 interface on the firewall using an HTTP 302 redirect to perform authentication. This is the preferred mode because it provides a better end-user experience (no certificate errors). If you use Kerberos SSO or NTLM authentication, you must use Redirect mode because the browser will provide credentials only to trusted sites. Redirect mode is also required if you use Multi-Factor Authentication to authenticate Captive Portal users
- Certificate authentication profile - for authenticating users via certificate

**Selecting Users and Groups for Security Policy**

- Any
- Pre-logon - with Global-Protect
- Known-user - any identified by User-ID
- Unknown - user cannot be identified by User-ID
- Select - specific user or group

**Debug**

**Show logged in users**

```text
debug dataplane show user all
```

**Show log for agentless connection to Active Directory**

```
less mp-log useridd.log
```

Go to the end of the file by pressing Shift+G

**User-ID agents stats**

```
show user user-id-agent statistics  
```

**Show User-IP mappings**

```
show user ip-user-mapping all
```

**Server monitor situation**

```
show user server-monitor state all
```

**Show users and their LDAP groups**

```
show user user-ids all
```

**Show users in a group**

```
show user group name "cn=internet,cn=users,dc=skynet,dc=ru"
```

**Restart User-ID service**

```
debug software restart process user-id
```

## Panorama

**Features**

- Dashboard: configurable widgets, configurable device groups, configurable devices
- Centralized view on all activities via **ACC**:
    - Network
    - Threat
    - Blocked
    - Tunnel
    - Global Protect
    - SSL 
- Centrall logging via **Monitor**
    - All logs - send logs to Panorama is enabled in Log Forwarding profile and configurable on per rule basis
    - External Logs - TrapsTM ESM Server logs (security events on the endpoints)
    - Automated correlation engine
    - AppScope - all possible App Analytics
    - PDF reports
- Add, delete device/VSYS + ALL information about devices/VSYSs structured via Device Groups: **Panorama > Managed Devices > Summary** - Model, VSYS name, Template Stack, Sync status of policy and stack, serial number, mgmt IP, software + all bases versions, backup management, HA state
- Health: **Panorama > Managed Devices > Health**, Troubleshooting policies + Connectivity: **Panorama > Managed Devices > Troubleshooting**
- Policies + Objects management - all types of policies via **Device Groups: Panorama > Device Groups, Policies, Objects**
- All Network Configurations + Device configurations via **Network, Device, Panorama > Templates**
- Databases, licenses and software updates: **Panorama > Device Deployment**
- Import device config to new Template and Device Group: **Panorama > Setup > Operations > Import device configuration to Panorama**
- Super detailed Admin Profiles, what they can do: Web, CLI, API - **Panorama > Admin Roles** - 
- Access domains: devices, device groups, templates - what admins can access - **Panorama > Access Domain**
- Data redistribution: other can connect to Panorama, Panorama can connect to agents: **Panorama > Data Redistribution**, Agents/Clients/Include,Exclude networks
- Log collectors + Groups: **Panorama > Managed Collectors, Collector Groups**
- Many predefined reports + granular log storage control 
- Zero touch provisioning
- Plugins: AWS, Azure, ACI, TrustSec, DLP, SD-WAN, NSX, vCenter
- A CLI command will forward the pre-existing logs to Panorama from firewalls
- **Panorama > Device Quarantine** - list of all devices on quaratine, manual in Panorama via serial, manual via logs, automatic action based on logs
- Share Unused Address and Service Objects with Devices + Ancestor are stronger then descendants: **Panorama > Setup > Management > Panorama Settings**
- High Availability: passive one is passive and just synchronize with active: **Panorama > High Availability**, Same Model version and mode, Peer IP, Peer Serial, Priority
- Panorama Interconnect: manages up to 64 Panorama Nodes: Panorama Interconnect plugin. You must install the plugin on the Panorama Controller, and all Panorama Nodes
- Wildfire Clusters + Appliances: **Panorama > Managed Wildfire Clusters, Appliances**
- **Panorama > Scheduled Config Push** - Date/Time/One-time/Recurring/Device Groups/Templates
- **Panorama > Log Ingestion Profile** - receive logs from external sources, attach the log ingestion profile to a Log Collector group
- **Panorama > Policy Recomendation > IoT + SaaS** - ?

**Types**

- Management Only
- Log Collector
- Panorama: both

**Administrators**

3 types:

- Dynamic - When new features are added, Panorama automatically updates the definitions of dynamic roles; you never need to manually update them
- Custom Panorama admin - everything configurable
- Device Group and Template Admin - you need to specify access domain for these admins

Roles for dynamic type:

- Super user
- Super user read only
- Panorama administrator - cannot create admins, cannot export, save, load configs

Profiles for Custom Panorama admin type  

Access domains for Device Group and Template Admin administrator type

**Shared objects**

- In Device Groups: Shared Object is avalable for all Device Groups
- What if we change its name and it is used in a Policy?
- In Templates: Shared Object is avalable for all VSYSs in a Template

### Templates & stacks

 <img width="576" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/813aef71-ce9f-401e-80a9-81e34f4c42c3">

- To control configuration and updates
- Every template has different configurations for different VSYSs, we can choose
- All Device parts and Network parts
- Template is a copy of firewall's configuration interface
- Configuration is written to template
- Template is addded to stack - 8 max
- Template can be added to different stacks
- You can use template stack variables to replace IP addresses, group IDs, and interfaces
- NGFW is connected to max one stack
- A Panorama administrator can override the template settings at the stack level: add options to stack directly
- A local administrator can also perform overrides directly on an individual device if necessary - we chose an object and there is a button in the bottom: Override
- After you override locally, and new push from Panorama, this parameter will remain overrrided
- There is no possibility to see on Panorama on which Firewalls what was overrided
- Stack have a configurable priority order to ensure that Panorama pushes only one value for any duplicate setting. If there is the same object in 2 templates, object from the uppest template in the stack will be installed, for example interface management profile, no options for this profile from lower template will be installed
- Different firewall models - different stacks
- Object created in template, is available only in this template
- When we import firewall, template is automatically configured for it and template stack as well
- To change only parameter we can configure firewall directly and do not use force during pushing on panorama
- We can use variables, for example to configure different IP addresses in one template stack
- 1024 template stacks max
- When you commit and push you cannot choose template, you can choose Stack or device....

It is **impossible** to configure with templates:

- Configure a device block list
- Clear logs
- Enable operational modes such as normal mode, multi-vsys mode, or FIPS-CC mode
- Configure the IP addresses of firewalls in an HA pair
- Configure a master key and diagnostics
- Compare configuration files (Config Audit)

**Templates & stacks Configuration**

- Create Template: **Panorama > Templates > Add - Name + VSYS**
- Commit to Panorama
- Fill the template with options via Templates Sections: Network and Device
- Create a Stack: **Panorama > Templates > Add Stack** - Assign a template to it + assign devices + default VSYS
- The Template at the top of the Stack has the highest priority in the presence of overlapping config
- Commit to Panorama and devices

**Certificate management**

- Import cert for GUI manegement to Global Template
- Configure TLS profile for GUI management with this cert in Global Template
- Install all Stacks during the night
- In MGMT cert put to SAN field all firewall hostnames and IPs
- Everytime you add new firewall add new IP and hostname and regenerate cert and push it to firewalls and reconfigure TLS profile

**Backup/Restore**

- Panorama automatically saves a new version of the running configuration whenever you commit changes and you can restore any of those versions
- You can save named configuration snapshot manually choosing Templates and Device Groups
- When you revert changes, you are replacing settings in the current candidate configuration with settings from another configuration
- Reverting a Panorama management server configuration requires a full commit after revert and must be performed by a superuser
- Revert to a previous version of the running configuration that is stored on Panorama: **PanoramaSetupOperations, Load Panorama configuration version**
- You can select Templates and Device Groups
  

**Overrides**

- Any option on firewall received from stack can be changed locally
- We just need to choose required option and click Override and then change it how we want
- All options received from Panorama are marked with green icons in local FW interface
- All overriden options are marked with orange-green signs
- To cancel override we need to click on orange sign - it will become green and after this commit locally on firewall
- Another way to cancel override is to push Stack from Panorama with Option Force Template Values

**Variables**

- They are created in order not to create 200 templates with different IPs inside
- Used in: Static routes, interface IPs, Server profiles, DNS servers....
- You can use variables to replace:
    - An IP address (includes IP Netmask, IP Range, and FQDN) in all areas of the configuration.
    - Interfaces in an IKE Gateway configuration (Interface) and in an HA configuration (Group ID).
    - Configuration elements in your SD-WAN configuration (AS Number, QoS Profile, Egress Max, Link Tag).
- Panorama > Templates > Manage Variables > Create Variables
- Variables need to begin with '$': $DNS=1.1.1.1/32
- Use this variable in proper configurations
- You can import CSV with values for variables into Stack, depending on a device
- In CSV you configure variable name, which you already created + variable type (IP/netmask for example) + value for each firewall - Serial/Hostname
- 4096 variables MAX in template

### Device groups

- To control policies and objects
- To create a device group: Name, parent group, devices, User-ID master device - The device selected as the Master Device is used to gather user information.  The gathered user and group mapping information is used for shared policy configiration. It is required if you want to use users in a policy, Cloud Identity Engine
- Device groups: for controlling all policies + all objects
- By default Panorama pushes all shared objects to firewalls whether or not any shared or device group policy rules reference the objects
- On lower-end models, such as the PA-220, consider pushing only the relevant shared objects to the managed firewalls. This is because the number of objects that can be stored on the lower-end models is considerably lower than that of the mid- to high-end models
- **Panorama > Setup > Management > Panorama Settings > Share Unused Address and Service Objects with Devices** - enabled by default
- Objects management: when we create an object, for example address, it is not shared by default, so it is visible only in a device group and only for 1 vsys, if we make it shared, we can use it in all device groups. We should be cautious: as small devices do not support many objects, and we can overload them
- By default lower device groups take precedence over upper device groups, if the same objects exist
- Objects defined in ancestors will take higher precedence - when you perform a device group commit, the ancestor values replace any override values
- Tags can be applied to devices when add them to panorama
- Then these tags are used as targets in rule instead of sending to all devices in device group
- One NGFW only in one Device Group
- Every device Group contains its Policies and Objects
- Before editing Policies and Objects we we choose device group
- You can create a device group hierarchy to nest device groups in a hierarchy of up to four levels, with the lower-level groups inheriting the settings (policy rules and objects) of the higher-level groups
- Adds pre rules and post rules, which are read only on NGFW
- Devices must be added to device group
- PAN-OS doesn’t synchronize pushed rules across HA peers
- User-ID master in HA-group during adding to Device Group - This will be the only firewall in the device group from which Panorama gathers username and user group information
- Local rules are not touched, we just pre and post
- Rule is installed by default on all devices in device group, but we can choose exact firewalls or based on tags
- For every rule we can choose where to install: one particular firewall, device groups, tags...
- One giant device group consists of many subgroups
- Every device in panorama has its own tag or many tags
- The master device is the firewall from which Panorama gathers user ID information for use in policies
- Rules from upper Devices Groups automatically appears in lower Device Groups Policies
- You attach devices only to lower Device Groups, because Device can be attached only to one Device Group
- You cannot override or change rules arrived from Panorama
- If you create an address object on Panorama, you can disable override and make it shared: for other VSYSs and Device Groups
- If you create an address on Panorama and do not use it in rules, it will be installed to device anyway
- If the same object is in Parent group, you cannot create it in Child group, override is required
- All device groups are members of shared group
- 1024 device groups is maximum
- We can assign a reference template to a device group to see zones and interface when we create rules in policy
- When we create an object, we can make it Shared, it will be in Shared group and will be accessible for all device groups. We can also disable override for it, so lower hirerchy firewalls and groups will not be able to overrride it
- Objects in Shared group never can be overrriden
- Policy rules Hierarchy 
    - Shared Pre-policies
    - Device group hierarchy pre policies
    - Local firewall policies
    - Device group hierarchy post policies
    - Shared post-policies
    - Default rules
- When we import firewall config to Panorama, its rules go to Pre rules section of Device Group

**Gear Icon Color**

- Solid green gear icon indicates that Force Template Values option was used on Panorama during template push operation
- Orange overlay green gear icon indicates panorama pushed configuration was overwritten on the local firewall or the Force Template Values was not selected during panorama commit push operation
- Using Force Template Values on Panorama causes the Network and Object values on firewall to be overwritten by the Panorama pushed configuration. Please use caution while using this option
- It is possible to clear local override and push locally

**Licensing + Software Upgrades + Dynamic Updates**

- Panorama > Device Deployment 
- Automatically license a VM-Series firewall when it connects to Panorama
- Simplifies the license activation and deactivation of VM-Series firewalls in environments that use auto-scaling and automation to deploy and delete firewalls to address changes in the cloud
- Panorama > Device Deployment > Licenses > Activate
- Support licenses can be activated only locally on FW
- Panorama treats the managed firewalls in HA pairs as individual firewalls for software update purposes
- A pair of Panorama instances can be used to download software updates. One Panorama with a trusted internet connection can transfer updates to an SCP server while the second Panorama deployed in an isolated network can use the SCP server as a software update server. The second Panorama can then download any updates and then send them to all the managed devices
- Panorama > Device Deployment > Software
- Panorama > Device Deployment > Dynamic Updates

**Automatic commit recovery**

 - If the committed configuration breaks the connection with Panorama, then the firewall automatically fails the commit and the configuration reverts to the previous running configuration
 - The firewall also checks the connectivity to Panorama every hour to ensure consistent communication
 - In HA firewall configurations, each HA peer performs the connectivity tests independently
 - HA configuration syncs might occur only after each HA successfully tests the connectivity to Panorama and verifies its connection
 - Device > Setup > Panorama Settings > Enable Automatic commit recovery: Number of attempts to check for Panorama connectivity, Interval between retries (sec)

**General Configuration Overview**

- Add Panorama and Secondary Panorama IP on device
- Insert auth key from Panorama: **Panorama > Device Registration Auth Key**
- Push two buttons to enable policy and device configuration
- Commit
- Do the same for secondary device OR if it is already was in cluster, all setting will be commited from active device, except Auth key - it should be added manually
- Add both devices to **Panorama > Managed devices** using serials
- Group HA pair in panorama
- Panorama manages HA devices as separate, but we can group them for visual convenience, anyway, panorama will send settings to each firewall
- Panorama configurations are not synced between HA pair
- Create a device group
- Commit and push
- Go to Policies, select device group and edit edit policy and push it
- Device group is configurable for every rule
- Create templates - all configurations are there - **Panorama > Templates**
- Combine them into stack - **Panorama > Templates** - add devices to Stack
- You can add audit comment for every rule edit and then use audit comment archive to see all comment for all rule changes + you can make audit comment mandatory

**Configuration management**

- **Panorama > Setup > Operations >Configuration Management**
- Revert to last saved Panorama configuration - 

**Remove firewall from Panorama**

- Device > Setup > Management > Panorama Settings
- Disable Panorama Policy and Objects
- Disable Panorama Device and Network Template
- When you disable - everything what arrived from Panorama - will be deleted
- You may import everything from Panorama before disabling
- Delete Panorama IP
- Save all these actions is only possible using auth key from panorama

**Commit actions**

- Commit > Commit to Panorama — Activates the changes you made in the configuration of the Panorama management server. This action also commits device group, template, Collector Group, and WildFire cluster and appliance changes to the Panorama configuration without pushing the changes to firewalls, Log Collectors, or WildFire clusters and appliances. Committing just to the Panorama configuration enables you to save the changes that are not ready for activation on the firewalls, Log Collectors, or WildFire clusters and appliances
- Commit > Push to Devices — Pushes the Panorama running configuration to device groups, templates, Collector Groups, and WildFire clusters and appliances.
- Commit > Commit and Push — Commits all the configuration changes to the local Panorama configuration and then pushes the Panorama running configuration to device groups, templates, Collector Groups, and WildFire clusters and appliances
- You can filter pending changes by administrator or location and then commit, push, validate, or preview only those changes
- Panorama queues all the commit requests so that you can initiate a new commit while a previous commit is in progress
- Panorama performs the commits in the order in which they are initiated but prioritizes the auto-commits that are initiated by Panorama (such as FQDN refreshes)
- You can use the Task Manager to clear the commit queue or see details about commits
- Push to devices button = Commit on devices
- If templates and device groups are just saved on Panorama without Push, the Devices will be out of sync in **Panorama > Managed Devices > Summary**

Commit options when you commit to Panorama:

- Commit All Changes
- Commit Changes Made By
- Commit Scope
- Location Type
- Object Type
- Admins
- Include in Commit
- Group by Type
- Preview Changes
- Change Summary
- Validate Commit

**Locks**

- Config — Blocks other administrators from changing the candidate configuration
- Commit — Blocks other administrators from changing the running configuration
- Shared—Restricts changes to the entire Panorama configuration, including all device groups and templates.
- Template—Restricts changes to the firewalls included in the selected template. (You can’t take a lock for a template stack, only for individual templates within the stack.)
- Device group—Restricts changes to the selected device group but not its descendant device groups
  

**Pushing to firewalls**

- Push all changes OR only incremental - made by me or other admin - it is not connected with scope
- Configure Push Scope - Edit Selections
- Merge with device candidate config - ?
- Include Device and Network templates - ?
- Force template values - ?
- No Default Selections - ?
- Validate Device Group Push
- Validate Template Push

**Import firewall configs to Panorama**

- You cannot manage the setting through both Panorama and the firewall. If you want to exclude certain firewall settings from Panorama management, you can either:
    - Migrate the entire firewall configuration and then, on Panorama, delete the settings that you will manage locally on firewalls. You can override a template or template stack value that Panorama pushes to a firewall instead of deleting the setting on Panorama
- Load a partial firewall configuration, including only the settings that you will use Panorama to manage
- Firewalls do not lose logs during the transition to Panorama management
- Prepare according to official plan
- Panorama > Setup > Operations, click Import device configuration to Panorama, and select the Device
- Migrate HA pair: Disable configuration synchronization between the HA peers,

- **Migrate Firewall to Panorama**

- Add new device
- Import configuration
- Fine-tune the configuration
- Commit to Panorama
- Push the device state
- Commit the device groups and templates
- A CLI command will forward the pre-existing logs to Panorama

If you migrate HA pair:

- Disable automatic sync between peers
- Add both firewalls to Panorama

**Firewall is disconnected in Panorama**

On Firewall we need to launch a command

```
request sc3 reset
debug software restart process management-server
```

**Push config to Firewall without changes**

- Can be used during RMA
- COmmit > Push to Devices > Edit Selections
- Device Groups > Decelect All > Uncheck Filter Selected > Choose devices
- Templates > Deselect All > Uncheck Filter Selected > Choose devices
- Push 

**Log collectors**

- You can use Panorama as management server + send all logs to it, or you can send logs to log collectors (Panorama) and from them management Panorama will request all required data, you can also send logs to Cortex Data Lake
- Log collectors can be combined into groups - up to 16 in one
- Log collector mode is enabled via CLI and then device does not have Web interface  any more, it is controlled via Panorama management device
- Logs may store on firewall and Panorama may query them for reports

**Display the Number of Log Events per Second for Log collector sizing**

```
> debug log-receiver statistics
Logging statistics
------------------------------ -----------

Log incoming rate:             1/sec

Log written rate:              1/sec
```

**Show incoming logs on log collector**

```
Panorama> debug log-collector log-collection-stats show incoming-logs
Last time logs received Sun Feb  2 17:54:47 2020

Incoming log rate =   125.85

Detail counts by logtype:
traffic:1780676451
config:1126
system:98615
threat:28105597
```

Or WebUI: **Panorama > Managed Collectors**

**Log collector processes**

- logd— Process responsible for ingesting logs received from the managed firewall and for transferring ingested logs to the vldmgr
- vldmgr — Process responsible for managing the vld processes
- vlds — Process responsible for managing individual logging disks, writing logs to the logging disks, and ingesting logs into ElasticSearch
- es — ElasticSearch process running on the Log Collector

**Restart ellastic search process**

```
debug elasticsearch es-restart option all
```

**Show ellastic cluster status**

```
show log-collector-es-cluster health
```

- Unassigned shards - 1000 and bigger - logs are bad on panorama, slow or does not work at all
- Only full reset helps: switch to panorama mode and then back to log collector
- Ellastic search commands are not available without root

**Clear logs on log collector - the same command for firewall**

```
clear log log-type
```

**Health monitoring**

- Panorama > Managed devices > Health
- Throughput, sessions, connections, packets, interfaces, logging rate, memory, CPU (management plane, data plane), packet buffers, HA, Cluster

**Telemetry in Panorama**

Show cert issues and fix it

```
show device-telemetry stats all
Device Telemetry Statistics:
device-health-performance:
last-attempt: Mon Dec 4 18:58:03 EST 2023
last-success: Thu Nov 30 04:28:05 EST 2023
num-of-failed-attempts: 440
reason: Client Certificate issue
status: failed
product-usage:
last-attempt: Mon Dec 4 18:58:03 EST 2023
last-success: Thu Nov 30 04:28:04 EST 2023
num-of-failed-attempts: 440
reason: Client Certificate issue
status: failed
threat-prevention:
last-attempt: Mon Dec 4 18:58:03 EST 2023
last-success: Thu Nov 30 04:28:05 EST 2023
num-of-failed-attempts: 440
reason: Client Certificate issue
status: failed

request certificate fetch
```

## Hardware

**Top command: show CPU + memory**  
Used Mem= (used)-(Buffers +Cached)

```
show system resources
```

## CLI

Default username/pass - admin/admin  

**Show all system data**

```
show system info
```

**Show Top - management plane**



**Check status of all processes**

```
show system software status 
Slot 0, Role mp
----------------------------------------
 
Type     Name                 State    Info
Group    all                  running
Group    base                 running
Group    batch                running
Group    batch_secondary      running
Group    chassis              running
```

**Check if web server is running**

```
show system software status | match appweb
```

**Configure MGMT**

```
configure
set deviceconfig system ip-address <ip address> netmask <netmask> default-gateway <default gateway> dns-setting servers primary <DNS ip address>
set deviceconfig system type static
commit

show interface management
```

**Show routing table**

```
show routing route
show routing fib
```

**Test route**

```
admin@Palto-1(active)> test routing fib-lookup ip 98.139.183.24 virtual-router default
```

**Show sessions - with NAT data**

```
show session all filter application ping

--------------------------------------------------------------------------------
ID          Application    State   Type Flag  Src[Sport]/Zone/Proto (translated IP[Port])
Vsys                                          Dst[Dport]/Zone (translated IP[Port])
--------------------------------------------------------------------------------
20           ping           ACTIVE  FLOW  NS   192.168.1.20[1]/Inside/1  (10.2.62.150[1])
vsys1                                          1.1.1.1[26]/Outside  (1.1.1.1[26])
```

**Show detailed info about session: NAT, app, rule names, vsys, interfaces, bytes, type, state, user, QoS, end reason, logging...**

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

**Clear session**

```
clear session id 27240
```

**Show NAT policy**

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

**Ping**

```
ping source 10.2.62.150 host 10.2.62.1
```

**Reboot**

```
request restart system
```

**Debug silent packet drop**

```
debug dataplane packet-diag set filter match destination 192.168.1.100
debug dataplane packet-diag set filter on
show counter global filter packet-filter  yes delta yes severity drop
```

**Check connection to URL database**

```
show url-cloud status
```

**Show Wildfire submissions**

```
debug wildfire upload -log show
```

**Disable hardware offload** 

In order to capture traffic  
Supported on the following firewalls: PA-3200 Series, PA-5200 Series,and PA-7000 Series firewall

```
admin@PA-7050>set session offload no
```

**Switch to suspended state**

```
request high-availability state suspend
```

**Switch to functional state**

```
request high-availability state functional
```

**Sync config to remote peer**

```
request high-availability sync-to-remote running-config
```

**Show network connections**

For example with Panorama

```
admin@PA-1-1(active-primary)> show netstat all yes numeric-hosts yes numeric-ports yes | match 10.2.23.154
tcp        0      0 10.2.55.119:50914       10.2.23.154:3978        ESTABLISHED
tcp        0      0 10.2.55.119:34314       10.2.23.154:3978        TIME_WAIT  
```

**Show Panorama status**

```
admin@PA-1-1(active-primary)> show panorama-status 

Panorama Server 1 : 10.2.23.154
    Connected     : no
    HA state      : disconnected
```

**Reset to factory configuration**

```
request system private-data-reset
```

**Export tcpdump**

```
scp export mgmt-pcap from mgmt.pcap to < username@host:path>
```

## Logs

- By default, the logs that the firewall generates reside only in its local storage  
- Everything is in a Log Forwarding profile: **Objects > Log Forwarding**
- Logging Profile is attached to Security, Authentication, DoS Protection, and Tunnel Inspection policy rules  

**Logging profile**

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
- All other logs forwarding: Device > Log Settings - System, Configuration, User-ID....

**Logs in CLI**

Verify that firewall sends logs

```
show logging-status
```

Show preference list

```
show log-collector preference-list
Forward to all: No 
Log collector Preference List 
Serial Number: 003001000024 
IP Address: 10.2.133.48 
IPV6 Address: unknown
```
show log **traffic type** **log option** equal **value**

Examples:

```
show log system subtype equal device-telemetry direction equal backward | match Fail

show log system direction equal backward subtype equal ha eventid equal state-change
```

**Show logs for certain period of time**

```
show log system direction equal backward start-time equal 2023/12/04@12:30:00 end-time equal 2023/12/04@14:00:00
```

**Search for a certain word in System logs, for example failed Drive**

```
phiph@pa(active-secondary)> show log system | match Drive
2023/08/10 14:31:17 high     general        general 0  Log1 Drive error detected.
2023/08/10 14:31:17 critical ha             system- 0  HA Group 1: Drive error detected; going to state Non-Functional
2023/08/10 14:31:17 high     general        general 0  Log1 Drive error detected.
2023/12/12 00:31:37 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:31:37 critical ha             system- 0  HA Group 1: Drive error detected; going to state Non-Functional
2023/12/12 00:31:41 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:31:44 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:31:48 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:31:51 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:31:55 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:31:58 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:32:02 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:32:05 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:32:09 high     general        general 0  Log2 Drive error detected.
2023/12/12 00:32:13 high     general        general 0  Log2 Drive error detected.
phiph@pa(active-secondary)>
```

**Log files**

Every log section has many files.

- mp-log - management plane
- dp-log - data plane

```
less mp-log <value>
less plugins-log <value>
less mp-global <value>
less dp-log <value>
less mp-backtrace <value>
less dp-backtrace <value>
less webserver-log <value>
less appweb-log <value>
less custom-page <value>
less agent-log <value>
less db-log <value>

less mp-log ms.log
tail follow yes mp-log paninstaller_content.log
```

- shift+g will take you to the end of the file (regular 'g' will take you to start of file)
- /<keyword> to search , while in search use 'n' to go to the next or 'N' (shift+n) to go to the previous
- only use arrow keys to scroll up or down
  

**Log forwarding**

Is done to filter and forward logs to external storage and also assign tags.  
Can be done via profile for certain logs and via system settings 
Cortex Data Lake is also available   

Can be configured for the following logs in Log Forwarding Profiles - Objects > Log Forwarding:

- Authentication
- Data Filtering
- Decryption
- Traffic
- Threat
- Tunnel
- URL Filtering
- WildFire Submissions

You create a profile - and many rules in it - every rule for particular log type (traffic) - in filter you configure which logs will be sent, for example only allow  
All types (other than Panorama) support customization of the message format  
It is configured in Server Profile  
You can control which fields are sent + design + arbitrary text: A threat was detected from $src  

**Storage and quota**

- Device > Setup > Management
- Quota in percentage
- Max days
- Predefined reports
- Log collector status

### Log filtering**

**Logical operators**

- (proto neq udp) or ( addr.src notin 192.168.0.0/24 ) or !(addr in 1.1.1.1) или not (app eq ssl)
- AND: (port.src eq 23459) and (port.dst eq 22)
- OR: (port.src eq 23459) or (port.dst eq 22) 

**Addresses**

- (addr.src in 1.1.1.1)
- (addr.dst in 2.2.2.2)
- (addr in 1.1.1.1)

**Protocol**

- (proto eq udp)

**Ports**

- (port.src eq 22)
- (port.dst eq 25)

Apps: (app eq ssh)

**Users**

- Unindentified user: (user.src eq ’’)
- User in group: (user.src in 'group1')

Action: (action eq allow)  

**Date and time**

```
receive_time geq '2015/08/30 08:30:00') and (receive_time leq '2015/08/31 01:25:00')
```

**Pre defined reports**

- Device > Setup > Management > Logging and Reporting Settings - configuration
- These reports typically run once per day and summarize all the activity on the firewall
- Monitor > Reports
- Monitor > PDF Reports > SaaS Application Usage - applications that store data in external locations
- 

## Troubleshooting

Show system logs

```text
show log system
```



Show service routes

```
debug dataplane internal vif route 250

193.190.138.68 via 172.16.31.244 dev eth3.1  src 172.16.31.244
<>199.167.52.13 via 172.16.31.244 dev eth3.1  src 172.16.31.244
195.200.224.66 via 172.16.31.244 dev eth3.1  src 172.16.31.244
```

NAT troubleshooting:  
test nat-policy-match + traffic logs and session browser  

Security Policy troubleshooting:  
test security-policy match + traffic logs and the session browser

**Packet capture**

Packet capture types:

- Custom Packet Capture
- Threat Packet Capture
- Application Packet Capture 
- Management Interface Packet Capture
- GTP Event Packet Capture  
  

Security profiles which have packet capture:   
Antivirus  
Vulnerability protection  
AntiSpyware  

Custom packet cupture concepts:

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

## Site-to-Site tunnels

Palo Alto Supports 3 VPN deployments:

- Site-to-site VPN: IPSec or GRE or GRE inside IPSec(For multicast and broadcast)
- Remote-user-to-site VPN: SSL
- Large scale VPN (LSVPN) - This deployment uses the Palo Alto Networks GlobalProtect LSVPN. It provides a scalable mechanism to provide a hub-and-spoke VPN for up to 1,024 branch offices

All tunnels are configured in Network section  

**IPSec tunnels**

How traffic is routed:

- Option 1: You create a tunnel, no IPs, you create static routes specifing only interface, and it works
- Option 2: You create a tunnel, configure IPs on both ends, use dynamic routing or static routing, and it works
- Option 3: You create a tunnel, configure Proxy-IDs, and it works, without IPs, without routing - policy based VPN - only with third party devices, legacy - as I understand does not work on Palo Alto to Palo Alto - on Palo Alto you need to comfigure routes any way

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
- Default life time of Phase 2 tunnel is 3600 sec
- Life time can be in Kbytes as well
- Only one Phase 2 tunnel is used between 2 sites, because Proxy-IDs are 0.0.0.0/0, so separate tunnel is not created for every separate connection
- For every site you need IKE Gateway and tunnel.x interface
- Remote Peer IP in IKE Gateway can be dynamic, but in this case we need to configure ID for remote peer, for example domain name

**Policy-based VPN and Proxy-ID**

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

**Configuration**

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

**Redundancy**

- Two different ISPs - 2 different tunnels
- Tunnel.1 is configured for Primary VPN tunnel
- Tunnel.2 is configured for Secondary VPN tunnel 
- Both tunnel interfaces are configured under Security Zone "L3-VPN"
- Every site has 2 tunnels to HQ
- Via OSPF manual metric configuration we choose main tunnel
- If main tunnel fails, by default it takes 5 pings to switch to secondary tunnel!
- When we enable main tunnel back - no pings lost, we just switch back to main tunnel

There are three methods to do VPN tunnel traffic automatic failover. Any one of the below methods can be used. 

- Failover using Tunnel Monitoring
- Failover using Static Route Path monitoring
- Dynamic routing protocol

**Verify**

**Test gateway**

```
test vpn ike-sa gateway <gateway_name>
```

**Show IKE phase 1**

```
admin@PA-1-1(active-primary)> show vpn ike-sa gateway Peer2

IKEv1 phase-1 SAs
GwID/client IP  Peer-Address           Gateway Name                                                    Role Mode Algorithm             Established     Expiration      V  ST Xt Phase2
--------------  ------------           ------------                                                    ---- ---- ---------             -----------     ----------      -  -- -- ------
1               10.2.100.72            Peer2                                                           Resp Main PSK/ DH2/A128/SHA1    Aug.03 01:12:31 Aug.03 09:12:31 v1 13 1  3      

Show IKEv1 IKE SA: Total 2 gateways found. 1 ike sa found.


IKEv1 phase-2 SAs
Gateway Name                                                    TnID     Tunnel                 GwID/IP          Role Algorithm          SPI(in)  SPI(out) MsgID    ST Xt 
------------                                                    ----     ------                 -------          ---- ---------          -------  -------- -----    -- -- 
Peer2                                                           1        Branch-1               1                Init ESP/ DH2/tunl/SHA1 CE8B7B8B E4DB6687 88990189 9  1   

Show IKEv1 phase2 SA: Total 2 gateways found. 1 ike sa found.


There is no IKEv2 SA found.
```

**Test IKE Phase 2**

```
test vpn ipsec-sa tunnel <tunnel_name>
```

**Show IKE Phase 2**

```
admin@PA-1-1(active-primary)> show vpn ipsec-sa tunnel Branch-1

GwID/client IP  TnID   Peer-Address           Tunnel(Gateway)                                                                                                                  Algorithm          SPI(in)  SPI(out) life(Sec/KB)             remain-time(Sec)        
--------------  ----   ------------           ---------------                                                                                                                  ---------          -------  -------- ------------             ----------------        
1               1      10.2.100.72            Branch-1(Peer2)                                                                                                                  ESP/A128/SHA1      CE8B7B8B E4DB6687 3600/Unlimited           2076                     

Show IPSec SA: Total 1 tunnels found. 1 ipsec sa found.
```

**Show general info about all tunnels:total amount, IPs, interfaces**

```
show vpn flow
```

**Filter the logs in System section**

```
subtype eq vpn
```

**Follow logs**

```
> tail follow yes mp-log ikemgr.log
> tail follow yes mp-log cryptod.log
```

**Detailed Debug**

```
debug ike global on debug
> less mp-log ikemgr.log
```

**IKE negotiation capture. Messages 5 and 6 onwards in the main mode and all the packets in the quick mode have their data payload encrypted**

```
> debug ike pcap on
> view-pcap no-dns-lookup yes no-port-lookup yes debug-pcap ikemgr.pcap
> debug ike pcap off
```

**GRE tunnels**

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

Show counters for GRE tunnels:

```
show counter global filter value all | match flow_gre
```

Run "show log system" with the filter of tunnel name  

Check the GRE session

- Filter by using session filter protocol 47
- Find the session ID and filter for session ID

**LSVPN**

- The LSVPN does not require a GlobalProtect subscription
- Enable SSL Between GlobalProtect LSVPN Components
- Configure the Portal to Authenticate Satellites
- Configure GlobalProtect Gateways for LSVPN
- Configure the GlobalProtect Portal for LSVPN
- Prepare the Satellite to Join the LSVPN

**GlobalProtect Satellite** 

- Simplifies the deployment of traditional hub and spoke VPNs, enabling you to quickly deploy enterprise networks with several branch offices with a minimum amount of configuration required on the remote satellite devices. This solution uses certificates for device authentication and IPSec to secure data
- The setup includes configuring the portal, gateway, and satellite
- Generate a Root CA Certificate on the Portal (Self signed) and a Server Certificate used for Portal and Gateway certificate signed by the above Root CA
- Export the Root CA (CACert) in PEM format, without the private key, and import it to the satellite device (Device > Certificate Management > Certificates > Import). This certificate on the Satellite is used to validate the Portal/ Gateway Certifcate against the CACert
- Configure a portal (Network -> GlobalProtect -> Portals -> Add) and add the interface that will act as Portal/Gateway
- Add satelite in Portal configuration in special Satelite Section: Name + Serial or User/pass + Gateways
- Configure Gateway + configure Satellite there as well
- Configure Satelite itself: Create a new IPSec tunnel config and select the type as GlobalProtect Satellite. Add the tunnel interface, portal config, and the interface that can reach the portal address

## VSYS

- If several VSYSes are connected via extermal equipment then there is an issue - to many sessions!

**Inter-vsys routing**

- Special external Zone is created on every VSYS
- Interface is added to it
- Routes are added, next hop is VR - and you choose wich one
- Rules are created to allow communication between VSYS

**CLI**

```
admin@PA> show system info | match vsys 
multi-vsys: on

admin@PA> set system setting target-vsys ? 
none     none 
vsys1    vsys1 
vsys2    vsys2 
<value>  <value>

> set system setting target-vsys vsys2 
Session target vsys changed to vsys2 
admin@PA-vsys2>

admin@PA> show session meter

admin@PA-vsys2> show user ip-user-mapping all

admin@PA-vsys2> set system setting target-vsys none 
admin@PA> 
```

## Certificates

**SCEP**

- SCEP operation is dynamic in that the enterprise PKI generates a user-specific certificate when the SCEP client requests it and sends the certificate to the SCEP client
- The SCEP client then transparently deploys the certificate to the client device
- You can use a SCEP profile with GlobalProtect to assign user-specific client certificates to each GlobalProtect user
- GlobalProtect portal acts as a SCEP client to the SCEP server in your enterprise PKI

**SSL/TLS service profile**

- Used by Captive portal, GlobalProtect portals and gateways, inbound traffic on the management (MGT) interface, the URL Admin Override feature, and the User-ID™ syslog listening service
- Device > Certificate Management > SSL/TLS Service Profile
- Certificate
- TLS versions

**Certificate profile**

- User and device authentication for Captive Portal, multi-factor authentication (MFA), GlobalProtect, site-to-site IPSec VPN, external dynamic list (EDL) validation, Dynamic DNS (DDNS), User-ID agent and TS agent access, and web interface access to Palo Alto Networks firewalls or Panorama
- Specify which certificates to use, how to verify certificate revocation status, and how that status constrains access
- Username field
- User domain
- CA certs
- CRL - use or not
- OCSP - takes precedence over CRL - use or not
- Block session if cert is unknown, if cert is expired

**Firewall Features Using Certificates**

- TLS decryption
- MGTM interface auth
- GlobalProtect
    - Portal Auth
    - Gateway Auth
    - Mobile Security Manager Auth
- Captive Portal Auth
- IPSec IKE Auth
- HA Auth
- Secure Syslog Auth
- AIOPS

**Device Certificate**

Install

```
request certificate fetch
```

Verify

```
show device-certificate status
```

## Management Profiles

- Network > Network Profiles > Interface Mgmt
- Ping, Telnet, SSH, HTTP, HTTP OCSP, HTTPS, or SNMP
- Response Pages (for Authentication Portal or URL Admin Override)
- User-ID (to redistribute data and authentication timestamps)
- User-ID Syslog Listener-SSL or User-ID Syslog Listener-UDP (to configure User-ID to monitor syslog senders for user mapping over SSL or User Datagram Protocol [UDP]traffic)

## Zero touch provisioning

- Panorama > Plugins to Download
- Install the most recent version of the ZTP plugin
- Panorama > Zero Touch Provisioning

## Administrators, types, roles

 - **Device > Administrators**
 - **Device > Admin Roles**

 When you create an Admin for PA you need specify the following:

 - Name
 - Authentication profile: LDAP, Tacacs, Radius...
 - Password, if there is no Authentication profile
 - Use only client certificate authentication (Web)
 - Use Public Key Authentication (SSH)
 - Type:
    - **Dynamic**
    - **Role based**
- Type of Dynamic, if Dynamic is chosen
- Admin Role Profile, if Role based is chosen
- Password profile, if there is no Authentication profile

Dynamic types, After new features are added, the firewall and Panorama automatically update the definitions of dynamic types:

- Super user - can manage firewall admin accounts and create VSYS
- Super user read-only
- Device administrator - full access to all firewall settings except for defining new accounts or virtual systems
- Device administrator read-only

Admin Role Profiles, After new features are added to the product, you must update the roles with corresponding access privileges.  
The firewall has three predefined roles you can use for common criteria purposes:

- auditadmin
- cryptoadmin
- securityadmin

Create **custom** roles to limit administrator access to only what each type of administrator needs. For each type of administrator, enable, disable, or set read-only access for Web UI, XML API, Command Line, and REST API access.  

For Command Line only 4 options exist in Role Configuration:

- superuser
- superreader
- deviceadmin - Has full access to all firewall settings except for defining new accounts or virtual systems
- devicereader

Supported authentication types include the following:

- MFA
- SAML
- SSO
- Kerberos 
- TACACS+ 
- RADIUS
- LDAP
- Local

Roles are available in RADIUS Vendor-Specific Attributes (VSAs), TACACS+ VSAs, or SAML attributes.

## Global Protect

GlobalProtect has three major components:

- GlobalProtect portal
- GlobalProtect gateways
- GlobalProtect client software

**Concepts**

- GlobalProtect is an SSL VPN client that also supports IPSec
- You can have one portal per GlobalProtect deployment and as many gateways as
needed
- By default, you can deploy the GlobalProtect portals and gateways (without HIP checks) without a license
- If you want to use the advanced GlobalProtect features (HIP checks and related content updates, the GlobalProtect mobile app, IPv6 connections, or a GlobalProtect clientless VPN), you will need a GlobalProtect license (subscription) for each gateway
- Clients: Windows, MacOS, Linux, iOS, and Android
- Authentication methods
    - Local authentication
    - External authentication
    - Client certificate authentication
    - Two-factor authentication
    - MFA for non-browser-based applications
    - SSO
- If a client configuration contains more than one gateway, the app attempts to connect to all the gateways listed in its client configuration
- You can configure split tunnel traffic based on the access route, destination domain, application, and HTTP/HTTPS video streaming application
- Split tunnel: Tunnel enterprise SaaS and public cloud applications for comprehensive SaaS application visibility and control, VoIP outside the tunnel, video streaming outside the tunnel
- The split tunnel rules are applied for the Windows and macOS endpoints in the following order:
    - Exclude based on the application process name
    - Include based on the application process name
    - Domains are excluded
    - Domains are included
    - Excluded or included based on the access route
- All interaction between the GlobalProtect components occurs over an SSL/TLS connection

### Workflow

- Client connects with browser to Portal and authenticates there
- Downloads Agent for his OS
- Install Agent and connects to Portal
- If prelogon is used(GP gets cert instead of user/pass): client connects to Portal before user logs in to OS, GP uses certificate to authenticate, next portal sends configuration for prelogin users, connect method in this config is pre-logon
- GP chooses gateway and connects to it
- After user logs in into OS, GP client requests from user login and pass and connects to portal again
- Portal sends him all configs + list of gateways, again, but package is different now, not for prelogin, different configs for different users, based on user groups - if it is used in conjuction with pre-logon, here connection method should be prelogon as well
- Can we leave only prelogon for user and do not ask for password from him?
- Why GP asks for username if it is connected already?
- According to this config agent keeps username for portal and uses it for gateway - Save Users Credential Option
- Client chooses gateway and  connects to gateway with received configs
- Gateway configures agent in terms of networking
- Split tunnel, IP pool and DNS are defined in Gateway
- All settings, sent by Portal and Gateway are defined based on matching criteria, mostly Username and OS and Region
- User have to trust portal and gateway certs
- Protocol used: IPSec - if IPSec is selected in Agent config in Gateway
- Routes are added to client without gateway, just using interface
- Interface mask is 255.255.255.255
- If IPSec is used, All encrypted Data is sent via UDP port 4501: IPSec + NAT-T
- If IPSec is not used, Everything goes via 443 and TLS
- GlobalProtect is slower on SSL VPN because SSL requires more overhead than IPSec. Also, Transmission Control Protocol (TCP) is more prone to latency than User Datagram Protocol (UDP), which is used in IPsec GlobalProtect
- In route table pool for clients appeares as static route via tunnel interface configured in gateway
- Than we can redistribute this static route to OSPF for example, so all LAN hosts may access Globalprotect clients

### Portal

**Network > Global Protect > Portals**

Structure (6):

- **General**: VSYS, Interface, IP, LOgin Page, Landing Page
- **Authentication**: how to authenticate to portal, many rules based on OS, first match
    - Cert profile - For checking user certs - For Portal in general
    - TLS profile - for connecting to portal - ForPortal in General
    - For every rule:
        - Auth profile OR Auth sequence
        - (User cert + pass) OR (User cert OR pass)
- **Portal Data collection** - Registry Keys from Windows, plist for MAC, Certificate Profile that specifies the machines certificates that you want to collect
- **Agent**: many rules based on OS and User/Group/Prelogon
    - Authentication
    - Config Selection Criteria
    - Internal
    - External
    - App
    - HIP Data Collection
- **Clientless VPN**
- **Satellite**

**Authentication in Agent section**

- Client certificate - install certificate with key to client - why?
- Save user credentials - if No - User will have to enter login/pass manually every time 

**App configuration subsection in Agent section**

- "Max Times User Can Disable" is configured on Portal - how many tims User can disable Global Protect - in App section

**Agent configuration for portal**

- Trusted root CAs - add to client
- Agent User Override Key - change or disable client
- Many Agent config rules
- Define which components require 2 factor auth: portal, internal gateways, external gateways...
- Config selection criteria: OS,User, Group, Serail Number, Machine certificate, registry keys, plists - Any by default
- Internal gateways - if required - When the user attempts to log in, the app does a reverse DNS lookup of an internal host using the specified IP Address
to the specified Hostname - if result is positive, internal gateway is used. Internal gateways are useful in sensitive environments where authenticated access to critical resources is required
- External gateways: IP, FQDN, Source region(any maybe), Priority
- App configuration: very many options!
- HIP data collection

### Gateway

- The interface and zone requirements for the gateway depend on whether the gateway you are configuring is external or internal, as follows:
    - External gateways—Requires a Layer 3 or loopback interface and a logical tunnel interface for the app to establish a connection. The Layer 3/loopback interface must be in an external zone, such as a DMZ. A tunnel interface can be in the same zone as the interface connecting to your internal resources (for example, trust). For added security and better visibility, you can create a separate zone, such as corp-vpn. If you create a separate zone for your tunnel interface, you must create security policies that enable traffic to flow between the VPN zone and the trust zone
    - Internal gateways—Requires a Layer 3 or loopback interface in your trust zone. You can also create a tunnel interface for access to your internal gateways, but this is not required
- Each firewall can have multiple gateways, but they can't share an IP address
- **Network > GlobalProtect > Gateways**
- Create and configure:
    - Interface
    - IP
    - TLS service profile
    - Client auth rule - Specify OS, Auth profile - the same as for captive portal, Allow list
    - Exclude video traffic from Tunnel
    - Tunnel interface
    - IPsec crypto
    - Split tunnel
    - IP-Pool
    - DNS servers
    - IPSec or SSL
    - Satelite

<img width="977" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/f3ec9794-9a39-4d33-8ebf-d4e12411c3e6">

### Logs

- GlobalProtect authentication event logs in Monitor > Logs > System
- Separate GlobalProtect log- 

### Authentication

- By default, the GlobalProtect app attempts to use the same login credentials for the gateway that it used for portal login. In the simplest case, where the gateway and the portal use the same authentication profile or certificate profile, the app connects to the gateway transparently
- We can configure authentication cookie for both portal and gateway, each with its own timeout, for example 1 day for gateway and 5 days for portal

**MFA**

 - It is possible to request MFA for a certain application access, not only for VPN connection or User-ID
 - For example User > External Palo Alto Global Protect Gate way > LAN > Internal MFA Gateway > Application Server
 - Internal MFA Gateway may request second factor for particular application
 - Authentication policy is used, which generates captive portal for browser based apps
 - And sends notifications to global protect client for non browser apps
 - To facilitate MFA notifications for non-HTTP applications (such as Perforce) on Windows or macOS endpoints, a GlobalProtect app is required. When a session matches an Authentication policy rule, the firewall sends a UDP notification to the GlobalProtect app with an embedded URL link to the Authentication Portal page. The GlobalProtect app then displays this message as a pop up notification to the user

**Xauth**

- Xauth (Extended Authentication within IKE) is what Palo Alto Networks use to support third party VPN software using the Globalprotect Gateway
- It allows the third party VPN client to authenticate through the Globalprotect auth profile as part of the IKE negotiation
- IKE V.1 must be used on the 3rd party clients: iOS, Android
- The Palo Alto Network firewall uses the OpenSSL crypto library
- Globalprotect IPsec crypto profiles aren't used for the X-auth clients
- Troubleshooting of the tunnel is done much the same way as any IPSec tunnel would be troubleshot

**Authentication Methods**

- Local Authentication
- External Authentication
- Client Certificate Authentication
- Two-Factor Authentication
- Multi-Factor Authentication for Non-Browser-Based Applications
- Single Sign-On

**Configuration: High level**

- Configure certs for portal and gateway
- Configure SSL service profile for portal and gateway
- Then LDAP server profile, sAMAccountName
- Authentication profile
- Next is portal: **Network > GlobalProtect > Portals**
- Download GlobalProtect client: **Device > GlobalProtect client**
- Next tunnel interface: **Network > Interfaces > Tunnel**, separate zone for VPN
- IP pool
- Access route
- Next, gateway
- Next connect

**GlobalProtect Connect Methods**

- On-demand: Requires manually connecting when access to the VPN is required
- User-logon: VPN is established as soon as the user logs into the machine. When SSO is enabled, user credentials are automatically pulled from the Windows logon information and used to authenticate the GlobalProtect client user
- Pre-logon: VPN is established before the user logs into the machine. Machine certificate is required for this type of connection
    - To authenticate the endpoint (not the user) and enable domain scripts or other tasks to run as soon as the endpoint powers on
    - To allow endpoints to access resources, you must create security policies that match the pre-logon user
    - These policies should allow access to only the basic services for starting up the system, for example DHCP, DNS, specific Active Directory services, antivirus, or operating system update services
    - After the user authenticates to the gateway, the GlobalProtect app reassigns the VPN tunnel to that user (the IP address mapping on the firewall changes from the pre-logon endpoint to the authenticated user)
    - Windows endpoints behave differently from macOS endpoints with pre-logon. With macOS endpoints, the pre-logon tunnel is torn down, and then a new tunnel is created when the user logs in
    - 

Where is it configured? 

**Client**

- Complete uninstall client on MAC with reseting passcode counter

```
sudo /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
```

## HIP

- HIP checks are performed when the app connects to the gateway
- Subsequent checks are performed hourly
- Only the latest HIP report is retained on the gateway per endpoint

## Web proxy

- Web proxy requires both a valid DNS Security license and the Prisma Access explicit proxy license
- The web proxy supports two methods for routing traffic: Explicit Proxy, Transparent Proxy
- The following platforms support web proxy: PA-1400, PA-3400, VM Series (with vCPUs), Panorama using PAN-OS 11.0
- For the transparent proxy method, the request contains the destination IP address of the web server and the client browser is redirected to the proxy
- Transparent proxy requires a loopback interface, User-ID configuration in the proxy zone, and specific Destination NAT (DNAT) rules. Transparent proxy does not support X-Authenticated-User (XAU)
- For the explicit proxy method, the request contains the destination IP address of the configured proxy and the client browser sends requests to the proxy directly

## SSL mirror

- Free license
- Connect the traffic collection tool directly to an Ethernet interface on the firewall and set the **Interface Type to Decrypt Mirror**
- Decryption port mirroring is not available on the VM-Series for public cloud platforms
- **Device > Setup> Content - ID** > Allow forwarding of decrypted content
- **Objects > Decryption Profile**
- Specify whether to mirror decrypted traffic before or after policy enforcement
- **Policies > Decryption** > Specify decryption Decryption Profile in Rule

## Autofocus

- It is a web portal
- AutoFocus lets you know if adversaries and campaigns discovered by Unit 42 have targeted your network, or networks like yours
- It is Enabled in Setup > Management Section: https://autofocus.paloaltonetworks.com:10443
- It should be licensed

## IoT Security

- Automatically discovers and identifies all network-connected devices and constructs a data-rich, dynamically updating inventory
- When it detects a device vulnerability or anomalous behavior posing a threat, IoT Security notifies administrators
- Works with Palo Alto Networks next-generation firewalls, logging service, and update server, and optionally with Panorama and integrated third-party products

## Security Policy to Excel

- Export your current running configuration:  In the web-interface you go to Device -> Setup -> Operations -> Export named configuration snapshot
- Open the configuration snapshot with a compatible text-editor (as Notepad++ for example)
- Search for string <security> (press Strg+H in most ext-editors) and deleted everything before the tag
- Search for string </security> (press Strg+H in most ext-editors) and deleted everything after the tag You now should have everything between <security> and </security>. Save the file (for security ;))
- Delete all tags <member> and </member>: Press Strg+H again for search and replace. Search for string <member> and replace it with nothing (delete it!). Do the same for the string </member>
- Save the file as an XML document
- Open Excel and import the XML file by clicking: Data -> Import –> other Sources –> XML-Dataimport and choose the XML file
- As a result you should see your complete ruleset, where every rule is in exactly one row. However, there were slight layout problems caused by blanks in front of the address objects
- You can easily fix that by using the replace-function again, and replace the blanks with nothing
- As a side-note:  You can use that procedure also for importing the address-objects of your PAN-Firewall. In that case you have to import everything between <address> and </address> tags
- Side-Note 2: For additional XML settings you may want to activate the developers tab in Excel. It offers you additional features when working with XML data

 ## Traffic flow analysis

  - Use global find to find objects based on IP addresses
  - Use global find to find policies based on objects
  - Based on policies find the VSYS
  - Based on VSYS analyze routing table
  - Traceroute from VSYS
  - Traceroute from personal laptop
  - Based on traceroute SSH to hops and find out the details
  - Search for trace route IPs in IPAM: find out host details + which network they are in
  - Search for end IPs in Palo Alto logs - and find which firewalls it hits

## Chassis

- Network Processing Cards (NPCs) provide network connectivity for a PA-7000 Series
- Six NPCs in a PA-7050 firewall and up to ten NPCs in a PA-7080 firewall
- You must install at least one NPC to enable the firewall to process network traffic

Verify slots

```
> show chassis power
> show chassis inventory
> show chassis status slot <slot number>
> show chassis status
```

## Prisma Access

**Concepts**

- **Service connection** to on-prem network and data center - IPSec tunnel - any device, PA is not mandatory - BGP or static routing - **for Data Center**
    - Service connections and remote networks are different: service connections are only inbound - you cannot route traffic from service connection to Prisma and to Internet
    - Max 5 service connections - 5 Gbps
- **Corporate access nodes (CANs)** - things in a cloud, which establish service connection,  no security policy here - CANs are used only to route traffic and User-ID redistribution and have a throughput of up to 1GBPS per service connection
- 100 locations are available for users to connect - **cannot go to Internet directly**
- **Remote Networks** connect to offices that require connections to and from the internet - **for Branches**
- **Remote Networks Security Processing Nodes (RN-SPN)** - thing in a cloud, which termintaes IPSec tunnel from branch  -  inspect and secure traffic from remote sites - **can go directly to internet**
- **Prisma Access portal**
      - Can be used with on-prem gateways
      - Multiple virtual portals (up to four) may be created around the world while they are still managed as one logical portal
- **The MU-SPN (formerly the gateway)** - terminates user VPN - **can go directly to Internet**
- **Service Infrastructure Subnet** - In most cases a /23 subnet is sufficient - it cannot overlap any existing IP subnets within your network
- **Cloud Secure Web Gateway (SWG)** - explicit proxy connection method, auto-scale, load-balanced across the scope of SWG nodes - **Can go directly to internet**
- Hybrid mode is available together with appliances where Prisma location is not available
- Portal identifies which location is better for user - user establishes IPSec tunnel
- All logs are sent to Cortex data lake, which can forward it to your Syslog
- Management: Cloud Services Plugin in Panorama or Cloud Managed Prisma Access
- All configuration: **Panorama > Cloud Services**

  ![image](https://github.com/phph9/Foundation/assets/116812447/2f28b800-1cf6-433a-b850-bbad3e3f5a16)


**Configuration**

- **Cloud Services > Configuration > Service Setup > Settings**:
    - First we configure service infrastructure subnet - not routable - not used in other places = /23 is recommened
    - Infrastructure BGP Private AS Number
    - Template Stack
    - Device Group
- **Cloud Services > Configuration > Service Connection**  - Connections to Data Centers
    - Closest location
    - IPSec tunnel: we create it in earlier configured Prisma Template, in this template there are also many preconfigured tunnels for different vendors, IKE Gateways you configure there as well
    - Corporate networks behind this tunnel
    - High bandwidth service connections are available - up to 5 Gbps - via aggreagtion - async routing is used
- Traffic Steering
- Remote Networks - Branches - **Cloud Services > Configuration > Remote Networks**
    - Location
    - IPSec tunnel
    - Static Routes or BGP
- Push and commit to the cloud

## RMA

The most difficult is to restore config, sync with HA node, restore connection with Panorama and successfully Push from Panorama.

- All interfaces are disconnected except Mgmt
- Version of RMA device should be the same
- Do a Factory reset of new RMA device
- Backup failed device if available
- Check jumbo frames
- Check session distribution policy for 7000
- Configure Mgmt interface on new FW
- Transfer licenses of Palo Alto Portal
- Install license on new device
- Install OS on new device the same as on old one
- Install dynamic updates the same as on old
- Replace Serial in Panorama
- Restore configuration and Commit
- Ensure the new device stays in a passive state, suspend it
- Check that Panorama is connected
- Push Template and Device Group
- Go to Device > High Availability > General > Setup and uncheck the Enable Config Sync option
- Disable "Preemptive" under Election Settings
- Configure the device with the highest Device Priority value (255)
- Perform a commit
- Connect HA1 Interfaces
- Make sure the replacement device has the same configuration as the active device
- If the configurations are not the same, go to Device > High Availability and click "Push configuration to peer" from the active device
- Verify there are no active commit jobs running and the devices are in sync
  
```
show jobs all
show high-availability all | match "Running Configuration"
```

- Verify there is no difference in idmgr between the devices

```
debug device-server dump idmgr high-availability state
```

- Log into the Active unit. Go to Device > Config Audit > Do config audit between "Running Config" and "Peers Running Config." Make sure both are the same. If the case of any differences, try to manually configure the passive unit
- Connect the HA2 interface and wait for the session synchronization to be completed
- If the Firewall is suspended make it functional now
- Connect the other dataplane interfaces now
- Test Failover

## Assymetric routing

- Abnormal and asymmetric packets are dropped by default and are not logged in traffic or threat logs
- Show counters
```
admin@PA-1-1(active-primary)> show counter global
```

Signs of assymetric routing, counters to increment:

- tcp_drop_out_of_wnd   out-of-window packets dropped
- tcp_out_of_sync       can't continue tcp reassembly because it is out of sync
- flow_tcp_non_syn      Non-SYN TCP packets without session match
- flow_tcp_non_syn_drop Packets dropped: non-SYN TCP without session match

flow_tcp_non_syn_drop - Packets dropped: non-SYN TCP without session match 
The Palo Alto Networks Next-Generation Firewall builds TCP sessions based on the three-way handshake. By default, the device drops TCP packets unless a TCP three-way handshake is first established. Good non-SYN TCP communication can occur on networks with asymmetric routing, where the device may see only some of the packets. Good non-SYN TCP communication can also occur when a device is first put on a live network.

tcp_drop_out_of_wnd - out-of-window packets dropped 
The Palo Alto Networks Firewall creates a sliding sequence window starting with the original ACK (the window size is based on the type of traffic within the session). It is expected that the packet sequence numbers within the current session reside within this sliding window. This window adjusts with the type of traffic and whenever new ACK messages are received. The default behavior on the device is to drop packets when sequence numbers are outside this window.

tcp_exceed_flow_oo_seg_limit - Out-of-window packets dropped due to the limitation on tcp out-of-order queue size 
The Palo Alto Networks Firewall tries to handle out-of-window conditions if the packets are out of order, collecting up to 32 out-of-order packets per session. This counter identifies that packets have exceeded the 32-packet limit. If the device reaches the 32-packet limit before identifying the correct sequence, the device will bypass L4-L7 scanning for the session, by default.

tcp_out_of_sync - Can't continue tcp reassembly because it is out of sync 
This counter increments when the firewall detects an ACK sequence number outside the sliding sequence window. The sliding sequence window is calculated based on the original ACK and the type of traffic within the session. By default, the device rejects these out-of-sync packets. To disable this feature, change the setting to ignore. Bypass can be used, but effectively bypasses the scanning of the session, once the session is identified as out-of-sync.

View current Global settings

```
admin@PA-1-1(active-primary)> show session info
```

Disable TCP sanity checks

```
> configure 
Entering configuration mode
[edit]         
# set deviceconfig setting tcp asymmetric-path bypass
# set deviceconfig setting session tcp-reject-non-syn no
# commit
```

We may also configure these options only for one zone in Zone Protection Profile > Packet based attacks > TCP Drop.
Zone Protection Profiles are applied to sessions that ingress on the zone where the protection profile is enabled

Session setup requires one cluster member to see the complete TCP three-way handshake.
For example it can be required on a member of cluster when assymetric routing is used. Request goes via one PA and reply via another, without these options long sessions with downloading a file will not work.
More specifically for this case only asymmetric-path bypass is required
Main reason why traffic will not work without it:
tcp_drop_out_of_wnd - out-of-window packets dropped 

After either the systemwide settings are disabled, or the Zone Protection Profile is added to a zone, the only counter that should still increment is
flow_tcp_non_syn
