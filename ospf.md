# OSPF
Everything I need to know about OSPF in one place.

## History
Open Shortest Path First  was developed in the late 1980s. Because RIP had issues with scalability, performance, large AS.
Developed by Internet Engineering Task Force (IETF).
The first version of OSPF was described in RFC 1131, published in October 1989. This was quickly replaced by OSPF Version 2 in July 1991, described in RFC 1247. Since then there have been several revisions to the OSPF Version 2 standard, in RFCs 1583, 2178, and 2328, with the last of these the current standard. OSPF Version 2 is the only version in use today, so it is usually what is meant when people (including myself) refer to “OSPF”. RFC is 240 pages! 

## Terms
- LSDB - Link State Database   
- SPF - Shortest Path First  
- LSU - Link State Update - packet which holds LSAs, all types of LSA can be in one packet  
- LSA - Link State Advertisments - they are held in memory in LSDB and are sent via network in LSU and in DB decription
- Area - group of routers and interfaces  
- ABR - Area Border Router - router with interfaces in 2 areas - one of them backbone area 
- ASBR - Autonomous System Border Router - connects OSPF domain with external domains 
- Internal router - all interfaces are in one area  
- DR - Designated Router  
- BDR - BAckup Designated Router  

## Pros
- Router knows all network and builds a tree - no loops
- OSPF is very good for traffic engineering in ISP with MPLS
- Fast convergence
- Simple
- IPv4 and IPv6
- Open protocol
- Easy to configure

## Cons
- Main cons is bad performance when many hosts - high CPU load - several thousand prefixes max - because every router has to calculate a tree

## Concepts
- Open standard
- Which networks are advertised by default???
- IGP routing protocol for IP networks
- Uses link state routing (LSR) algorithm or Shotest Path, uses Dijcstra algorithm
- Operates in one Autonomous System
- OSPF routers have End -to- End Visibility of entire network in form on Topology table
- LSDB is identical on all routers in 1 area
- Administrative distance 110
- Metric is cost, cost is dependent on bandwidth of the link, cost is inversly proportional to the bandwidth, the greater the bandwidth the less the cost, the better the path, cost=Reference bandwidth/100 in Mbps 
- - Loops are impossible inside the area because every router knows all topology. And between areas all areas have to be connected to area 0, so loops are avoided as well like in distance vector
- Complicated > high load
- One area - 500 routers
- Process id can be different
- Metric is based on cumulitive cost of all outgoing interfaces, the lower the mitric the better, it is a price of the route
- Supports VLSM and CIDR
- No hop limit
- All networks are connected via backbone areas to avoid loops
- Hello interval - router sends Hello messages
- Dead timer - after it neighboor is considered dead
- Route tags- tag routes as theay are redistributed into OSPF
- Next-hop field - supports the advertisment of routes with a different next-hop router than the advertising router
- Manual route summarization - summarization is supported on ABR only
- If there is an topology change - router sends LSA, if no changes LSAs are sent every 30 mins
Each router stores the data, composed of individual link-state advertisements (LSA) , in its own copy of the link-state database (LSDB) . Then, the router applies the Shortest Path First (SPF) algorithm to the LSDB to determine the best (lowest-cost) route for each reachable subnet (prefix/length).  

**Three fundamental concepts of link state protocols**
1. Every link state router floods information about itself, its links, and its neighbors to every other router. From this flooded information each router builds an identical link state database. Each router then independently runs a shortest-path-first calculation on its database – a local calculation using distributed information – to derive a shortest-path tree. This tree is a sort of map of the shortest path to every other router.
2. When link state domains grow large, the flooding and the resulting size of the link state database becomes a scaling problem. The problem is remedied by breaking the routing domain into areas: That first concept is modified so that flooding occurs only within the boundaries of an area, and the resulting link state database contains only information from the routers in the area.This, in turn, means that each router’s calculated shortest-path tree only describes the path to other routers within the area.
3. OSPF areas are connected by one or more Area Border Routers (the other main link state protocol, IS-IS, connects areas somewhat differently) which maintain a separate link state database and calculate a separate shortest-path tree for each of their connected areas. So an ABR by definition is a member of two or more areas. It advertises the prefixes it learns in one area to its other areas by flooding Type 3 LSAs into the areas that basically say, “I know how to reach these destinations.”

