# IPSec

### IKE

- Peer IP
- Proxy IDs Local and Remote if required by one of the sides
- IKE version
- DH group
- Hash
- Symmetric cipher
- Lifetime
- Auth type: pre shared key or certificate
- Preshared key

### IPSec

- IPSec protocol: ESP or AH
- ESP mode: tunnel or transport mode
- Symmetric cipher
- Hash
- DH group
- Lifetime

## Concepts

- IPsec is not a protocol, it's a framework for securing unicast traffic
- It consists of 3 protocols:
    - ESP 
    - AH(obsolete)
    - IKE
- For negotiations(IKE) UDP port 500 is used. 
- Encapsulating Security Payload uses IP protocol 50
- Authentication Header uses IP protocol 51.  
- IKE - set of protocols to exchange keys
- ISAKMP -  protocol to manage keys - responsible for Security Associations
- IPSec uses both of them
- ISAKMP is part of IKE. IKE comprises the three following protocols:
    - ISAKMP
    - SKEME
    - OAKLEY
- Does not support multicast and broadcast, OSPF, EIGRP cannot be used, GRE inside IPSec solves the problem
- IKE Phase 1 + IKE Phase 2 - 2 tunnels
- Tunnel 1 is used to negotiate parametres for tunnel 2, tunnel 1 is used only for communication between firewalls, then for actual data only tunnel 2 is used directly, they work in paralell
- Is there any IKE traffic, when everything is established and data flows normally?
- Security Associations are negotiated for both tunnels

## SA

An SA is a set of IPSec specifications that are negotiated between devices that are establishing an IPSec relationship.  
An SA can be either unidirectional or bidirectional, depending on the choices made by the network administrator. An SA is uniquely identified by a Security Parameter Index (SPI), an IPv4 or IPv6 destination address, and a security protocol (AH or ESP) identifier.  
There are two types of SAs: manual and dynamic.  
Manual SAs require no negotiation; all values, including the keys, are static and specified in the configuration. Manual SAs statically define the Security Parameter Index (SPI) values, algorithms, and keys to be used, and require matching configurations on both ends of the tunnel. Each peer must have the same configured options for communication to take place.  
Dynamic SAs require additional configuration. With dynamic SAs, you configure IKE first and then the SA. IKE creates dynamic security associations; it negotiates SAs for IPsec. The IKE configuration defines the algorithms and keys used to establish the secure IKE connection with the peer security gateway. This connection is then used to dynamically agree upon keys and other data used by the dynamic IPsec SA. The IKE SA is negotiated first and then used to protect the negotiations that determine the dynamic IPsec SAs.

## IKEv1

IKE does the following:

- Negotiates and manages IKE and IPsec parameters
- Authenticates secure key exchange
- Provides mutual peer authentication by means of shared secrets (not passwords) and public keys
- Provides identity protection (in main mode)

### Phase 1 - ISAKMP protocol

- During traffic capture you cannot see Phase 2 negotiation, only Phase 1 as ISAKMP protocol, everything else is encrypted
- In ISAKMP you can see mode: main or aggressive
- Suggested encryption parametres
- Key exchange

IKE Phase 1 can be established via 

- main mode(6 messages)  
- aggressive mode(3 messages)

During this phase peers authenticate each other, using pre-shared keys(PSK) or RSA signatures(PKI)  
  
Negotiations:

- Hashing - md5 or sha
- Authentication - PSK or certificates
- Group - Diffie Helman group - algorithm which is used to establish shared secret keys
- Lifetime
- Encryption

Phase 1 establishes an ISAKMP(Internet Security Association and Key Management Protocol) SA, which is a secure channel through which the IPsec SA negotiation can take place.  
Next step in Phase 1 is to run Diffie Hellman and to establish secret keys And the next step is to authenticate each other  
  
HAGEL > DH exchange > Authentication  
  
And only after this IKE Phase 1 is established, it is used only for communications between firewalls themselves.  

A Diffie-Hellman (DH) exchange allows participants to produce a shared secret value. The strength of the technique is that it allows participants to create the secret value over an unsecured medium without passing the secret value through the wire. The size of the prime modulus used in each group's calculation differs as follows:
- DH Group 1 — 768-bit modulus
- DH Group 2 — 1024-bit modulus
- DH Group 5 — 1536-bit modulus
- DH Group 14 — 2048-bit modulus
- DH Group 19 — 256-bit modulus elliptic curve
- DH Group 20 — 384-bit modulus elliptic curve
- DH Group 24 — 2048-bit modulus with 256-bit prime order subgroup

We do not recommend the use of DH groups 1, 2, and 5.  
Because the modulus for each DH group is a different size, the participants must agree to use the same group

#### IKE identity

- If you do not configure a local-identity, the device uses the IPv4 or IPv6 address corresponding to the local endpoint by default
- It can be: distinguished-name, hostname, ip-address, e-mail-address, key-id
- Configurated on most devices, maybe none, on every device we configure both local and remote ID - on Palo Alto it is configured in IKE gateway

#### Main Mode

At the cost of three extra messages, Main Mode provides identity protection, enabling the peers to hide their actual identities from potential attackers. This means that the peers’ identities are never exchanged unencrypted in the course of the IKE negotiation.  
In main mode, the initiator and recipient send three two-way exchanges (six messages total) to accomplish the following services:
- First exchange (messages 1 and 2)—Proposes and accepts the encryption and authentication algorithms.
- Second exchange (messages 3 and 4)—Executes a DH exchange, and the initiator and recipient each provide a pseudorandom number.
- Third exchange (messages 5 and 6)—Sends and verifies the identities of the initiator and recipient.
The information transmitted in the third exchange of messages is protected by the encryption algorithm established in the first two exchanges. Thus, the participants’ identities are encrypted and therefore not transmitted “in the clear.”

#### Aggressive mode

### IKE Phase 1

- To build a tunnel 4 parametres are needed: Authentication, key exchange, encryption, MAC: PSK/DH2/A128/SHA1 + mode for IKEv1: main or aggressive + lifetime


### IKE Phase 2

- Messages include Proxy-IDs: local networks, remote network, protocol, name - they should match on both sides
- To build a tunnel 3 parametres are needed: Protocol (ESP/AH), encryption, MAC: ESP/A128/SHA1 + lifetime

### Xauth - Extended Authentication within IKE

https://datatracker.ietf.org/doc/html/draft-beaulieu-ike-xauth-02

## IKEv2

## ESP

- Transport mode
- Tunnel mode

<img width="1151" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/dd8e9064-7dde-478f-906f-48ef43077b04">

### Transport mode

- Transport mode is practically never used, only when 2 firewalls communicate only with each other


## AH

## Configuration

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