# MPLS

## History

## RFC

## Terms

## Principles

- MPLS includes frame-mode MPLS and cell-mode MPLS, we use frame    
It is a header between L2 header and IP packet
- It is 32 bits long
- Fast routing based on labels
- L2VPN, L3VPN, MPLS TE: MPLS unicast IP forwarding does not provide any significant advantages by itself
- MPLS considers only the routes in the unicast IP routing table, so the end result of using MPLS is that the packet flows over the same path as it would have if MPLS were not used
- MPLS requires the use of control plane protocols (for example, Open Shortest PathFirst [OSPF] and Label Distribution Protocol [LDP]) to learn labels, correlate those labels to particular destination prefixes, and build the correct forwarding tables
- Three protocols to Exchange labels: LDP, RSVP-TE - used in MPLS TE, it requires IGP supporting TE(OSPF, ISIS), MBGP
- We can use it to carry IPv6 traffic across IPv4 MPLS network
- We can use many labels in one packet
- OSPF is required, MPLS cannot work by it self, it needs a full routing table, based on which it will generate labels
- Service providers use IS-IS or OSPF in a core - it is good for traffic engineering
- Changing the label is called swap
- MPLS headers have their own TTL value - to avoid looping

## Operations overview

### Control plane

### Data plane

- Router generates a label for each route in a routing table
- It sends these labels to other routers via LDP - Label Distribution Protocol
- Then if neighbor router wants to send a packet it uses a label from a router
- When router gets packet it does not look at the Layer 3 at all
- It looks only on a label in layer 2,5 - That is why so fast
- If router gets labels about one route from different routers, it chooses the one to send using again routing table
- Labels are generated randomly or from range every time after reboot or reinitialization
- MPLS labels are assigned only to IGP protocols 
- If a router gets a packet without a label it will prefer LSP over IP path it will inject/push label
- If a router gets a packet with a label for which it does not have info it will drop it
- LDP feeds LIB and best routes go to LFIB
- Note that the LFIB is not a per-VRF table; the LFIB is the one and only
- Every router changes label

## MPLS L2VPN

Connection scheme

```text
CE > PE (ELSR) > P(LSR) > P(LSR) > PE(ELSR) > CE
CE >>>>>>>>>>>>Neighborship>>>>>>>>>>>>>>>>>>>CE
```

- With a Layer 2 MPLS VPN, the MPLS network allows customer edge (CE) routers at different sites to form routing protocol neighborships with one another as if they were Layer 2 adjacent. Therefore, you can think of a Layer 2 MPLS VPN as a logical Layer 2 switch

## MPLS L3VPN

## MPLS TE