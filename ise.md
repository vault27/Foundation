# NAC

## 802.1X

- 2001 is the year the standard was formally created and released
- Cisco was the first major vendor to ship 802.1X support in switches around 2001–2002, along with early RADIUS integrations with Cisco ACS
- 802.1X is an IEEE standard for network access control
- It defines how devices authenticate before they are allowed to send normal traffic on: wired Ethernet, Wi-Fi (WPA2/WPA3-Enterprise), MACsec-enabled networks
- 802.1X is a framework that controls who can connect to the network by requiring authentication at the moment a device plugs in or associates to Wi-Fi
- Login before network access
- Supplicant - PC
- Authenticator - switch, AP - NAS
- Authentication server - ISE
- This standard defines using of Radius, EAP, EAPOL...
- 802.1X itself does not define authentication — it only transports EAP methods
- Wired: `Supplicant > EAPOL over L2 link > Authenticator(Switch) > EAP inside Radius over L3 link > Authentication Server`
- Wireless: `Supplicant > EAP over WLAN(EAP over IEEE 802.11) > Authenticator(Access point) > EAP inside Radius over L3 link > Authentication Server`



### MAB

- Authenticate based on MAC
- Printer sends any packet
- Switch sends 3 EAP Request Identity and waits for reply
- If no reply, switch sends printer's MAC to Authentication server in Radius Access-Request
- Authentication server sends Access-Accept
- No periodic reauthentication
- Radius service type 6 - it distinguishes MAB from other packets
- We can specify order and priority for MAB, dot1x and web...

```
Service-Type = Call-Check (6)
User-Name = "aabbccddeeff"
Calling-Station-Id = "aa-bb-cc-dd-ee-ff"
NAS-Port-Type = Ethernet
```

### Authorization

- Dynamic VLAN
- Downloadable access control list
- Security group tags SGTs
- Airspace ACL names
- URL redirections
- Time based access
- Trust sec capabilities

## ISE

### Components

- Device
- Device groups: locations, types
- Device profiles
- Device admin policy sets
- Shell profiles
- Command sets
- Allowed protocols

### Renew certs

- On main node go to Administration > System > Certificates
- Choose proper node
- Prepare certificate in PEM format + key in separate file
- Click Import, specify files + fiendly name
- Choose usage the same as for previous cert
- Click OK
- Everything will be restarted!!!

### Architecture

- PAN - policy administration node
- PSN - Policy service node
- MNT - monitoring and troubleshooting node
- IPN - Inline Posture Node
- Several nodes combined into one deployment are called cube
- All PSNs send their logs to the MnT as Syslog messages UDP/20514
- 2 interfaces on a node: one for management, one for requests
- If two MNT nodes exist in a deployment, all ISE nodes send their logs to both nodes.
- Inline Posture Nodes send logs only to one target
- However, the log database is not synchronized between the primary and secondary MnT nodes. Therefore, when the MnT node returns to service, a backup and restore of the monitoring node is required to keep the two MnT nodes in complete sync.
- The best practice for logging is to also send logging data to a security information manager (SIM) tool for long-term data archiving and reporting.
- PAN is responsible for admin GUI and synchronization of all ISE nodes
- In the eventof the primary PAN going offline, no synchronizations will occur until the secondary PAN is promoted to primary. After it becomes the primary, it will take over all synchronization responsibility. Some might consider this a “warm spare” type of high availability (HA)
- However, ISE does have a concept of a node group. Node groups are made up of Layer-2 adjacent (same VLAN) PSNs, where the nodes maintain a heartbeat with each other. In the event that a PSN goes down while a session is being authenticated, one of the other PSNs in the node group sends a CoA to the NAD so the endpoint can restart the session establishment with a new PSN. This is most commonly used when deploying the PSNs behind a load balancer. However, there is no requirement for node groups to be used solely with any Layer-2 adjacent PSNs
- You can configure AD groups of interest and then use them as conditions, you may also use AD attributes
- Certificate authentication profile - CAP tels ISE which value from certificate should be use for comparission during authorization
- ISS - identity source sequence - we can check user not only against one source but several
- We should use phasing deployment to do it safely: phase 1 - Monitor Mode, Phase 2 - Low Impact mode, Closed Mode

