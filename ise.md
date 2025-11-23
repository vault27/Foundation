# ISE

## 802.1X

- 802.1X is an IEEE standard for network access control
- It defines how devices authenticate before they are allowed to send normal traffic on: wired Ethernet, Wi-Fi (WPA2/WPA3-Enterprise), MACsec-enabled networks
- 802.1X is a framework that controls who can connect to the network by requiring authentication at the moment a device plugs in or associates to Wi-Fi
- Login before network access
- Supplicant - PC
- Authenticator - switch, AP
- Authentication server - ISE
- This standard defines using of Radius, EAP, EAPOL...
- 802.1X itself does not define authentication—it only transports EAP methods

## EAP

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
- The method defines those
- EAP is used in:
  - IKEv2 – VPN authentication EAP messages are carried inside IKE_AUTH encrypted payloads
  - 802.1X (Wired/Wireless): EAP runs between the client and authenticator, and is transported to RADIUS/ISE - EAP inside EAPOL
- The full TLS handshake is between the Supplicant (Client PC) and the Authentication Server (Cisco ISE) - switch or AP is just a forwarder
- PPP (PPP-EAP)
- Dial-in, broadband, LTE, etc.
- RADIUS: EAP is encapsulated in EAP-Message attributes inside RADIUS packets
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

### EAP inside EAPOL

- EAPOL is just the L2 transport for EAP
- The switch does NOT process EAP. It only forwards it to ISE via RADIUS
- EAP-TLS is very fragmented, especially Certificates
- The full TLS handshake is between the Supplicant (Client PC) and the Authentication Server (Cisco ISE)

This is the typical order:
1. EAPOL-Start (client)
2. EAP-Request/Identity (switch)
3. EAP-Response/Identity (client)
4. EAP-Request (method) (switch)
5. EAP-Response (method) (client)
6. EAP-Success or Failure

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

Frame 6 — EAP-Request / EAP-TLS (ServerHello + Certificate, ISE > Switch > Client)

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

### EAP METHODS

**Native Methods(a.k.a. "standalone methods")**

- EAP-TLS: mutual certificate authentication, strongest, widely used for Wi-Fi and VPN with smartcards - full TLS session inside EAP - `TLS → wrapped in EAP → wrapped in RADIUS → transported between ISE and NAS/switch/WLC`
- EAP-MD5 - insecure, no server auth
- EAP-PWD - password based, stromg crypto
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
- Because outer methods only provide:
  - Server authentication
  - TLS tunnel creation
  - Protection against credential snooping
- 
- EAP-MSCHAPv2: username/password, used for VPNs, weak, avoid for Wi-Fi
- EAP-TTLS: TLS tunnel + username/password inside
- PEAP: Microsoft flavor, TLS tunnel + MSCHAPv2 inside

**EAP-TLS**

- In EAP-TLS, the authentication is completed by the certificates during the TLS handshake
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

## Components

- Device
- Device groups: locations, types
- Device profiles
- Device admin policy sets
- Shell profiles
- Command sets
- Allowed protocols

## Architecture

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

## Maitenance

Restart services

```
application stop ise
application start ise
show application status ise
```

## Devices

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

## RADIUS

## Authentication methods

- PEAP-MSCHAPv2 - combination of protocols - everything inside Radius protocol
  - PEAP is a protocol framework that establishes a secure TLS (Transport Layer Security) tunnel for transmitting authentication data
  - MSCHAPv2 (Microsoft Challenge Handshake Authentication Protocol, Version 2): inner authentication protocol that handles username and password-based verification within the secure PEAP tunnel
  - MSCHAPv2 is inside PEAP, and PEAP is encapsulated within RADIUS
  - Only ISE sends certificate to Palo Alto, which should have CA to validate it
- EAP-TLS
  - Server and Client certificates are required
  - Credentials used: certificate
- EAP-Fast
  - No client and server certs are required

### CoA

- Change of Authorization (CoA) port is used to send dynamic policy updates to network devices after initial authentication
- Part of the RADIUS protocol and is defined in the IETF RFC 5176
- After an initial authentication, Cisco ISE can use CoA to dynamically update the authorization of a session (e.g., changing VLAN assignment or access control list (ACL) permissions)
- The default CoA port for RADIUS is UDP port 1700.This is the port through which CoA messages are sent to network devices, such as switches or wireless controllers
- CoA Types:
  - Re-Auth (Reauthentication): Forces the endpoint to reauthenticate using the same credentials but applying new authorization policies.
  - Port-Bounce: Disconnects the client (causing a reauthentication) by momentarily shutting down the port (used in wired scenarios).

## 802.1X

Show all dot1x configured ports

show dot1x all

Show all dot1x authentications for particular port

show authentication sessions int gig0/7

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

## Timeouts

Work Centers -> Device Administration -> Settings -> Connection Settings.
TACACS Protocol Session Timeout should be the default value of 5 minutes or less.
TACACS Connection Timeout should be the default value of 10 minutes or less.

Work Centers -> Device Administration -> Policy Elements -> Results -> TACACS Profiles.
Any TACACS+ Shell Profile with "Shell" type should have "Idle Time" set to "10" minutes or less.

## Radius Policies

- `Policy > Policy Sets`
- One policy for all global protect connections
- Policies are served based on devices from which request arrived, protocol: TACACS or Radius, Radius Service Type
- When Palo Alto sends user via Radius, it also sends domain, thus it filters users
- Authentication in a policy can check many domains, so users from different domains can connect
- Devices in Policy are set via Device Type and written in the form: All Device Types#Company#PAN FWs#Global_Protect, all devices in this folder which sends Radius request will fall under the policy
- Plus in a policy we specify allowed protocols: `Policy > Policy Elements > Results > Authentication > Allowed Protocols`
- Here we specify which Auth protocols are allowed:
  - PAP/ASCii
  - CHAP
  - MS-CHAPv1
  - MS-CHAPv2
  - EAP-MD5
  - EAP-TLS
- And EAP protocols
  - LEAP
  - PEAP
  - EAP-FAST
  - EAP-TTLS
  - TEAP

## Renew certs

- On main node go to Administration > System > Certificates
- Choose proper node
- Prepare certificate in PEM format + key in separate file
- Click Import, specify files + fiendly name
- Choose usage the same as for previous cert
- Click OK
- Everything will be restarted!!!