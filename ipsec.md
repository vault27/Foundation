# IPSec

## Concepts

- IPsec is not a protocol, it's a framework for securing unicast traffic
- It consists of 3 protocols:
    - ESP 
    - AH(obsolete)
    - IKE v1 or v2
- For negotiations(IKE) UDP port 500 is used
- Encapsulating Security Payload uses IP protocol 50 or UDP 4500 if NAT is present
- Authentication Header uses IP protocol 51.  
- IKE - set of protocols to exchange keys
- ISAKMP -  protocol to manage keys - responsible for Security Associations
- IPSec uses both of them
- ISAKMP is part of IKE. IKE comprises the three following protocols:
    - ISAKMP
    - SKEME
    - OAKLEY
- Does not support multicast and broadcast, OSPF, EIGRP cannot be used, GRE inside IPSec solves the problem
- IKE v1 Phase 1 + IKE Phase 2 - 2 tunnels
- Tunnel 1 is used to negotiate parametres for tunnel 2, tunnel 1 is used only for communication between firewalls, then for actual data only tunnel 2 is used directly, they work in paralell
- Is there any IKE traffic, when everything is established and data flows normally - yes, keepalives via port UDP/500, if NAT-T is enabled then UDP/4500 is used
- Security Associations are negotiated for both tunnels
- In the IPsec/IKE world, the “initiator” is the peer that first sends an IKE packet to start the negotiation
- The responder replies. This role is independent of who sends actual data over ESP later

## IKE v1

- v1 - 9 messages in total via main mode
- v1 - 6 messages in total via aggressive mode
- v2 - 4 messages in total
- IKE is a key exchange protocol that uses ISAKMP as its message framework
- ISAKMP (RFC 2408) is a framework and message format for negotiating security associations (SAs)
- It defines: How packets are formatted (headers, payload types), A generic state machine for SA negotiation, But not how keys are exchanged
- IKE (Internet Key Exchange, RFC 2409 for v1, RFC 5996/7296 for v2) is a protocol that uses ISAKMP as its payload/container format plus adds the cryptographic logic
- IKEv1 = Oakley + SKEME + ISAKMP
- Oakley protocol → key exchange modes + use of Diffie-Hellman
- Defines:
    - Use of Diffie–Hellman
    - Key derivation techniques
    - Security properties (anti-clogging tokens, identities, nonces)
    - "Oakley Groups": Predefined mathematical groups (e.g., specific prime numbers and generators) used for the DH exchange
- SKEME protocol → ideas about rekeying, quick key refresh, key derivation
- Contributed:
    - Ideas for identity protection
    - How to refresh keys easily
    - Key hierarchy concepts
- ISAKMP → packet format, payload types, SA negotiation framework
- Negotiates and manages IKE and IPsec parameters
- Authenticates secure key exchange
- Provides mutual peer authentication by means of shared secrets (not passwords) and public keys
- Provides identity protection (in main mode)

### Workflow

- IKE Phase 1 — Establish a secure channel (IKE SA) - starts with UDP/500, may switch to UDP/4500
    - `Main mode` - 6 messages
    - `Aggressive mode` - 3 messages
    - DH key exchange
    - Authentication
    - NAT-T negotiation
    - IKE SA - one for inbound and outbound - IKE SA is bidirectional
    - Local SPI → The SPI that your router uses when sending ISAKMP messages
    - Remote SPI → The SPI your router expects in incoming ISAKMP messages from the peer
- XAuth
- Config mode
- IKE Phase 2 — Negotiate IPsec SAs (ESP or AH) - `Quick mode` - UDP/500 or UDP4500
    - Negotiate 2 IPsec SAs - inbound and outbound - crypto parametres the same - keys are different
    - Exchange traffic selectors (Proxy-ID) - should be the same
    - `Outbound SPI` - The SPI my router inserts into ESP packets I send
    - `Inbound SPI` - The SPI my router expects to see in ESP packets I receive
    - Transform sets
- ESP encapsulation — Actual data traffic encryption/authentication using the negotiated keys - IP/50 or UDP/4500 - Destination SPI is in header

### Phase 1