Deployment scenarios:

- Single node - all in 1
- 2 node - one primary and 1 backup
- 4 node - 2 appliances are PSN and 2 appliances are PAN MNT
- Fully Distributed


### Radius policies

- `Policy > Policy Sets`
- Policy Set consists of Conditions, Authentication Policies, Authorization Policies and Allowed Protocols
- Policy set looks at first packet of Radius request and based on its parametres decides which Policy Set to use and which authentication protocols are allowed
- `RADIUS Access-Request > Conditions > Allowed Protocols > Authentication Policy > Authorization Policy`
- Allowed protocols can be configured in `Policy Sets > Policy elements > Results`
- Authentication policy is scanned one by one like FW policy, if one is matched, lower rules are not scanned
- Auth policy has Conditions and `Identity Source Squence` - so its main purpose is to `specify the user database`
- `Administration > Identity Management > Identity Source Squence` - consist of several Authentication Search List (External Identity Sources)
- `Administration > Identity Management > External Identity Sources` - consists of several AD servers
- 



- One policy for all global protect connections
- Policies are served based on devices from which request arrived, protocol: TACACS or Radius, Radius Service Type
- When Palo Alto sends user via Radius, it also sends domain, thus it filters users
- Authentication in a policy can check many domains, so users from different domains can connect
- Devices in Policy are set via Device Type and written in the form: All Device Types#Company#PAN FWs#Global_Protect, all devices in this folder which sends Radius request will fall under the policy
- Plus in a policy we specify allowed protocols: `Policy > Policy Elements > Results > Authentication > Allowed Protocols`
- Here we specify which Auth protocols are allowed:
  
### Conditions

- `Policy > Policy elements > Conditions`
- Determine which Authentication and Authorization Policies will be applied
- Inside Authentication and Authorization policies themselves
- Policy Sets conditions:
  - Network Protocol: Radius or Tacacs
  - Device Type, Device Location - IP addresses of switch or AP
  - Radius-NAS-Port-Type - Ethernet or Wireless
  - Radius Service Type - Framed for VPN, Wired, Wireless

### Allowed protocols

- PAP/ASCii
- CHAP
- MS-CHAPv1
- MS-CHAPv2
- EAP-MD5
- EAP-TLS
- LEAP
- PEAP
- EAP-FAST
- EAP-TTLS
- TEAP

### Maitenance

Restart services

```
application stop ise
application start ise
show application status ise
```

### Devices

`Administartion > Network Resources > Network Devices`

- IP address - may be mask - wide range of IPs
- Devices profile
- Location
- Device Type
- Radius settings
  - Shared secret
  - CoA Port
- Tacacs settings
  - Shared secret
- SNMP settings - ?
- Trustsec settings

### Timeouts

- Work Centers -> Device Administration -> Settings -> Connection Settings.
- TACACS Protocol Session Timeout should be the default value of 5 minutes or less.
- TACACS Connection Timeout should be the default value of 10 minutes or less.
- Work Centers -> Device Administration -> Policy Elements -> Results -> TACACS Profiles.
- Any TACACS+ Shell Profile with "Shell" type should have "Idle Time" set to "10" minutes or less.

### Web based authentication with redirection

Portal types

- admin portal
- sponsor portal
- guest portal

### CLI

- show running config
- Reset GUI admin passwords: `application reset-passwd ise admin`
- Reset CLI admin password: `password`
- List all ISE processes and their statuses: `show application status ise`
- Configure DNS server: `config ip name-server 192.168.139.115`
- Show version: `show application version ise`
- Show interface: `show interface`
- Show routes: `show ip route`
- Reboot: `reload`
- `Show timezone`
- `show timezones`
- `configure; clock timezone`
- Show info required for license: `show udi`

## RADIUS