## Design
We have to think through the following:
- IP networks between routers - /31 is ok
- Loopback interfaces and Router-IDs - loopback is actually not needed if we configure router-id manually, which is recomended. Loopback numbers on all devices.
- Authentication
- Areas
- Network types
- Process ID - it has local significance, it is better to use the same ID on all devices
- Timers, maybe it is better to harden them

## Data centre CLOS specifics
- All routers are in area 0
- In case of super spine: superspine is in backbone, POD is in non backbone, stub area. In this scheme Spine-1 stores everything about area 1 and backbone area  and so load on Spine is BIG!Such scheme is used rarely.OSPF is not recommended for Fabric!!Do not use unnumbered!
- Point to point links between leafs and Spines - /31 networks
- BFD timers: Tx/Rx 100 ms x 3, MicroBFD if we use LAG
- To delete Spine from operation for maintenence we use command max-metric router-lsa
- use ip ospf area instead of network
- Do not use redistribute
- Authentication
- Configure OSPF in GRT, not VRF
- Passive interface default
- Configure RID explicitly

## Configuration and operations overview
- Enable OSPF process with particular ID (number in IOS and word in Nexus) and configure router ID for it, or loopback is used
- Iclude interfaces into OSPF using network command in IOS, we should include interfaces on which we peer and which we want to announce - and specify area
- Enable OSPF on required interfaces and specify area - on Nexus
- Enable OSPF on loopback to announce it

## Operations


#Areas
- Stub - area with single exit point. LSA 5 are not propogated. ABR will send default route to all Internal routers. No additional load on Internal routers

## Tables
- Neighbor table
- Topology table - all routes
- Routing table - best routes

## Router-ID
32 bit number, must be unique.
- The largest IP assigned to a loopback interface
- If no loopback is present, the largest IP of any interface will become the RID
- If no IPs are assigned to any interface, then OSPF can’t start on that router unless a RID is manually assigned

## Loopback intefaces
OSPF treats Loopback interfaces as STUB NETWORKS and advertise them as HOST ROUTES (with mask /32) regardless of their configured/native mask. According to RFC 2328, Host routes are considered to be subnets whose mask is "all ones (0xffffffff)".  
A router with one loopback interface generates a router-LSA with Type-1 link (stub network).

## Areas
Areas are required to control amount of updates and SPF launches to decrease load on CPU of routers  
OSPF is like a flower - there is a center and petals around - the main mechanism against loops  
Each interface is in one area  
Inside area - detailed route exchange  
Outside area - brief exchange  
Area 0 backbone area - is connected to all areas and all thraffic goes via it  
In general, NSSA is same as normal area except that it can generate LSA Type 7 (redistribute from another domain)

- Backbone area (area 0) - area 0 - connects all areas - all LSAs can pass it
- Standard area - all LSAs can pass it
- Stub area - No LSAs 5 and 7 - A default route is substituted for external routes.
- Totally stubby area - Only LSAs 1 and 2, and a single type 3 LSA. The type 3 LSA describes a default route, substituted for all external and inter-area routes.
- Not-so-stubby area (NSSA) - no LSA 5 - implement stub or totally stubby functionality yet contain an ASBR. Type 7 LSAs generated by the ASBR are converted to type 5 by ABRs to be flooded to the rest of the OSPF domain.

