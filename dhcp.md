# DHCP

- Server - UDP port 68
- Client - UDP port 67
- Client with Static IP can use DHCP as well - to get all other information
- If server cannot reply on Discover - it sends nothing
- Client may renew address from another DHCP server
- To renew address REQUEST message is sent

  
## DHCP options

## DHCP message types

## Timers

## States

- INIT
- SELECTING
- BOUND

## Message flow

4 steps process  
DORA - Discover > Offer > Request > Acknowledge  
If client gets many offers - it will use the first one

- Client INIT state
- Client sends Discover message
    - MAC dst: ff:ff:ff:ff:ff
    - IP src: 0.0.0.0
    - IP dst: 255.255.255.255
    - Client IP address: 0.0.0.0
    - Relay IP: 0.0.0.0
    - Client MAC address
    - Option 53 - Message type Discovery
- Server sends reply
    - Dst MAC of client
    - Src MAC of server
    - IP src of server
    - IP dst 255.255.255.255
    - Client IP: offered IP
    - - Option 53 - Message type Offer

## Relay

- Adds Relay Agent IP address to the request - this is the address of router on network side, from which DHCP request arrived