- RADIUS (Remote Authentication Dial-In User Service) is one of the fundamental AAA (Authentication, Authorization, Accounting) protocols in networking
- UDP port 1812 - auth, 1813 - accounting, no retransmission state beyond NAS implementation
- Radius does not provide the ability to control which commands can be executed - Only supports authorization after authentication is complete (not dynamic real-time policy during session)
- Radius encrypts only password - No end-to-end encryption
- Radius uses PAP, CHAP, MS-CHAP, EAP methods for authentication
- Radius combines auth and author in one reply in the form of AV pairs
- 1645 auth and 1646 accounting - old style
- Radius server cannot send requests to radius client, so RFC 3576 and RFC 5176 were created, so called Dyncamic Authorization Extensions or CoA - Change of Authorization
- With these extensions we can disable port or disconnect user for example or request reauthentication
- CoA - server initiated authorization update
- Radius packet is a bunch of Attribute Value Pairs
- EAP, PAP, MSCHAP are encapsulated in the form of AVP as well

Use cases:

- 802.1X wired and wireless networks
- Wi-Fi enterprise authentication
- VPN authentication
- Device management access (TACACS+ is more common for CLI)
- Captive portals
- Accounting & billing systems

### Workflow

- We configure on NAS, for example on VPN gateway:
  - Radius server IP
  - Shared Secret
  - Port - 1812
  - Authentication method: EAP methods, PAP, CHAP...
  - CA certificate to verify Radius server certificate
- Shared secret is used to calculate authenticator fields both from server and client, so both know that other part knows secret
- NAS collects user credentials → sends a `RADIUS Access-Request`
- Access request consists of `many Attribute Value Pairs`
- The password never appears in the Access-Request if EAP based Auth methods are used (EAP-TLS, PEAP + EAP-MSCHAPv2...)
- The password stays inside the EAP conversation, `not in RADIUS fields`
- RADIUS does not natively understand EAP methods
- Instead, RADIUS carries EAP inside the EAP-Message attribute as a transport

```
EAP-Message: <raw EAP frame>
Message-Authenticator: <HMAC>
```

- The RADIUS server (like ISE, FreeRADIUS, Azure AD) terminates EAP
- RADIUS itself does not interpret PEAP, EAP-TLS, EAP-TTLS logic, EAP is only encapsulated inside RADIUS
- RADIUS natively supports `PAP, CHAP, and MS-CHAPv2`
- Only PAP sends a user password in the Access-Request in the form of `User-Password attribute`, CHAP, MSCHAP do not use password as well, they use challenges
- So `RADIUS Access-Request` may contain a little bit different `Attribute Value Pairs`, depending on who sent the request
- Example of request from VPN Gateway:
  - NAS-Port-Type = Virtual
  - Framed-IP-Address (the IP assigned to client or requested)
  - Calling-Station-Id = client IP
  - Connect-Info = SSL/IPsec parameters
  - Service-Type = Framed-User

```
RADIUS Protocol
    Code: Access-Request (1)
    Identifier: 0x4b
    Length: 152
    Authenticator: 3c5d76996e8fbdc642114f9b3b2b884a
    Attribute Value Pairs
        User-Name: johndoe
        NAS-IP-Address: 10.1.1.10
        NAS-Identifier: vpn-gw01
        NAS-Port: 0
        NAS-Port-Type: Virtual (5)
        Service-Type: Framed (2)
        Calling-Station-Id: 203.0.113.55
        Called-Station-Id: vpn.company.com
        Framed-IP-Address: 10.50.10.25
        Connect-Info: "SSL VPN, TLS1.2"
        Tunnel-Type: VPDN (3)
        Tunnel-Medium-Type: IPv4 (1)
        EAP-Message: 02 01 00 12 01 6a 6f 68 6e 64 6f 65
        Message-Authenticator: 06:91:f3:0e:18:be:22:44:...
```

- Example of request from 802.1X Switch
  - NAS-Port (physical interface number)
  - NAS-Port-Type = Ethernet
  - Calling-Station-Id = client MAC
  - EAP-Message (fragmented during EAP-TLS)
  - Service-Type = Framed
  - Called-Station-Id = MAC of switch interface