- During traffic capture you cannot see Phase 2 negotiation, only Phase 1 as ISAKMP protocol, everything else is encrypted
- Phase 1 SA is called ISAKMP SA or IKE SA
- The Phase 1 keys are long-lived and tied to identity/authentication
- IKE SA and IPSec SAs must be cryptographically independent
- Phase 1 establishes an ISAKMP(Internet Security Association and Key Management Protocol) SA, which is a secure channel through which the IPsec SA negotiation can take place.  
- Next step in Phase 1 is to run Diffie Hellman and to establish secret keys And the next step is to authenticate each other 
- And only after this IKE Phase 1 is established, it is used only for communications between firewalls themselves
- The ISAKMP header has its own SPI pair
- These SPIs identify the IKE SA
- IKE SAs are bidirectional

Negotiations:

- Hashing - md5 or sha - used inside HMAC for authentication and integrity - Identity authentication (HASH_I / HASH_R) + Integrity of IKE messages
- Authentication - PSK or certificates
- Group - Diffie Helman group - algorithm which is used to establish shared secret keys
- Lifetime - 24 hours default - don't have to match
- Encryption

IKE Phase 1 can be established via 

- main mode(6 messages)  
- aggressive mode(3 messages) 

**Workflow**
  
`HAGEL > DH exchange > Authentication ` 
  
**IKE identity**

- If you do not configure a local-identity, the device uses the IPv4 or IPv6 address corresponding to the local endpoint by default
- It can be: distinguished-name, hostname, ip-address, e-mail-address, key-id
- Configurated on most devices, maybe none, on every device we configure both local and remote ID - on Palo Alto it is configured in IKE gateway
- It must match the peer’s expectations

**Main Mode**

- At the cost of three extra messages, Main Mode provides identity protection, enabling the peers to hide their actual identities from potential attackers. This means that the peers’ identities are never exchanged unencrypted in the course of the IKE negotiation
- In main mode, the initiator and recipient send three two-way exchanges (six messages total) to accomplish the following services:
- First exchange (messages 1 and 2) — Proposes and accepts the encryption and authentication algorithms.
- Second exchange (messages 3 and 4) — Executes a DH exchange, and the initiator and recipient each provide a pseudorandom number
- Third exchange (messages 5 and 6) — Sends and verifies the identities of the initiator and recipient
- The information transmitted in the third exchange of messages is protected by the encryption algorithm established in the first two exchanges. Thus, the participants’ identities are encrypted and therefore not transmitted “in the clear.”

Message one example

```
Internet Security Association and Key Management Protocol (ISAKMP)
    Initiator SPI:  a1b2c3d4e5f60708
    Responder SPI:  0000000000000000
    Next payload:   Security Association (SA)
    Version:        1.0
    Exchange type:  Identity Protection (Main Mode) (5)
    Flags:          0x00  (no encryption)
    Message ID:     00000000
    Length:         216  (example)

Payload: Security Association (SA)
    DOI:    IPsec (1)
    Situation: Identity Only (1)
    Proposal:
        Proposal #1
        Protocol ID: ISAKMP (1)
        SPI Size: 0
        # of Transforms: 4
        Transform #1: Encryption Algorithm
            Type:   ENCR
            ID:     AES-CBC
        Transform #2: Hash Algorithm
            Type:   HASH
            ID:     SHA1
        Transform #3: Authentication Method
            Type:   AUTH
            ID:     Pre-shared Key (PSK)
        Transform #4: Diffie-Hellman Group
            Type:   GROUP_DESC
            ID:     Group 2 (MODP-1024)
```

**Aggressive mode**

In aggressive mode, the initiator and recipient accomplish the same objectives as with main mode, but in only two exchanges, with a total of three messages:
- First message — The initiator proposes the security association (SA), initiates a DH exchange, and sends a pseudorandom number and its IKE identity. When configuring aggressive mode with multiple proposals for Phase 1 negotiations, use the same DH group in all proposals because the DH group cannot be negotiated. Up to four proposals can be configured. Message one contains everything that was in messages 1,3,5 in Main mode.
- Second message — The recipient accepts the SA; authenticates the initiator; and sends a pseudorandom number, its IKE identity, and, if using certificates, the recipient's certificate. It contains the same as messages 2,4,6 in Main mode
- Third message — The initiator authenticates the recipient, confirms the exchange, and, if using certificates, sends the initiator's certificate
- Because the participants’ identities are exchanged in the clear (in the first two messages), aggressive mode does not provide identity protection
- Main and aggressive modes applies only to IKEv1 protocol. IKEv2 protocol does not negotiate using main and aggressive modes

