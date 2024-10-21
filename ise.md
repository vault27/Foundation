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
- Tacacs settings
  - Shared secret
- SNMP settings - ?
- Trustsec settings

## RADIUS

## 802.1X

## TACACS

### Protocol

### ISE logic

- Device admin policy triggers based on Device Type, Location, Protocol, Username
- Then it enforces a set of rules of Authorization policy
- These rules add additional conditions
- These rules apply Command Sets + Shell Profiles

### Add device for TACACs auth

Administartion > Network Resources > Network Devices

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

Device Administration / Policy Elements / Results / TACACS Profiles

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