```
RADIUS Protocol
    Code: Access-Request (1)
    Identifier: 0x22
    Length: 210
    Authenticator: 8b0eae3db88511a3c11adb3f5acdd922
    Attribute Value Pairs
        User-Name: 00-1C-42-BE-12-01
        NAS-IP-Address: 10.10.1.2
        NAS-Identifier: access-sw01
        NAS-Port: 50112
        NAS-Port-Type: Ethernet (15)
        Service-Type: Framed (2)
        Calling-Station-Id: 00-1C-42-BE-12-01
        Called-Station-Id: 00-25-90-AA-BB-CC
        EAP-Message:
            02 03 00 1a 01 00 00 16 30 14 30 12 06 ...
        Message-Authenticator: 77:13:ba:55:92:ae:6f:...
        Cisco-AVPair: "device-traffic-class=voice"
```

- Example of request from Router for Administrative Login
  - Service-Type = Login
  - NAS-Port-Type = Virtual or Async
  - NAS-Port identifies CLI session
  - User-Name = admin login username
  - No EAP
  - User password via PAP
- Often includes NAS-Port-Id = “tty0”, "vty1", etc

```
RADIUS Protocol
    Code: Access-Request (1)
    Identifier: 0x17
    Length: 128
    Authenticator: 22d3b8fa72bb001e2a11230d49d951ab
    Attribute Value Pairs
        User-Name: admin
        User-Password: <encrypted>
        NAS-IP-Address: 192.168.2.1
        NAS-Identifier: core-rtr01
        NAS-Port: 501
        NAS-Port-Type: Virtual (5)
        NAS-Port-Id: vty1
        Service-Type: Login (1)
        Calling-Station-Id: 192.168.2.44
        Acct-Session-Id: 00000023
        Message-Authenticator: 1c:ab:f1:77:1d:9e:bc:...
```

- Thus initial packet contains a lot of useful information: NAS IP-address, Username, User password, vendor specific Attribute Value Pairs
- This informaytion may be used to identify which policy will be used to access the request
- After first packet, if EAP is used, there is a series of packets to build the EAP tunnel
- All of this is carried inside:
- `RADIUS Access-Request (client → server)`
- `RADIUS Access-Challenge (server → client)`
- Next, there is another series of packets for inner method authentication, for example MSCHAPv2
- These MSCHAPv2 exchanges are also transported using:
- `RADIUS Access-Request`
- `RADIUS Access-Challenge`
- Example of `MSCHAPv2 in EAP in Radius`

```
Code: Access-Challenge
Identifier: 0x08
AVPs:
    EAP-Message:
        01 08 00 2a 1a 01
        <MSCHAPv2 Challenge: 16-byte ServerChallenge>
    State: 0x987634ab3829
    Message-Authenticator: <value>

Code: Access-Request
Identifier: 0x09
AVPs:
    User-Name: "johndoe"
    State: 0x987634ab3829
    EAP-Message:
        02 09 00 3a 1a 02
        <MSCHAPv2 Response: PeerChallenge + NT-Response>
    Message-Authenticator: <value>
```

- Only after inner authentication succeeds, the RADIUS server sends: `Access-Accept` with MS-MPPE keys (for VPN encryption keys), VLAN attributes, etc.
- MPPE keys (Microsoft Point-to-Point Encryption keys) are the session encryption keys used by PPTP and some L2TP/IPsec VPNs to encrypt PPP traffic
- If EAP is not used, then immediately after request NAC sends reply `Access-Accept/Reject`
- All final authorization happens in the last Access-Accept packet
- Examples of `authorization attributes`:
  - VLAN assignment (Tunnel-Private-Group-ID)
  - Access control lists (Filter-Id, Cisco-AVPair)
  - Session timeout
  - QoS policies (WLAN-QoS-Profile)
  - Framed-IP-Address
  - MPPE keys for VPN encryption
- Example of RADIUS Access-Accept (802.1X)