## LSA types
All LSAs contain Link state ID and Advertising router(RID)
- 1 - Router - main LSA for route updates inside area, each router sends it for one area, it contains all links with IPs, masks and metrics, link type)
- 2 - Network - one per transit network, created by DR
- 3 - Net Summary - Created by ABR, represent subnets listed in one's area LSA 1 and 2 to advertise to another area. Defines links(subnets) and costs , but no topology, goes between areas
- 4 - ASBR Summary - The same as LSA 3, but how to reach ASBR router
- 5 - AS external - created by ASBRs. They are used to propogate external routes - routes, which are redistributed from other protocols or other OSPF process
- 6 - Group membership, defined for MOSPF, not supported by Cisco IOS
- 7 - NSSA External - Created by ASBRs inside an NSSA area, instead of LSA 5
- 8 - Link LSA - for IPv6
- 9 - Intra area prefix LSA
- 10 - 11 - Opaque

## Link types
Link Type	Description	Link ID
1	Point-to-point connection to another router.	Neighbor router ID
2	Connection to transit network.	IP address of DR
3	Connection to stub network.	IP Network
4	Virtual Link	Neighbor router ID

## Network types
This is a per interface setting.  
Ethernet is broadcast by default.  
Network type influences DR/BDR, timers, Hello types(multicast/unicast), Updates(multicast, unicast)
- Point to point - Frame Relay by default
- Broadcast  
- Loopback  
- Nonbroadcast - NBMA - Frame Relay by default
- Point to multipoint - used in hub and spoke  
- Point to multipoint non broadcast  
*-  All interfaces will be point to point in CLOS network  
*-  Interface command or configure priority for DR/BDR - 0

## Packet types
- Hello
- DBD - Database Description - checks DB sync between routers - should be absolutely the same - router gets DBD and compares it with its own and then sends LSR and as an answer gets LSU
- LSR - Link State Request
- LSU - LInk State Update - contains LSA
- LSAck - Link State Acknowledgement

## Router types
- Internal - all interfaces are in one area
- ABR - Area Border Router - connects one or more areas to area 0
- ASBR - Autonomous System Border Router - connects with other autononomous systems or non-OSPF routers
- Backbone - router with at least one interface in area 0

## Neighbor states
- Down - initial state
- Attempt - for NBMA networks, if does not get updates from neighboor - try to reach it
- Init - hello is sent, waiting for reply
- 2-Way - communication established, DR/BDR is elected, if needed
- Exstart - master/slave is chosen based on Router ID
- Exchange - changing with DBD packets
- Loading - LSR os sent, waiting for LSU
- Full - LSBD has been synced

## Neighbor requirements
- IP in the same subnet
- Not passive on the conencted interface
- The same area
- Timers
- Unique router IDs
- IP MTU must match
- Pass neighboor auth
- Stub area flag
* If interface is unnumbered then address and network should not match mandatory. MTU maybe different for some vendors

## Timers
- Hello timer - Decides how often the hellos packets will be sentby OSPF Router to its OSFP Neighbor/s
- Dead Timer - Decides how long a OSPF Router should wait for hello packet before declaring an OSPF neighbor as dead
- The timers depends upon the network type 

## Adjency
- Multicast: 224.0.0.5, TTL 1, then unicast  
- IP number 89
- Two neighbors choose who is master and who is transferring first
- 224.0.0.5 - all OSPF routers
- 224.0.0.6 - all DRs
- Full updates - during discovery, partial otherwise. Router changes its LSDB, increases its number and sends LSU
- Authentication - MD5 and clear text

Hello Packet > DB description > LSR > LSU

## DR/BDR
- Main goal is to avoid LSA flooding
- DR/BDR are chosen based on hello messages in broadcast segment
- Non-DR and non-BDR routers only exchange routing information with the DR and BDR, rather than exchanging updates with every other router upon the segment. This, in turn significantly reduces the amount of OSPF routing updates that need to be sent.  
- Upon the segment each router will go through an election process, to elect a DR and BDR. There are two rules used to determine who is elected:  
1. Priority - Router with the highest interface priority wins the election. The default priority is 1. This is configured on a per-interface level.  
2. Router ID - If there is a tie, the highest router ID wins the election.  
- Each router forms a full relationship (/neighbor state) with the Designated and Backup Designated Routers. Non-DR and Non-BDR's on the other hand form the 2-way neighbor state. This means that they both send/receive each other's HELLO's, but no routing updates are exchanged between one another.  
- Only DR generates type 2 LSAs
- Priority 0 - router does not pretend on DR

