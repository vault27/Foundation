# ISE

- Device
- Device groups: locations, types
- Device profiles
- Device admin policy sets
- Shell profiles
- Command sets
- Allowed protocols

## Architecture

- 2 interfaces on a node: one for management, one for requests

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