```
RADIUS Protocol
    Code: Access-Accept (2)
    Identifier: 0x22
    Length: 180
    Authenticator: c515f2a8060b15d9f0c4b9ca795a8312
    Attribute Value Pairs
        EAP-Message: 03 04 00 04        <-- EAP Success
        Message-Authenticator: 11:a8:...:de
        Tunnel-Type: VLAN (13)
        Tunnel-Medium-Type: IEEE-802 (6)
        Tunnel-Private-Group-Id: "20"
        Cisco-AVPair: "device-traffic-class=voice"
        Class: 4953452d53455353494f4e2d32333038 ("ISE-SESSION-2308")
        Session-Timeout: 86400
```

- Example of RADIUS Access-Accept (Router Login)

```
RADIUS Protocol
    Code: Access-Accept (2)
    Identifier: 0x17
    Length: 120
    Authenticator: 003fc47c11bc88357bd1fe7fddf3a881
    Attribute Value Pairs
        Service-Type: Login (1)
        Class: "corp-admins"
        Reply-Message: "Welcome admin"
        Filter-Id: "ADMIN_PRIV15"
        Idle-Timeout: 600
```

- After Access-Accept, authentication is over and no more RADIUS messages are exchanged for that session—unless `reauth or CoA occurs`
- 802.1X Reauthentication / Re-Auth Timer, Switch/AP periodically sends: `Access-Request → Access-Accept`

### Packet Types

Authentication

- Access-Request
- Access-Accept
- Access-Reject
- Access-Challenge (used to trabsport additional data: EAP, token codes, OTP, MSCHAP)

Accounting

- Accounting-Request (Start / Interim / Stop)
- Accounting-Response

CoA / DM (RFC 5176)

- CoA-Request / CoA-ACK / CoA-NAK
- Disconnect-Request / Disconnect-ACK / Disconnect-NAK

### Attributes

User Identification Attributes

- User-Name (1) - Example: User-Name = "jdoe" - Used in: PAP only (never for EAP)
- User-Password (2) - Encrypted using shared secret (only for PAP). - example: User-Password = "encrypted" - Used in: PAP only (never for EAP)

Network Access Server (NAS) Attributes

- NAS-IP-Address (4) - Example: NAS-IP-Address = 10.1.10.1 - Meaning: IP of switch, AP, VPN gateway sending request
- NAS-Identifier (32) - Example: NAS-Identifier = "SWITCH-1" - Meaning: Hostname or identifier of the NAS
- NAS-Port (5) - Example: NAS-Port = 10113 - Meaning: Physical port or logical port number
- NAS-Port-Type (61) - Example: Ethernet (15) for wired, Wireless-802.11 (19) for Wi-Fi, Virtual (5) for VPN - Used for: Policy rules

Service-Type (6)

- Common values:
- 1 = Login - SSH/Terminal/Telnet sessions
- 2 = Framed - 802.1X authentication for wired/wireless networks, PPP, PPPoE, and VPN connections
- 5 = Call Check - MAB
- Example: Service-Type = Framed

EAP Attributes

- EAP-Message (79) - Example: EAP-Message = 0x02000005... - Contains EAP-TLS/PEAP/etc
- Message-Authenticator (80) - Example: Message-Authenticator = 0x45a8... - HMAC-MD5 integrity check for EAP - Used in: All EAP methods

Calling/Called Attributes

- Calling-Station-Id (31) - Example: Calling-Station-Id = "AA-BB-CC-DD-EE-FF" - Meaning: Client MAC address for 802.1X/Wi-Fi
- Called-Station-Id (30) - Example (Wi-Fi): - Called-Station-Id = "88-AC-F1-01-02-03:CorpWiFi" - Meaning: AP MAC + SSID

Framed Attributes (mostly for VPN)

- Framed-IP-Address (8) - This is typically sent in Accept packet - Example: Framed-IP-Address = 192.168.10.55 - IP address for client, instead of DHCP
- Framed-MTU (12) - Example: Framed-MTU = 1400
- Framed-Protocol (7) - Example: Framed-Protocol = PPP (1) - Mostly for VPN/PPP

Vendor-Specific Attributes (VSA)

- Vendor-Specific (26) - Contains nested vendor attributes - Example showing a Cisco AVPair: Cisco-AVPair = "shell:roles=network-admin"
- VSA examples by vendor: Cisco: VLAN, ACLs, roles - Aruba: Aruba-User-Role - Palo Alto: Filter-Id for group mapping - Microsoft: MS-CHAP attributes

