# Routing

## Packet processing

## Routing protocols
Link State routing protocol - every router builds a tree or a graph of the whole network. Then launches shortest path algorithm to find out best paths to all destinations. These paths go to a Routing table. Generally some variant of Dijkstra's algorithm is used.  
LPM - Long Prefix Match - network with longest mask will be chosen from routing table. Default route has the shortest prefix and the lowest priority.

## Administrative distances
Route with lowest distance is installed into the routing table  
Can be changed with distance command

- Connected - 0
- Static - 1
- EIGRP summary route - 5
- EBGP - 20
- EIGRP (internal) - 90
- IGRP - 100
- OSPF - 110
- IS-IS - 115
- RIP - 120
- EIGRP (external) - 170
- iBGP - 200
- Unreachable - 255

## Route maps
Mostly used for route redistribution: permit or deny redistribution based on match + changing something in route with set command as a bonus. Plus they are used to generate default route in OSPF, BGP routing policies(in neighbor statement, in export import commands for RT to control exported and imported routes) and in policy routing.
- If/Then/Else logic
- One or more commands
- Processed in sequential order
- match command for matching parametres
- Match all packets - no match command and permit action
- Set command to change parametres
- Name is mandatory
- Action: permit or deny, this is for redistribution: redistribute or not
- Default deny all at the end
- There can be many permit and deny statements in one route map with different match commands
- If route does not match permit rule(ACL for example), it will be considered by next rule, not dropped
- Routes are dropped only when they match deny rule or implied deny all as a last rule in route-map
- Executed from the lowest sequence of number to the highest sequence
- If the match is found in the route map instance, the execution of the other further route map will stop
- If the route map is applied in the policy routing environments, the packets which don't meet a match criteria are forwarded based on a routing table
- If there are multiple match statements in route-rule - they all have to match

**Match commands for route redistribution**
- interface
- ip address - route prefix and length via ACL or prefix list
- next hop
- route source - ACL
- metric
- route type - internal | external | type-1 | type-2 | level-1 | level-2
- tag

**Set commands for redistribution**
- level - level-1 | level-2| level-1-2 | stub-area | backbone
- metric for OSPF, RIP, IS-IS
- metric for EIGRP/IGRP
- metric type - internal | external | type-1 | type-2 - for IS-IS and OSPF
- tag

## IP prefix
- Describes prefix number and its length
- Used by route map, and route map is used by redistribute
- One or more statements with the same name
- Each has a sequence number
- Permit or deny, means if packet should match statement or not
- 

## CEF

## ECMP
Rapidly changing latency, packet reordering and maximum transmission unit (MTU) differences within a network flow, which could disrupt the operation of many Internet protocols, most notably TCP and path MTU discovery. RFC 2992 - load balances based on hash of packet header.

## Load balance
- Same AD and cost - load balance
- The IGRP and EIGRP routing processes also support unequal cost load balancing
- It can be per packet and per destination

## Route map / Prefix map / IP prefix

## FHRP: GLBP/HSRP/VRRP
First hop redundancy protocol (FHRP)
- Hot Standby Router Protocol (HSRP) - Cisco's initial, proprietary standard developed in 1998
- Gateway Load Balancing Protocol (GLBP) is a Cisco proprietary protocol that attempts to overcome the limitations of existing redundant router protocols by adding basic load balancing functionality - round robin. Allows setting priorities and weights. 224.0.0.102 to send hello packets to their peers every 3 seconds over UDP 3222.
- Virtual Router Redundancy Protocol (VRRP) - an open standard protocol

## VRF
- Two routers with 2 VRFs are connected with TRUNK with 2 VLANs with 2 sub interfaces and with the same IPs on subs
- Firewall is connected to switch with TRUNK as well, but IPs are different on subs, because on FW they are in one VRF
- When we configure VRF connection via VRF and use eBGP we have to allow on some routers seeing their own AS number in updates
- For eBGP we use one router instance with one AS number, but different neighboors for each VRF
- On Firewall we configure 2 VLAN interfaces and 2 neighbors, which have the same AS, on Nexus we also need to configure option disable-peer-as-check so it forwards updates from one VRF to another with the same AS
- To configure route leaking between VRFs as a backup path we need to make local route between VRFs less valuable then remote route from firewall. It is done via route map and increasing Local Preference for remote route
- If route is leaked to VRF, we need to consider, that it will be spreaded along all this VRF via IGP

Each VRF:
- An IP routing table (RIB)
- A CEF FIB, populated based on that VRF’s RIB
- A separate instance or process of the routing protocol 