### Phase 2

Phase 2 has 3 packets only:

```
Initiator → Responder : SA, Nonce, traffic selectors, key exchange - optional]
Responder → Initiator : SA, Nonce, key exchange - optional]
Initiator → Responder : HASH (ack)
```

Example of first packet

```
ISAKMP Header (HDR*)
 ├─ Initiator Cookie: 0xA1B2C3D4E5F60708
 ├─ Responder Cookie: 0x1122334455667788
 ├─ Next Payload: HASH (0x08)
 ├─ Version: 1.0
 ├─ Exchange Type: Quick Mode (32)
 ├─ Flags: Encrypted
 ├─ Message ID: 0x00001234
 └─ Length: 240 bytes

Encrypted Payloads (inside IKE SA):

1. HASH(1)
 └─ Integrity hash computed using Phase 1 keys
    (covers SA, Ni, KE, IDci, IDcr)

2. SA Payload (Security Association)
 ├─ Proposal #1
 │    ├─ Protocol ID: ESP (50)
 │    ├─ SPI Size: 4
 │    ├─ SPI Value (initiator): 0x3F2A1B4C
 │    ├─ Transform #1: Encryption
 │    │     • AES-CBC-256
 │    │     • Key Length: 256 bits
 │    ├─ Transform #2: Integrity
 │    │     • HMAC-SHA1-96
 │    ├─ Transform #3: Lifetime
 │    │     • 3600 seconds
 │    └─ Transform #4 (optional, PFS requested)
 │          • DH Group: 14

3. Ni (Nonce - Initiator)
 └─ Value: 0x8F3D4A9C12BEEF556677889900112233

4. KE (optional - DH for PFS)
 └─ DH Public Value (DH Group 14)
    • Example: 0xB7E3A2F9C4D1...

5. IDci (Identification - Initiator / Local Proxy-ID)
 ├─ Type: IPv4_ADDR_SUBNET
 ├─ Protocol: 0 (any)
 ├─ Port: 0 (any)
 ├─ Address: 10.0.0.0
 └─ Subnet Mask: 255.255.255.0

6. IDcr (Identification - Responder / Remote Proxy-ID)
 ├─ Type: IPv4_ADDR_SUBNET
 ├─ Protocol: 0 (any)
 ├─ Port: 0 (any)
 ├─ Address: 192.168.1.0
 └─ Subnet Mask: 255.255.255.0

7. Optional Payloads
 ├─ NAT-D detection (if NAT present)
 └─ Vendor ID (if implementation-specific)
```

**SA**

- SA is a set of IPSec specifications that are negotiated between devices that are establishing an IPSec relationship
- SA can be either unidirectional or bidirectional, depending on the choices made by the network administrator
- SA is uniquely identified by a Security Parameter Index (SPI), an IPv4 or IPv6 destination address, and a security protocol (AH or ESP) identifier 
- Each SA payload contains one or more Proposals
- Each Proposal has:
    - Protocol ID (ESP = 50, AH = 51)
    - SPI Size (usually 4 bytes)
    - SPI Value (the actual 32-bit number)
    - Transform set (encryption, auth, lifetime)
- Outbound and inbound SAs are different
- `Both SAs (inbound and outbound) use the same crypto parameters, negotiated during Phase 2`
- `But the keys are different for each direction`
- `Each SA has its own SPI`
- We need multiple IPsec SAs between two peers because each SA is one-directional and tied to a specific set of crypto parameters
- Any time direction, keying material, protocol, or traffic selectors differ → a separate SA is required
- There are two types of SAs: manual and dynamic 

**Manual SA**