Authorization (Accept Packet) Attributes

- Filter-Id (11) - Example: Filter-Id = "StudentPolicy" - Common for VPN and WLAN ACL assignment
- Tunnel-Medium-Type (65) - Example: Tunnel-Medium-Type = 6 (802) - Required for VLAN assignment
- Tunnel-Type (64) - Example: Tunnel-Type = VLAN (13)
- Tunnel-Private-Group-ID (81) - Example: Tunnel-Private-Group-Id = "30" - Means VLAN 30

Accounting Attributes

- Acct-Status-Type (40) - Values: Start (1), Stop (2), Interim-Update (3)
- Acct-Session-Id (44) - Example: Acctime.12345abcd
- Acct-Input-Octets (42), Acct-Output-Octets (43) - Traffic counters

### Security Model

- RADIUS uses a shared secret and MD5-based hashing
- The password in Access-Request is obfuscated using MD5 + secret (not actual encryption)
- Entire packet is NOT encrypted
- EAP payloads (EAP-TLS etc.) are carried inside RADIUS but security comes from TLS, not RADIUS
- Modern deployments rely on EAP-TLS or PEAP for true security

### CoA

- Change of Authorization (CoA) port is used to send dynamic policy updates to network devices after initial authentication
- Part of the RADIUS protocol and is defined in the IETF RFC 5176
- After an initial authentication, Cisco ISE can use CoA to dynamically update the authorization of a session (e.g., changing VLAN assignment or access control list (ACL) permissions)
- The default CoA port for RADIUS is UDP port 1700. This is the port through which CoA messages are sent to network devices, such as switches or wireless controllers
- CoA Types:
  - Re-Auth (Reauthentication): Forces the endpoint to reauthenticate using the same credentials but applying new authorization policies
  - Port-Bounce: Disconnects the client (causing a reauthentication) by momentarily shutting down the port (used in wired scenarios)

### Accounting

- Shows when user connects, disconnects, how much data sent/received
- When a user/session begins, the Network Access Server (NAS) sends an Accounting-Start packet to the RADIUS server
- During a session, the NAS may send Interim-Update packets at intervals (e.g., every 5 minutes) - with bytes sent/received for example
- When the session ends, the NAS sends Accounting-Stop
- Standard RADIUS accounting cannot log user commands, so it is useless for admin accounting
 
## Cisco switch configuration for 802.1X

Port can be configured in different modes:

- single host - only one host connected - one MAC address
- multi-host - many MAC addresses - first MAC open the door and then others can work as well
- multi-domain - domains voice and data, when phone and PC on one port, auth of one device on voice VLAN and one device on data vlan
- multi-auth - ever single mac address should be authenticated

Verify configuration

- Show all dot1x configured ports: `show dot1x all`
- Show all dot1x authentications for particular port: `show authentication sessions int gig0/7`
- show interface status
- show authentication int gig0/7
- debug radius authentication

Switch configuration

```
aaa new-model
aaa authentication login default enable

#Enable dot1x globally
dot1x system-auth-control

#Enable ip device tracking, this command allows for the any source in the provided dACL to be replaced with the IP address of the single device connected to the port.
ip device tracking

#Enable AAA via Radius
aaa authentication dot1x default group radius
aaa authorization network default group radius
aaa accounting dot1x default start-stop group radius

#Configure Radius server
radius server ise
     address ipv4 192.168.139.114 auth-port 1812 acct-port 1813
     key test
aaa group server radius ise-group
     server name ise

[Optional]
#Configure radius server load balancing
radius-server load-balance method least-outstanding batch-size 5

#Enable use of vendor specific attributes
radius-server vsa send authentication
radius-server vsa send accounting

#Enable 3 VSAs
radius-server attribute 8 include-in-access-req - include supplicant IP in a request
radius-server attribute 6 on-for-login-auth - login request uncludes Service-Type
radius-server attribute 25 access-request include - Class

#Enable change of authorization
aaa server radius dynamic-author
client ise_ip server-key shared_secret

#Configure actions in case of failures
authentication event fail action next-method
authentication event server dead action authorize
authentication event server dead action authorize voice
authentication event server alive action reinitialize

#Configure violation action
authentication violation restrict

#Configure Interface
int gig0/7
switchport host or switchport mode access & spanning-tree portfast
authentication host-mode multi-auth
authentication open - open mode for testing
authentication periodic
authentication timer reauthenticate server - let server decide how often to reauthenticate
dot1x pae authenticator
dot1x timeout tx-period 10 - supplicant retry timeout
authentication port-control auto
do debug readius authentication
no shutdown

#Test
test aaa group  ise-group bob passwd new-code
```

