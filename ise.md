# ISE

- Device
- Device groups: locations, types
- Device profiles
- Device admin policy sets
- Shell profiles
- Command sets
- Allowed protocols

## Maitenance

Restart services

```
application stop ise
application start ise
show application status ise
```

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

Work Centers > Device Administration Policy Sets

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

Operations > TACACS > Live Logs

- Each successfull login generates 2 logs: Authentication and Aithorization
- All details are available:
  - Authentication Policy
  - Authorization Policy
  - Shell profile
  - Response attributes
 