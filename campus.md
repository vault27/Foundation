# Campus

## Physical topology

- 3 tiers: Access, Distribution, Core
- 2 Tiers: Access, Core

## Design options

- STP + FHRP
- VSS + LAG
- Pure Etherchannel everywhere: between core routers inside pair, between core routers and distribution routers, between nodes in a pair of distribution routers, between distribution switches and access switches

## STP + HSRP

- Every access switch is connected to 2 Core switches with LAG
- 2 Core switches are connected between each other with LAG - Layer 2 link - if there is no such link, then if link between access switch and core-1 is broken, client will not be able to reach core-1 where virtual IP is located. Client will loose all connections to external networks. And if this links exists, client will be able to reach Core-1 via Core-2. Only Core-1 replies to arp for virtual HSRP IP until core-1 is alive
- HSRP is configured on both Core switches for all Vlan interfaces
- Primary Core switch is root, so link from access switch to Core switch 2 is blocked
- STP saves from failure of any link between Access switches and Core Switches, and between 2 Core switches
- HSRP saves from failure of Core Switch on layer 3
- Core switches are independently connected with routing protocols to WAN routers.....

## Access layer

- Modular switch vs fixed switches approach

## Layer 2 demarcation

- Layer 2 Core - routing only on Core level
- Routed Access - L3 starting from Access Switches - BGP is already between Access and Distribution/Core switches
- Routed Distribution - L3 between distribution switches and Core, L2 between distribution and access

## Typical campus

- 16 switches in total
- Every floor has a large access chassis - Catalyst 9410R
- 2 Core switches Catalyst 9500
- Every access switch is connected to 2 Core switches with port channels: total 4 physical links from each Access switch to Core switches, links to core switches are L3 with BGP
- 2 Nexus switches for servers
- Campus is devided into VRFs
- All VRFs are connected to firewall via Core switch
- Firewall sends default route to all VRFs
- All VRFs send to FW all their networks via BGP
- Core switch is connected to each FW with 2 LAG links
- Both LAGs are in the same VLAN, ip address is assigned to VLAN
- Each VRF on core switch has its own VLAN inside LAGs to firewalls