## Cisco switch configuration for MAB

```
#Let ISE understand that it is mac address
radius-server attribute 6 on-for-login-auth
radius-server attribute 25 access-request include

#Enable mab
mab

#Authentication order
authentication order mab dot1x

#Authentication priority
authentication priority dot1x mab
```

## TACACS

- Tacacs was initially created to control access to Unix terminals, then Cisco created Tacacs+, mostly used for device administration
- Tacacs+ uses TCP port 49
- Tacacs+ encryptes entire payload
- All the devices that will be controlled and audited by TACACS device administration, should have TACACS secrets set
- Enable on a node: `Administration > Deployment > Node > Enable Device Admin Service`

### ISE logic

- Device admin policy triggers based on Device Type, Location, Protocol, Username
- Then it enforces a set of rules of Authorization policy
- These rules add additional conditions
- These rules apply Command Sets + Shell Profiles

### Add device for TACACs auth

`Administartion > Network Resources > Network Devices`

- Device Profile
- Network Device Group:
  - Location
  - IPSEC - ?
  - Device Type
- TACACS shared secret

### Device Admin Policy Sets

`Work Centers > Device Administration Policy Sets`

- Policy Name
- Conditions
  - Protocol
  - User
  - Device Type
  - Device Location
- Allowed protocol
- Authentication Policy
- Authorization Policy
- Authorization Policy - Local Exceptions
- Authorization Policy - Global Exceptions

Authorization Policy

- Rules
  - Name
  - Conditions
    - Users
    - Groups
  - Command sets
  - Shell Profiles
 
### Shell profiles

`Device Administration / Policy Elements / Results / TACACS Profiles`

- List of atttributes - that's all

### TACACS command sets

- Usually allow all
- allow/deny
- Command
- Arguments

### Logs

`Operations > TACACS > Live Logs`

- Each successfull login generates 2 logs: Authentication and Authorization
- All details are available:
  - Authentication Policy
  - Authorization Policy
  - Shell profile
  - Response at

### Monitor amount of requests

`Operations > Reports > Reports > Device Administration`

### Switch configuration

```
aaa new-model - enable aaa
tacacs-server host 192.168.139.125
Switch(config)#aaa authentication login default group tacacs+ local
aaa authorization commands 15 default group tacacs+ local
aaa authorization config-commands
aaa authorization exec default group tacacs+ local
aaa accounting commands 15 default start-stop group tacacs+
```

## PXGrid

- Used to send info from ISE to all other devices, for example FTDsed to send info from ISE to all other devices, for example FTD

## MACsec

- To protect segment between PC and switch.
- Confindetiality and integrity check of each of the frames
- Macsec key agreement - MKA - between PC and switch
- Different frame type - new 802.1AE Header + CMD field + ICV field
- It can be extended to protect data berween switches
- It uses hop by hop encryption 
- Security Assosation Protocol - SAP - for encryption between two switches

## Trustsec

- Trustsec allows control and filter traffic based on Security Group Tags.
- Every user gets its own tag after authentication and tag is injected into Ethernet frame

## Design

- 2 F5s in 2 different DataCenters - both have the same Anycast address - 10.255.255.3
- Every F5 points to 2 VMs with Tacacs module in the same data centre
- Request goes to the closest to the client F5, based on routing to Anycast address
- So we have 4 VMs: 2 in each data center
- It is better to use app level monitor on F5, because sometimes Tacacs service stuck and keeps replying to to TCP requests
- The same for Radius


