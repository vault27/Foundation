# Campus

## Physical topology

- 3 tiers: Access, Distribution, Core
- 2 Tiers: Access, Core

## Design options

- STP + FHRP
- VSS + LAG
- Pure Etherchannel everywhere: between core routers inside pair, between core routers and distribution routers, between nodes in a pair of distribution routers, between distribution switches and access switches

## STP + HSRP

- Every access switch is connected to 2 Core cwitches
- 2 Core switches are connected between each other with LAG
- HSRP is configured on both Core switches
- Primary Core switch is root
- STP saves from failure of any link between Access switches and Core Switches, and between 2 Core switches
- HSRP saves from failure of Core Switch on layer 3

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
