# ISE

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
