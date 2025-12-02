# NAC

## 802.1X

- 2001 is the year the standard was formally created and released
- Cisco was the first major vendor to ship 802.1X support in switches around 2001–2002, along with early RADIUS integrations with Cisco ACS
- 802.1X is an IEEE standard for network access control
- It defines how devices authenticate before they are allowed to send normal traffic on: wired Ethernet, Wi-Fi (WPA2/WPA3-Enterprise), MACsec-enabled networks
- 802.1X is a framework that controls who can connect to the network by requiring authentication at the moment a device plugs in or associates to Wi-Fi
- Login before network access
- Supplicant - PC
- Authenticator - switch, AP
- Authentication server - ISE
- This standard defines using of Radius, EAP, EAPOL...
- 802.1X itself does not define authentication — it only transports EAP methods
- Wired: `Supplicant > EAPOL over L2 link > Authenticator(Switch) > EAP inside Radius over L3 link > Authentication Server`
- Wireless: `Supplicant > EAP over WLAN(EAP over IEEE 802.11) > Authenticator(Access point) > EAP inside Radius over L3 link > Authentication Server`

### EAP

- EAP existed before 802.1X and was originally created for PPP (Point-to-Point Protocol)
- Extensible Authentication Protocol (EAP) is not an authentication method by itself
- It is a framework that allows many authentication methods to be plugged into it
- EAP = a wrapper / container for authentication carried over something else
- EAP defines:
  - message types (Request, Response, Success, Failure)
  - how clients and servers negotiate methods
  - how outer protocols encapsulate EAP
- EAP does not define:
  - how keys are exchanged
  - how clients authenticate
  - how servers authenticate
- The auth method defines those
- EAP is used in:
  - IKEv2 – VPN authentication EAP messages are carried inside IKE_AUTH encrypted payloads
  - 802.1X (Wired/Wireless): EAP runs between the client and authenticator, and is transported to RADIUS/ISE - EAP inside EAPOL
  - PPP (PPP-EAP)
  - Dial-in, broadband, LTE, etc.
  - RADIUS: EAP is encapsulated in EAP-Message attributes inside RADIUS packets
- The full TLS handshake is between the Supplicant (Client PC) and the Authentication Server (Cisco ISE) - switch or AP is just a forwarder
- Everything is just Request/Response pairs, repeated until the method finishes

```
  Server         Client
------         -------
EAP-Request →  
             ← EAP-Response
EAP-Request → 
             ← EAP-Response
... repeats ...
EAP-Success/Failure →
```

**EAP inside EAPOL**

- EAPOL is just the L2 transport for EAP
- The switch does NOT process EAP. It only forwards it to ISE via RADIUS
- The full TLS handshake is between the Supplicant (Client PC) and the Authentication Server (Cisco ISE)

This is the typical order:

1. EAPOL-Start (client)
2. EAP-Request/Identity (switch)
3. EAP-Response/Identity (client)
4. EAP-Request (method) (switch)
5. EAP-Response (method) (client)
6. EAP-Success or Failure



### EAP METHODS

**Most Used**

- PEAP + EAP-MSCHAPv2 - user/apssword
- EAP-TLS - certificates

**Native Methods(a.k.a. "standalone methods")**

- EAP-TLS: mutual certificate authentication, strongest, widely used for Wi-Fi and VPN with smartcards - full TLS session inside EAP - `TLS → wrapped in EAP → wrapped in RADIUS → transported between ISE and NAS/switch/WLC`
- EAP-MD5 - insecure, uses digest algorithm to hide credentials, does not have mutual authentication. Some switches use it for MAB, some IP phones use it
- EAP-PWD - password based, strong crypto
- EAP-SRP - secure remote password
- EAP itself carries all authentication data
- No “inner” methods
- No tunnel wrapping EAP
- Example: EAP-TLS is entirely self-contained: TLS handshake happens directly in EAP messages. No second method inside
- Only EAP messages are carried inside EAPOL frames on the LAN

```
Ethernet
 └─ 802.1X (EAPOL)
     └─ EAP
         └─ EAP-Method (TLS handshake messages)
```