**Ping from VRF on Nexus**
```
ping 192.168.1.1 vrf GOOGLE
```
**Configuration on Nexus**
```
vrf context GOOGLE
interface Ethernet1/3
  no switchport
  vrf member GOOGLE
  ip address 192.168.1.1/24
  no shutdown
router bgp 64701
vrf GOOGLE
    address-family ipv4 unicast
      redistribute direct route-map connected
    neighbor 172.16.1.1
      address-family ipv4 unicast
```

## Route leaking
- It can be configured between two VRFs. With any IGP used. BGP is started locally on one router. For every VRF we configure RD, RT which is use to export routes, RT which are used to import routes (we may import several RTs). Routes go from VRF to global VPNv4 table, and from this table they go to particlar VRF
- After enabling leaking we need to consider that leaked routes will start spreading across VRFs, so we may require to configure route maps with ip prefixes to increase/decrease local preference or weight to control routes priority, we also may need to filter particular routes
- When we configure leaks, we need to consider which exact networks will be leaked, if we leak all routing table, it will be a mess, we control it with a route map via ip prefix list. In BGP route map is attached to neighbor command to set high local preference for example for all routes from this neighbor. Route map is also used to set low local preference and filter which routes to export from particular VRF.

Example of configuration: route leaking via BGP, if firewall is down then leaking routes are active, by default they have low local prefrence and not active. Configured on Nexus 9000. Two VRFs: Google and Nasa. Configuration is for Spine-1.
```
# IP prefixes to filter what export from VRF
ip prefix-list GOOGLE seq 5 permit 192.168.1.0/24
ip prefix-list GOOGLE seq 10 permit 192.168.4.0/24
ip prefix-list NASA seq 5 permit 192.168.2.0/24
ip prefix-list NASA seq 10 permit 192.168.3.0/24

# Route map to set local preference for routes from FW
route-map FW permit 10
  set local-preference 200
  
# Route maps to filter what is exported from VRF and set RT
route-map GOOGLE permit 10
  match ip address prefix-list GOOGLE
  set local-preference 50
  set extcommunity rt 64600:1
route-map NASA permit 10
  match ip address prefix-list NASA
  set local-preference 50
  set extcommunity rt 64600:2

vrf context GOOGLE
  rd 64600:1
  address-family ipv4 unicast
    route-target import 64600:2
    export map GOOGLE
vrf context NASA
  rd 64600:2
  address-family ipv4 unicast
    route-target import 64600:1
    export map NASA
    
interface Ethernet1/1.1
  encapsulation dot1q 2
  vrf member GOOGLE
  ip address 172.16.1.1/31
  no shutdown

interface Ethernet1/1.2
  encapsulation dot1q 3
  vrf member NASA
  ip address 172.16.1.1/31
  no shutdown
  
interface Ethernet1/2.1
  encapsulation dot1q 2
  vrf member GOOGLE
  ip address 172.16.2.1/31
  no shutdown

interface Ethernet1/2.2
  encapsulation dot1q 3
  vrf member NASA
  ip address 172.16.2.1/31
  no shutdown
  
router bgp 64600
  router-id 10.10.1.1 
  vrf GOOGLE
    address-family ipv4 unicast
    neighbor 172.16.1.0
      remote-as 64701
      address-family ipv4 unicast
        allowas-in 1
    neighbor 172.16.2.0
      remote-as 64702
      address-family ipv4 unicast
        allowas-in 1
    neighbor 172.16.3.1
      remote-as 64601
      address-family ipv4 unicast
        allowas-in 3
        route-map FW in
  vrf NASA
    address-family ipv4 unicast
    neighbor 172.16.1.0
      remote-as 64701
      address-family ipv4 unicast
        allowas-in 1
    neighbor 172.16.2.0
      remote-as 64702
      address-family ipv4 unicast
        allowas-in 1
    neighbor 172.16.4.1
      remote-as 64601
      address-family ipv4 unicast
        allowas-in 1
        route-map FW in  
```
![image](https://user-images.githubusercontent.com/116812447/209544910-db2af0ff-7a61-4539-87ba-d2dc2ac26bd0.png)

## Black hole
- Black hole refers to a place in the network where incoming or outgoing traffic is silently discarded (or "dropped"), without informing the source that the data did not reach its intended recipient
- A null route or black hole route is a network route (routing table entry) that goes nowhere. Matching packets are dropped (ignored) rather than forwarded, acting as a kind of very limited firewall
- Null routes are typically configured with a special route flag, but can also be implemented by forwarding packets to an illegal IP address such as 0.0.0.0, or the loopback address
- Null routing has an advantage over classic firewalls since it is available on every potential network router (including all modern operating systems), and adds virtually no performance impact- 
