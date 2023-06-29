# IPSec

- Does not support multicast and broadcast, OSPF, EIGRP caanot be used, GRE inside IPSec solves the problem


## IKEv1

### Phase 1 - ISAKMP protocol

- During traffic capture you cannot see Phase 2 negotiation, only Phase 1 as ISAKMP protocol, everything else is encrypted
- In ISAKMP you mode: main or aggressive
- Suggested encryption parametres
- Key exchange

### IKE Phase 2

- Messages include Proxy-IDs: local networks, remote network, protocol, name - they should match on both sides

### Xauth - Extended Authentication within IKE

https://datatracker.ietf.org/doc/html/draft-beaulieu-ike-xauth-02

## IKEv2

## ESP

## AH