- Manual SAs require no negotiation; all values, including the keys, are static and specified in the configuration
- If you configure static/manual IPsec SAs, you do not need (and cannot use) IKE
- All parameters are manually configured on both sides:
    - SPI (Security Parameter Index)
    - Encryption & authentication algorithms
    - Keys
    - Peer IPs
    - Lifetimes (if any)
- There is no key negotiation, rekeying, or authentication exchange
- Used only in test setups or simple, static environments
- Drawback: keys must be changed manually — no automatic refresh → insecure and unscalable 

**Dynamic SA**

- Dynamic SAs require additional configuration. With dynamic SAs, you configure IKE first and then the SA. IKE creates dynamic security associations; it negotiates SAs for IPsec
- The IKE configuration defines the algorithms and keys used to establish the secure IKE connection with the peer security gateway
- This connection is then used to dynamically agree upon keys and other data used by the dynamic IPsec SA. The IKE SA is negotiated first and then used to protect the negotiations that determine the dynamic IPsec SAs

**Transform set**

- They are used only in Phase 2
- A transform set is a combination of one or more transforms used to build an IPsec Security Association (SA) during Phase 2 (Quick Mode / Child SA) negotiation
- Each transform describes one specific aspect of how IPsec protects the traffic
- Transform types:
    - Encryption Algorithm (ENCR) - AES-CBC, AES-GCM, 3DES, ChaCha20-Poly1305
    - Pseudo-Random Function (PRF) - In IKEv1, PRF is not a separate transform — it’s implicit in Phase 1 - PRF-HMAC-SHA1, PRF-HMAC-SHA256
    - Integrity / Authentication Algorithm (INTEG) - HMAC-SHA1, HMAC-SHA256, AES-XCBC
    - Diffie-Hellman Group (D-H Group) - Defines key exchange strength (PFS in Phase 2) - MODP-2048 (Group 14), ECP-256 (Group 19)
- ESP transform set includes encryption + integrity
- AH - integrity only  

**Traffic Selectors**

- Proxy-IDs or traffic selectors: local networks, remote network, protocol, port - they should match on both sides
- They are sent separatly outside the SA
- Some vendors allow “any-to-any” traffic without strict traffic selectors, meaning the SA could match all traffic between the peers’ IPs
- For route based VPN TS are set to 0.0.0.0

**SPI**

- Each peer generates its own SPI and sends to peer
- So after Phase 2 completes, each side knows two SPIs: one for inbound traffic, one for outbound traffic
- The SPI is never reused between peers
- It uniquely identifies the IPsec SA in the device’s Security Association Database (SAD)
- The ESP header in data packets uses the SPI as the first field to indicate which SA/key to use
- SPI is the lookup key: Incoming ESP/AH packets contain SPI → device looks it up in the SAD
- SPI in an ESP header is not encrypted
- The SAD is a per-device table that stores all active Security Associations (SAs). Each SA represents a unidirectional IPsec tunnel (or flow) with all the parameters needed to process packets
- Inbound SA: How to decrypt and authenticate packets arriving at the device
- Outbound SA: How to encrypt and authenticate packets leaving the device
- `Outbound SPI` - The SPI my router inserts into ESP packets I send
- `Inbound SPI` - The SPI my router expects to see in ESP packets I receive
- Every active SA has an entry in the SAD
- Their SPIs appear ONLY inside ESP/AH packets, not in IKE messages
- IKE messages use their own SPIs for phase 1

Example of SAD entry: includes traffic selectors

```
Router# show crypto ipsec sa

interface: GigabitEthernet0/0
    Crypto map tag: VPN-MAP, local addr 203.0.113.10

   protected vrf: (none)
   local ident (addr/mask/prot/port): (10.1.0.0/255.255.255.0/0/0)
   remote ident (addr/mask/prot/port): (10.2.0.0/255.255.255.0/0/0)

   #pkts encaps:  12345, #pkts encrypt: 12345, #pkts digest: 12345
   #pkts decaps:  12010, #pkts decrypt: 12010, #pkts verify: 12010

   inbound esp sas:
      spi: 0x32A1B44C(850000964)
        transform: esp-aes esp-sha-hmac ,
        in use settings ={Tunnel, }
        conn id: 1011, flow_id: SW:11, crypto map: VPN-MAP
        sa timing: remaining key lifetime (k/sec): (4294967295/2460)
        replay detection support: Y
        Status: ACTIVE

   outbound esp sas:
      spi: 0xA4BB9923(2769075235)
        transform: esp-aes esp-sha-hmac ,
        in use settings ={Tunnel, }
        conn id: 1012, flow_id: SW:12, crypto map: VPN-MAP
        sa timing: remaining key lifetime (k/sec): (4294967295/2460)
        replay detection support: Y
        Status: ACTIVE
```