**Tunneled EAP Methods (methods that create a secure tunnel first)**

- A tunneled method first creates an encrypted outer tunnel, then authenticates inside that tunnel using some inner method
- Outer methods (PEAP, EAP-TTLS, EAP-FAST) REQUIRE an inner method
- They only create an encrypted channel
- Outer method = secure tunnel
- Inner method = how you prove who you are inside the tunnel
- Because outer methods only provide:
  - Server authentication
  - TLS tunnel creation
  - Protection against credential snooping
- Outer methods - cannot work by it self - they need inner method - they are all “TLS-based,” but the tunnels are not the same - They differ in how the tunnel is created, what keys are used, what is allowed inside, and how the client/server authenticate each other:
  - PEAP → TLS tunnel + EAP-MSCHAPv2 inside, requires server cert - Enterprise Wi-Fi with AD (most common) - only allows EAP inner methods
  - EAP-TTLS → TLS tunnel + ANY inner method (PAP/CHAP/MSCHAPv2/EAP), requires server cert - no client cert -  - username+passwd - Best for RADIUS servers in Linux/FreeRADIUS setups needing PAP/LDAP
  - EAP-FAST → TLS tunnel built using PAC instead of server cert, Cisco-centric - Cisco-only shops where certificate deployment is hard
- Inner methods - cannot live without outer methods:
  - EAP-MSCHAPv2: username/password, used for VPNs, weak, avoid for Wi-Fi - MSCHAPv2 encapsulated as an EAP inner method - not pure MSCHAPv2
  - PAP
  - CHAP / MS-CHAP / MS-CHAPv2

**MSCHAPv2**

- In short: using complex computation server and client generates NT-Response using: `Server Challenge, Client Challenge, Username, Password, DES Encryption, SHA-1, MD-4`
- MSCHAPv2 = Microsoft Challenge Handshake Authentication Protocol, version 2
- Password-based authentication protocol
- Designed for PPP, VPNs, and 802.1X inner authentication
- Provides mutual authentication between client and server - v1 supports only client
- Generates a shared session key for subsequent encryption (MPPE in VPNs) - `optional`
- Server generates a 16-byte random challenge
- Client generates its NT hash of the password: `NT-Hash = MD4(unicode(password))` - only MD4 is used - Weak! - that is why TLS tunnel is required
- Peer Challenge = a 16-byte random value generated by the client
- `ChallengeHash = SHA1(PeerChallenge || ServerChallenge || Username)` - generated by client
- Only first 8 bytes of challenge hash are used as DES plaintext
- Pad NT-Hash to 21 bytes → split into 3 × 7-byte blocks → convert each to 8-byte DES key
- Encrypt ChallengeHash (8 bytes) with each DES key → concatenate → `24-byte NT-Response`
- Client sends `NT-Response + Peer Challenge to server`
- Server does same computation using stored NT-Hash → compares NT-Response → `Success/Fail`
- CHAP: Basic challenge-response, MD5, no mutual auth
- MS-CHAP v1: Microsoft’s version, uses NT hash, one-way authentication.
- MS-CHAP v2: Adds mutual authentication, peer challenge, and session key; much stronger and used in PEAP inner auth.

**PEAP + MSCHAPv2 after TLS Handshake**

- Everything encrypted inside TLS
- 4 messages
- Server sends PEAP AVP with EAP-Request (MSCHAPv2 Challenge) - Inside TLS, the server sends a standard MSCHAPv2 Challenge (16-byte random challenge)

```
EAPOL
  EAP-Request (Type: PEAP)
    TLSv1.2 Application Data
      PEAP TLV
        EAP-Request
          Type: MSCHAPv2 (26)
          MSCHAPv2: Challenge
            Challenge: 52 1a 9e f1 8b 23 87 2c ...
            Name: host/MyRadiusServer
```

- Client responds: PEAP + EAP-Response (MSCHAPv2 Response)