## Authentication
- NUll - without auth
- Clear text
- MD5

## Cost
- Cost = Reference Bandwidth/Interface Bandwidth
- IOS default reference bandwidth 100 mbit/s
- NX-OS default reference bandwidth 40 gbit/s

## Virtual links
They are used when there are two area 0, and with them both area 0 are connected with each other. It can happen if 2 companies are merged.

## OSPFv3
Separate instances for OSPFv2 and OSPFv3

## Configuration
Configuration on Nexus  
Interface point to point is necessary on Loopback  
It is better to configure RID manually - so it will not be changed  
Network command can be excessive  
IP oSPF area command on interface  

```
hostname leaf-1

feature ospf

no ip domain-lookup
ip domain-name demo.lab

key chain OSPF
  key 0
    key-string 7 oajhj56

router ospf UNDERLAY
  router-id 10.0.0.3

interface Ethernet1/6
  description to spine 1
  no switchport
  no ip redirects
  ip address 10.2.1.1/31
  ip ospf authentication message-digest
  ip ospf authentication key-chain OSPF
  ip ospf network point-to-point
  ip router ospf UNDERLAY area 0.0.0.0
  no shutdown

```
**Basic IOS configuration**
```
interface loopback 1
ip address 2.2.2.2 255.255.255.255
router ospf 2
network 10.1.12.2 0.0.0.0 area 1
network 10.1.0.0 0.0.255.255 area 0
```

**Enable OSPF on all interfaces in each VRF**
```
router ospf 1 vrf Red
network 0.0.0.0 255.255.255.255 area 0
!
router ospf 2 vrf Green
network 0.0.0.0 255.255.255.255 area 0
```

**Change default reference bandwidth**  
```
auto-cost reference bandwidth 
```
**Remove router from the network for maintenence**  
Not to be confused with stub areas.  
This feature will advertise R2's router LSA with the maximum metric, making it least likely as a transit router.
```
router ospf 1
max-metric router lsa include-stub
```
Also other options are available:
- max-metric router-lsa on-startup wait-for-bgp
- max-metric router-lsa on-startup time
- max-metric router-lsa summary-lsa
- max-metric router-lsa external-lsa
  
  
**Virtual Links**
```
! On Router C1:
router ospf 1
area 1 virtual-link 4.4.4.4
!
interface fastethernet0/0
ip address 10.1.1.1 255.255.255.0
ip ospf 1 area 0
!
interface fastethernet0/1
ip address 10.21.1.1 255.255.255.0
ip ospf 1 area 1
!
interface loopback 1
ip address 1.1.1.1 255.255.255.0
ip ospf 1 area 1 
```

## Verification
List interfaces, where OSPF is enabled based on network command , omitting passive interfaces.
```
show ip ospf interface brief
```
Show how many types OSPF was launched and area type
```
show ip ospf
```
Show?
```
show ip protocols
```
List known neighbors with state
```
show ip ospf neighbors
```
Show ???
```
show ip ospf neighbor detail 4.4.4.4
```
List all LSAs for all connected areas
```
show ip ospf database
```
Show LSAs from one particular router
```
sh ip ospf database router 192.168.2.2
```
Show OSPF routes, marked with O
```
show ip route
```
Show interface type and timers
```
show ip ospf interface serial0/0
```
Show virtual links  
To prove whether the virtual link works, a neighbor relationship between C1 and C2 must reach the FULL state, resulting in all routers in both parts of area 0 having the same area 0 LSDB.
```
show ip ospf virtual-links
```
## Interview questions

Why does OSPF require all traffic between non-backbone areas to pass through a backbone area (area 0)?  
> Because inter-area OSPF is distance vector, it is vulnerable to routing loops. It avoids loops by mandating a loop-free inter-area topology, in which traffic from one area can only reach another area through area 0. 