**Data flow in practice**

- Router receives an ESP packet
- Reads SPI from the ESP header
- Looks up SAD to find:
    - Encryption key
    - Integrity key
    - Mode, lifetime, etc.
- Verifies ICV (if authentication is used).
- Decrypts payload only using the key.

Negotiated options list

- Protocol: ESP or AH
- Mode: Tunnel or Transport
- Encryption transform: AES-CBC-256 -If AEAD (e.g., AES-GCM) was chosen in the encryption transform, separate integrity transform is not needed
- Integrity transform: HMAC-SHA1-96
- Lifetime: 3600 seconds and 4608000 kilobytes
- PFS: group 14 (if requested)
- Traffic Selectors(Proxy ID): 10.0.0.0/24 <-> 192.168.0.0/24 (proto any)
- Responder SPI (e.g. 0x3f2a1b4c) and Initiator SPI (e.g. 0x9a7e6c2d) — assigned by peers
- ESN: enabled (if negotiated / supported)

Concepts


- There is only one mode - quick in Phase 2, 3 packets
- By default, Phase 2 keys are derived from the session key created in Phase 1. Perfect Forward Secrecy (PFS)
forces a new Diffie-Hellman exchange when the tunnel starts and whenever the Phase 2 keylife expires, causing
a new key to be generated each time. This exchange ensures that the keys created in Phase 2 are unrelated to
the Phase 1 keys or any other keys generated automatically in Phase 2
- Keylife - When the Phase 2 key expires, a new key is generated without interrupting service
- Phase 2 (Quick Mode) packets are sent inside that encrypted IKE SA
- In your packet capture you will still see UDP 500 (or UDP 4500 if NAT-T) packets
- But their payloads are encrypted — they look like random binary blobs
- You can no longer see SA proposals, proxy-IDs, algorithms, etc

To confirm Phase 2 happened, look for:

- Three small encrypted IKEv1 packets right after Phase 1
- ESP traffic starting immediately after them
- UDP/500 or 4500

### Xauth - Extended Authentication - replaced by IKEv2

- XAuth (Extended Authentication) is an optional extra authentication step used only with IKEv1, mainly to authenticate individual users (not just devices)
- XAuth is an extension to IKEv1 Phase 1, and it happens after Phase 1 but before Phase 2
- Standard IKEv1 Phase 1 authenticates devices or gateways (via PSK or certificates)
- XAuth adds a user-level authentication step — typically username and password
- Peers complete Phase 1 (Main Mode) → a secure channel (IKE SA) is established
- The responder (gateway) requests XAuth credentials from the initiator
- The initiator (client) provides username and password
- The gateway validates them (e.g., against local DB, RADIUS, LDAP, etc.)
- If successful → proceed to Phase 2 (Quick Mode) to negotiate IPsec SAs
- IKEv2 replaced XAuth with EAP (Extensible Authentication Protocol) for user-level auth

### Mode-Config Phase

- Assign IP, DNS, WINS, Split tunnel
- Happens after XAuth
- Not used in IKEv2
- In IKEv2 it is called Configuration Payloads (CP) inside the IKE_AUTH exchange

## NAT-T

```
+----------------+-----------+-------------+------------+------------------------+---------+-------------+----------+
|  New IP header | UDP header| NAT-T header| ESP header |Original Inner IP Header| IP Data | ESP trailer | ESP auth |
|    20 bytes    |  8 bytes  |   4 bytes   |  8 bytes   |                        |         |   2 bytes   | 12 bytes |
+----------------+-----------+-------------+------------+------------------------+---------+-------------+----------+
```