```
EAPOL
  EAP-Response (PEAP)
    TLSv1.2 Application Data
      PEAP TLV
        EAP-Response
          Type: MSCHAPv2 (26)
          MSCHAPv2: Response
            Peer-Challenge: 2b 3d 19 9a 44 e5 aa 07 ...
            NT-Response: 9c 66 bc 4e 94 5d 18 61 ...
            Flags: 0x00
```

- Server sends PEAP TLV: Success + EAP-Success (inner)

```
EAPOL
  EAP-Request (PEAP)
    TLSv1.2 Application Data
      PEAP TLV
        Result TLV: Success
        EAP-Request
          Type: MSCHAPv2 (26)
          MSCHAPv2: Success
            Message: "S=11223344556677889900..."
```

- Client acknowledges inner success

```
EAPOL
  EAP-Response (PEAP)
    TLSv1.2 Application Data
      PEAP TLV
        Result TLV: Success
        EAP-Response
          Type: MSCHAPv2 (26)
          MSCHAPv2: ACK
```

**EAP-TLS**

- In EAP-TLS, the authentication is completed by the certificates during the TLS handshake
- In pure EAP-TLS, nothing is sent “inside a tunnel” after the TLS handshake
- Full mutual certificate validation
- There is no inner method, no inner username, no MSCHAPv2, no PAP.
- ISE sends CertificateRequest
- Client sends:
  - Client Certificate
  - ClientKeyExchange
  - CertificateVerify (signed with client private key)
- ISE validates:
  - certificate chain
  - certificate’s key usage
  - revocation (CRL/OCSP)
  - trust store 
  - identity (CommonName/SAN)
  - optional—mapping to AD/endpoint ID
- This cryptographic proof is the authentication
- After authentication is finished the switch opens the port and applies authorization (VLAN, ACL, SGT, etc.)
- TLS generates a Master Secret
- From that, EAP-TLS derives: MSK (Master Session Key, 64 bytes), EMSK (64 bytes)
- These are sent (via RADIUS) to the switch/WLC from ISE in encrypted form using the shared secret and MD5-based obfuscation
- And used to create:
  - WPA2/WPA3 Pairwise Master Key (PMK)
  - Wired 802.1X session keys
  - Fast roaming keys (PMKID)
- AP/WLC and client use the MSK to derive the PMK (Pairwise Master Key).
- AP and client run the 4-Way Handshake to prove possession of the PMK and derive:
  - PTK (Pairwise Transient Key)
  - GTK (Group Temporal Key)
- PTK is used to encrypt unicast traffic between client and AP (WPA2/3)
- GTK is used to encrypt broadcast/multicast traffic

### Wired auth work flow

- Client (supplicant) sends `EAPOL-Start` broadcast to the switch (authenticator)
- Switch (authenticator) sends `EAP-Request/Identity` frame to client
- Client responds with username (`EAP-Response/Identity`) - At this point, no method is chosen yet — only the identity is exchanged
- Authenticator passes identity to authentication server
- Switch encapsulates the EAP packet in RADIUS Access-Request and forwards to RADIUS / AAA server (authentication server)
- Server now knows the username and can look up the user’s profile/policy: `Which EAP method is allowed`
- It decides the method based on user group, device, or other policy
- Server responds with EAP-Request specifying outer method: For example: EAP-Request / PEAP Start
- The EAP Type field indicates which outer method the client should use
- Switch forwards this packet to client
- Client evaluates supported methods
- If supported: proceeds → starts TLS handshake
- Inside that tunnel, the inner authentication method is negotiated
- Once the tunnel is up, the server sends an EAP-Request inside the TLS tunnel
- The Type field specifies the inner method
- The server may also send an initial challenge if the inner method is challenge/response
- Client examines the inner method, If supported → proceeds with inner authentication
- After agreeing on the inner method, actual authentication proceeds inside the TLS tunnel
- EAP-MSCHAPv2 example:
  - Server → Client: Challenge (16-byte random)
  - Client → Server: Response (hash of password + challenge)
  - Server verifies → sends Success / Failure