- ESP breaks when NAT is present
- ESP Tunnel Mode does not include the outer IP header in its Integrity Check Value (ICV)
- ESP Tunnel Mode protects: ESP header, Inner IP header, Payload, `It does NOT include the outer IP header`
- So if NAT changes the outer source/destination IP, `the ICV is not affected`
- `NAT cannot translate ESP because ESP has no ports` - NAT cannot track the flow
- `NAT breaks IPsec because IPsec expects stable src/dst IPs` - Even if ESP ICV survives, the security association itself is bound to a pair of IP addresses
- When NAT-T is enabled, `only SPI` is used for SA lookup
- Without NAT-T `SPI + IPs` are used for SA lookup
- UDP port 4500
- Total overhead - 54 bytes!
- Peers detect NAT-Traversal (NAT-T) automatically using a built-in mechanism in IKE phase 1 (IKEv1 Main Mode or IKEv2 IKE_SA_INIT)
- Each peer sends two special hashes: HASH(Original Source IP, Source Port), HASH(Original Destination IP, Destination Port)
- Each peer receives the other’s NAT-D payloads and compares them to what the packet actually arrived with
- The hashes match → no NAT
- By enabling this option, IPSec traffic can pass through a NAT device
- If the peers detect NAT in the path, they switch to: UDP/4500 for IKE, ESP-in-UDP/4500 for data
- Both peers must explicitly signal support for NAT-Traversal during Phase 1

The steps are:

- Announce NAT-T support
- Exchange NAT-D hashes
- Detect NAT (if hashes mismatch)
- Switch to UDP/4500

If only ONE peer supports NAT-T

- NAT-T = disabled
- Traffic stays UDP/500 + ESP
- Tunnel will fail if a real NAT is present

## IKEv2

- Supports EAP
- Anti-DDOS
- Fewer messages to establish IKE and IPSEC SAs: 4, instead of 6 or 9 in IKEv1
- IKEv2 removed ISAKMP entirely and defined its own message format
- Consist of request/response  pairs, called exchages: IKE_SA_INIT, IKE_AUTH, 
- In IKEv2 there is no Main Mode or Aggressive Mode
- Total: 4 messages if no EAP. More if EAP
- IKEv2 has:
    - IKE SPI (for both IKE_SA_INIT and IKE_AUTH)
    - ESP/AH SPI for CHILD_SA (used only in ESP/AH traffic)
- IKEv2 does not have phase 2
- One child Ipsec SA is created by default in IKE_AUTH message
- If you need additional Child SA - 2 more messages - request and response
- Functionally, Phase 2 in IKEv1 (Quick Mode) and IKEv2 (Child SA) both negotiate ESP/AH SAs, keys, lifetimes, and traffic selectors, optionally with PFS
- IKEv2 merges and simplifies the process, reduces message count, enforces explicit traffic selectors, and has cleaner rekey/Child SA creation flows
- Traffic selectors are Mandatory: you must specify the exact local and remote subnets or hosts that this Child SA will cover
- Workarounds for “any-to-any” for route based VPN: Cover all relevant subnets with broad TS + Use the VTI to route all traffic through a single IPsec SA
- IKEv2 replaced XAuth with EAP (Extensible Authentication Protocol) for user-level auth - carried inside IKE_AUTH
- In IKEv2 Mode-Config phase is called Configuration Payloads (CP) inside the IKE_AUTH exchange
- Next generation encryption support: AES-GCM, ECDH, etc...
- Assymetric authentication: one cert and other password

In a Nutshell - 4 mandatory messages only

```
Initiator > IKE_SA_INIT > Responder
Responder > IKE_SA_INIT reply > Initiator - IKE SA done
Initiator > IKE_AUTH > Responder - Encrypted - possible Configuration Payloads (CP)
Responder > IKE_AUTH reply > Initiator - IPSEC SA done - possible Configuration Payloads (CP)
EAP packets - Optional - carried inside IKE_AUTH
Initiator > CREATE_CHILD_SA > Responder - Optional
Responder > CREATE_CHILD_SA > Initiator - Optional
```

- Initiator sends IKE_SA_INIT packet: it contains Security assosiations wuth proposals: Encryption, Integrity, DH group + Key Exchange + Nonce + Initiator SPI

```
Internet Key Exchange Version 2
  Initiator SPI:  a1b2c3d4e5f60708
  Responder SPI:  0000000000000000
  Next payload:   SA
  Exchange type:  IKE_SA_INIT (34)
  Flags:          Initiator

  Payload: Security Association
    Proposal #1: ESP + IKE transforms
      Encryption: AES-CBC-256
      Integrity : SHA256
      DH group  : 14 (2048-bit MODP)
  Payload: Key Exchange
    DH Group: 14
    KEi: <256 bytes of DH>
  Payload: Nonce (Ni)
    Ni: <random 32 bytes>
```

- Responder sends  IKE_SA_INIT packet as well: chosen proposal, DH public part, Nonce, Cookie if AntiDDoS is used + Initiator, Responder SPI

```
Internet Key Exchange Version 2
  Initiator SPI:  a1b2c3d4e5f60708
  Responder SPI:  1122334455667788
  Next payload:   SA
  Exchange type:  IKE_SA_INIT (34)
  Flags:          Response

  Payload: Security Association
    Selected Proposal:
      Encryption: AES-CBC-256
      Integrity : SHA256
      DH group  : 14

  Payload: Key Exchange
    KEr: <256 bytes of DH>
  Payload: Nonce (Nr)
    Nr: <random 32 bytes>

  OPTIONAL:
  Payload: Cookie (if DoS-protection active)
```

- Initiator sends IKE_AUTH - Encrypted! - ID, SPIs, Auth type, ESP proposal(to create IPSEC SA, the same what is done in Phase 2 in IKEv1), traffic selectors

```
Internet Key Exchange Version 2
  Initiator SPI:  a1b2c3d4e5f60708
  Responder SPI:  1122334455667788
  Next payload:   Encrypted
  Exchange type:  IKE_AUTH (35)
  Flags:          Initiator, Encrypted

  Encrypted payload contents:
    IDi             → "CN=vpn-client.example.com"
    AUTH            → HMAC or RSA signature
    SA (for CHILD_SA)
      ESP proposal (AES-GCM-128, no integrity)
    TSi             → 192.168.10.0/24
    TSr             → 10.10.10.0/24
```

- Responder sends sends IKE_AUTH - Encrypted! - SPIs, ID, Auth, ESP proposal accepted, traffic selectors

## ESP

- Separate IP protocol for Data Plane
- Confidentiality, authentication, replay protection
- IP protocol number 50
- Supports encryption and NAT-T
- ESP mode: tunnel or transport mode
- Transport mode - adds ESP header after original IP header + ESP trailer + ESP auth
- Transport mode is practically never used, only when 2 firewalls communicate only with each other
- Tunnel mode - encrypts the entire original packet - adds a new set of IP headers
- Required parametres for Tunnel mode:
    - Symmetric cipher
    - Hash
    - DH group
    - Lifetime

<img width="1151" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/dd8e9064-7dde-478f-906f-48ef43077b04">

## Authentication Header

- Separate protocol above IP with encapsulation for data plane
- Data Integrity, Authentication, Protection from replays
- IP 51
- Does not support encryption
- Does not support NAT-T
- Transorm set for authentication header defines only HMAC function, for example `ah-sha-hmac`

## Configuration - Cisco

`Tunnel` (vrf, bandwidth, ip, mss, mtu, load interval, bfd, source, mode, path mtu discovery, destination, **ipsec profile**) > `ipsec profile` (idle, **transform-set**, pfs group, **ike-v2-profile**) > `ike-v2-profile` (identity, authentication, **keyring**, lifetime, dpd), `transform set`(encryption, hash, mode) > `keyring` (address, key)  
  
`ike-v2-policy` (vrf, **proposals**) > `proposal` (encryption, hash, pfs group)

### Tunnel