- In practice:
  - PEAP → nearly fixed: MSCHAPv2
  - TTLS → can vary: PAP/CHAP/MSCHAPv2/EAP
  - FAST → usually MSCHAPv2 or GTC

### EAP Packets

**Frame 1 — EAPOL-Start (client → switch)**

```
Frame 1: 30 bytes on wire
Ethernet II
   Destination: 01:80:c2:00:00:03   (EAPOL multicast)
   Source:      3c:22:fb:aa:bb:cc
   Type: 0x888e (802.1X Authentication)

EAPOL
   Version: 1
   Type: EAP-Packet (0)
   Length: 0
```

This tells the switch: `"Hey, I want to authenticate via 802.1X"`

**Frame 2 — EAP-Request / Identity (switch → client)**

```
Frame 2: 60 bytes
Ethernet II
   Type: 0x888e (802.1X)

EAPOL
   Version: 1
   Type: EAP-Packet (0)
   Length: 9

EAP
   Code: Request (1)
   Identifier: 0x01
   Length: 9
   Type: Identity (1)
```

Switch asks: `"Who are you?"`

**Frame 3 — EAP-Response / Identity (client → switch)**

```
Frame 3: 78 bytes
Ethernet II
   Type: 0x888e

EAPOL
   Version: 1
   Type: EAP-Packet (0)
   Length: 25

EAP
   Code: Response (2)
   Identifier: 0x01
   Length: 25
   Type: Identity (1)
   Identity: host/WIN10PC.example.com
```


Switch now takes this and wraps it into `RADIUS → forwards to ISE`

**Frame 4 — EAP-Request / EAP-TLS Start (switch → client)**

```
Frame 4: 110 bytes
Ethernet II
   Type: 0x888e

EAPOL
   Version: 1
   Type: EAP-Packet (0)
   Length: 42

EAP
   Code: Request (1)
   Identifier: 0x02
   Length: 42
   Type: EAP-TLS (13)
      Flags: 0x20 (Start)
      TLS Data: <empty>
```

ISE says: `Begin EAP-TLS now`

**Frame 5 — EAP-Response / EAP-TLS (ClientHello, client to switch)**

```
Frame 5: 214 bytes
Ethernet II
   Type: 0x888e

EAPOL
   Length: 152

EAP
   Code: Response (2)
   Identifier: 0x02
   Length: 152
   Type: EAP-TLS (13)
      Flags: 0xc0 (More Fragments + Length Included)
      TLS Message Length: 517
      TLS Data (fragment 1): ClientHello
         TLSv1.2 Record Layer
         Handshake Protocol: Client Hello
            Cipher Suites: ...
            Random: ...
```

**Frame 6 — EAP-Request / EAP-TLS (ServerHello + Certificate, ISE > Switch > Client)**

```
Frame 8
EAP
   Code: Request (1)
   Identifier: 0x03
   Type: EAP-TLS
      Flags: 0xc0 (More Fragments + Length Included)
      TLS Message Length: 3230
      TLS Data (fragment 1):
         TLSv1.2 Record: ServerHello
         TLSv1.2 Record: Certificate (fragment)
```

In EAP-TLS, the authentication is completed by the certificates during the TLS handshake

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


## RADIUS



### CoA

- Change of Authorization (CoA) port is used to send dynamic policy updates to network devices after initial authentication
- Part of the RADIUS protocol and is defined in the IETF RFC 5176
- After an initial authentication, Cisco ISE can use CoA to dynamically update the authorization of a session (e.g., changing VLAN assignment or access control list (ACL) permissions)
- The default CoA port for RADIUS is UDP port 1700.This is the port through which CoA messages are sent to network devices, such as switches or wireless controllers
- CoA Types:
  - Re-Auth (Reauthentication): Forces the endpoint to reauthenticate using the same credentials but applying new authorization policies
  - Port-Bounce: Disconnects the client (causing a reauthentication) by momentarily shutting down the port (used in wired scenarios)

## Cisco switch commands

- Show all dot1x configured ports: `show dot1x all`
- Show all dot1x authentications for particular port: `show authentication sessions int gig0/7`

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