```
interface Tunnel12
 description Tunnel
 bandwidth 2000000
 bandwidth qos-reference 1000000
 vrf forwarding IPSEC
 ip address 10.16.6.37 255.255.255.252
 no ip redirects
 ip mtu 1400
 ip tcp adjust-mss 1360
 load-interval 30
 shutdown
 bfd interval 500 min_rx 500 multiplier 3
 tunnel source Port-channel1.440
 tunnel mode ipsec ipv4
 tunnel destination 11.11.11.11
 tunnel path-mtu-discovery
 tunnel vrf corp
 tunnel protection ipsec profile Corp-profile
end
```

### IPSec Profile

```
crypto ipsec profile IPSEC-profile
 set security-association idle-time 3600
 set transform-set IPSEC 
 set pfs group1
 set ikev2-profile CorpIPSEC-Prisma-ikev2-profile
```

### Transform set

Phase 2 options

```
crypto ipsec transform-set IPSEC esp-aes 256 esp-sha256-hmac 
 mode tunnel
```

### IKE v2 Profile

Phase 1 options

```
crypto ikev2 profile IPSEC-profile
 match identity remote any
 authentication remote pre-share
 authentication local pre-share
 keyring local CorpIPSEC-vpn-keyring
 lifetime 28800
 dpd 10 3 periodic
```

### Keyring

```
crypto ikev2 keyring CorpIPSEC-vpn-keyring
 peer Corp_Tunnel12
  address 34.11.11.11
  pre-shared-key CY5R2TugteXEGBv6
```

### IKE-v2 Policy

```
crypto ikev2 policy remote-ikev2-policy 
 match fvrf corpInternet
 match fvrf wan_underlay
 proposal remote-ikev2-proposal
 proposal 3rdParty-ikev2-proposal
 proposal 3rdParty-ikev2-Sha256-proposal
 proposal CorpIPSEC-ikev2-proposal
 proposal oci_ikev2-proposal
```

### IKE Proposal

Phase 1 options

```
crypto ikev2 proposal CorpIPSEC-ikev2-proposal 
 encryption aes-cbc-256 aes-cbc-128
 integrity sha512 sha384 sha256
 group 19 14 5 2
```

## Troubleshooting

**Show status of all Tunnel interfaces**

```
router#show ip int br
Interface              IP-Address      OK? Method Status                Protocol

Tunnel0                10.125.6.1      YES NVRAM  up                    up      
Tunnel1                10.125.6.5      YES NVRAM  up                    up      
Tunnel3                unassigned      YES unset  administratively down down    
Tunnel4                10.125.6.9      YES NVRAM  up                    down    
Tunnel5                10.125.6.13     YES NVRAM  up                    down    
```

**Flapping tunnels on Cisco**

```
Router#show logging | inc changed
20995065: Feb 13 2024 00:59:36.794 EST: %LINK-3-UPDOWN: Interface TenGigabitEthernet0/1/0, changed state to down
20995067: Feb 13 2024 00:59:37.794 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface TenGigabitEthernet0/1/0, changed state to down
20995068: Feb 13 2024 00:59:36.794 EST: %LINK-3-UPDOWN: SIP0/1: Interface TenGigabitEthernet0/1/0, changed state to down
20995078: Feb 13 2024 00:59:58.197 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel1, changed state to down
20995079: Feb 13 2024 00:59:58.845 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel102, changed state to down
20995084: Feb 13 2024 01:00:00.167 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel0, changed state to down
20995085: Feb 13 2024 01:00:00.787 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel16, changed state to down
20995086: Feb 13 2024 01:00:01.385 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel11, changed state to down
20995087: Feb 13 2024 01:00:01.765 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel12, changed state to down
20995088: Feb 13 2024 01:00:02.035 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel15, changed state to down
20995111: Feb 13 2024 01:01:35.759 EST: %LINEPROTO-5-UPDOWN: Line protocol on Interface Tunnel102, changed state to up
```
## Debug

```
Debug crypto condition peer ipv4 140.238.149.242
Debug crypto ikev2
Debug crypto ipsec
```

## IPSec VPN solutions

- Site-to-site - Multivendor
- DMVPN - Cisco
- GET-VPN - Cisco
- FlexVPN - Cisco
- Remote Access VPN


