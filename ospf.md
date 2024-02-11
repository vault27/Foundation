# OSPF v2

- Areas
- LSAs
- Network types
- DR/BDR
- Virtual links

## Standards

- RFC 2328 "OSPF Version 2" - https://datatracker.ietf.org/doc/html/rfc2328
- RFC 5340 "OSPF for IPv6"

## History

- Open Shortest Path First  was developed in the late 1980s
- Because RIP had issues with scalability, performance, large AS
- Developed by Internet Engineering Task Force (IETF)
- The first version of OSPF was described in RFC 1131, published in October 1989. This was quickly replaced by OSPF Version 2 in July 1991, described in RFC 1247. Since then there have been several revisions to the OSPF Version 2 standard, in RFCs 1583, 2178, and 2328, with the last of these the current standard. OSPF Version 2 is the only version in use today, so it is usually what is meant when people (including myself) refer to “OSPF”. RFC is 240 pages!

## Terms

- Link state - link is an interface - The state of the link is a description of that interface and of its relationship to its neighbor routers. A description of the interface would include, for example, the IP address of the interface, the mask, the type of network it is connected to, the routers connected to that network and so on. The collection of all these link-states would form a link-state database
- LSDB - Link State Database
- SPF - Shortest Path First  
- LSU - Link State Update - packet which holds LSAs, all types of LSA can be in one packet  
- LSA - Link State Advertisments - they are held in memory in LSDB and are sent via network in LSU and in DB decription
- Area - group of routers and interfaces  
- ABR - Area Border Router - router with interfaces in 2 areas - one of them backbone area
- ASBR - Autonomous System Border Router - connects OSPF domain with external domains
- Internal router - all interfaces are in one area  
- DR - Designated Router  
- BDR - Backup Designated Router  
- DBD - Database Descriptor packets - The DBD packets are OSPF packet Type 2. The OSPF router summarizes the local database and the DBD packets carry a set of LSAs belonging to the database
- Stub network: A subnet on which a router has not formed any neighbor relationships.

## Concepts

- Open standard, IGP, Link-state, classless (VLSM, Summarization), Dikstra SPF Algorithm, guaranties loop free, hierarchi through areas - large scalability, topology summarization, interopeability between vendors
- Router knows all network and builds a tree - The algorithm places each router at the root of a tree
- This protocol is all about interfaces - everyfing is connected with the interface:
	  - priority
 	  - area
  	- cost
  	- network type
  	- hello timer
  	- dead timer
  	- DR/BDR/OTHER
    - Authentication
  	- it even does not send routes it sends information about interface: IP address, mask, cost... inside LSA
- It does not receives routes, every router calculates them by itself
- OSPF runs directly over IPv4, using its own protocol 89, which is reserved for OSPF by the Internet Assigned Numbers Authority (IANA)
- Each router has its own view of the topology even though all the routers build a shortest path tree which uses the same link-state database
- OSPF is very good for traffic engineering in ISP with MPLS - ?
- IPv4 and IPv6
- Supports multiple forms of authentication: Clear Text, MD5, SHA - ?
- Main cons is bad performance when many hosts - high CPU load - several thousand prefixes max - because every router has to calculate a tree
- Operates in one Autonomous System
- LSDB is identical on all routers in 1 area
- Administrative distance 110
- Loops are impossible inside the area because every router knows all topology. And between areas all areas have to be connected to area 0, so loops are avoided as well like in distance vector
- One area - 500 routers
- A router can run multiple OSPF processes. Each process maintains its own unique database, and routes learned in one OSPF process are not available to a different OSPF process with- out redistribution of routes between processes. The OSPF process numbers are locally sig- nificant and do not have to match among routers. Running OSPF process number 1 on one router and running OSPF process number 1234 will still allow the two routers to become neighbors
- No hop limit
- All networks are connected via backbone areas to avoid loops
- Hello interval - router sends Hello messages
- Dead timer - after it neighboor is considered dead
- The timers depends upon the network type
- Route tags - tag routes as they are redistributed into OSPF
- Next-hop field - supports the advertisment of routes with a different next-hop router than the advertising router
- Manual route summarization - summarization is supported on ABR only
- If there is an topology change - router sends LSA, if no changes LSAs are sent every 30 mins
- Each router stores the data, composed of individual link-state advertisements (LSA) , in its own copy of the link-state database (LSDB) . Then, the router applies the Shortest Path First (SPF) algorithm to the LSDB to determine the best (lowest-cost) route for each reachable subnet (prefix/length)
- Two routers can have 2 neighborships via different interfaces - and it is ok - router ID is the same
- When nothing happens, only HELLO packets travel through network
- If somethings happens and timers are default, changes will occur slowly
- Path cost and path metric are synonims

## Metric

- Metric = Cumulitive interface cost from router to destination
- Cost of interface = Reference bandwidth/Interface bandwidth
- Default reference bandwidth in Cisco IOS - 100 Mbit/s: because of this FastEthernet, GigabitEthernet, 10 GigabitEthernet - all have Cost - 1. NX-OS: 40 gbit/s
- Reference bandwidth should be the same on all OSPF routers
- OSPF cost can be set manually on an interface
- In order to make one link primary - we need to change its cost: either directly via interface command, on indirectly via changing bandwidth

## Design

- IP networks between routers - /31 is ok
- Loopback interfaces and Router-IDs - loopback is actually not needed if we configure router-id manually, which is recomended. Loopback numbers on all devices.
- Authentication
- Areas - summarization is possible only in multi area environment
- Passive inerfaces
- Route filtering
- Network types
- Process ID - it has local significance, it is better to use the same ID on all devices
- Timers, maybe it is better to harden them

### Data centre

- All routers are in area 0
- In case of super spine: superspine is in backbone, POD is in non backbone, stub area. In this scheme Spine-1 stores everything about area 1 and backbone area  and so load on Spine is BIG! Such scheme is used rarely. OSPF is not recommended for Fabric!! Do not use unnumbered!
- Point to point links between leafs and Spines - /31 networks
- BFD timers: Tx/Rx 100 ms x 3, MicroBFD if we use LAG
- To delete Spine from operation for maintenence we use command max-metric router-lsa
- Use ip ospf area instead of network
- Do not use redistribute - ?
- Authentication
- Configure OSPF in GRT, not VRF
- Passive interface default
- Configure RID explicitly

## Operations overview

- Step 1 - Discover OSPF Neighbors & Exchange Topology Information - only enabled networks are advertised
- Step 2 - Choose Best Path via SPF
- Step 3 - Neighbor and Topology Table Maintenance

Every link state router floods information about itself, its links, and its neighbors to every other router. From this flooded information each router builds an identical link state database. Each router then independently runs a shortest-path-first calculation on its database – a local calculation using distributed information – to derive a shortest-path tree. This tree is a sort of map of the shortest path to every other router.  
  
When link state domains grow large, the flooding and the resulting size of the link state database becomes a scaling problem. The problem is remedied by breaking the routing domain into areas: That first concept is modified so that flooding occurs only within the boundaries of an area, and the resulting link state database contains only information from the routers in the area. This, in turn, means that each router’s calculated shortest-path tree only describes the path to other routers within the area.  
  
OSPF areas are connected by one or more Area Border Routers (the other main link state protocol, IS-IS, connects areas somewhat differently) which maintain a separate link state database and calculate a separate shortest-path tree for each of their connected areas. So an ABR by definition is a member of two or more areas. It advertises the prefixes it learns in one area to its other areas by flooding Type 3 LSAs into the areas that basically say, “I know how to reach these destinations.”

## Configuration overview

- Enable OSPF process with particular ID (number in IOS and word in Nexus) and configure router ID for it, or loopback is used
- Iclude interfaces into OSPF using network command in IOS, we should include interfaces on which we peer and which we want to announce - and specify area
- Network command uses wild cards and specifies which interfaces will be enabled
- Discontiguous mask 10.168.1.0 255.0.0.255 cannot be used
- If the IP address for an interface matches two network statements with different areas, the most explicit network statement (that is, the longest match) preempts the other network statements for area allocation
- The connected network for the OSPF-enabled interface is added to the OSPF LSDB under the corresponding OSPF area in which the interface participates. Secondary connected net- works are added to the LSDB only if the secondary IP address matches a network statement associated with the same area
- Enable OSPF on required interfaces and specify area - on Nexus - and on IOS as well
- Enable OSPF on loopback to announce it

## OSPF Packets

OSPF packet consists of:

- OSPF header
- OSPF packet
- OSPF LLS Data Block - ?

There are 5 different types of OSPF packets:

- 1 - Hello - discover and maintain neighbors. Are sent periodically via all interfaces to discover new neighbors and test existing
- 2 - DBD - Database Description - summary of database, during first adjecency, nothing interesting inside
- 3 - LSR - Link State Request - request a portion of neighbors database - during adjecency
- 4 - LSU - Link State Update - contains LSA - sent in direct response to LSR
- 5 - Link State Acknowledgment - acknowledge of LSA

**OSPF header**

OSPF header is included in any OSPF packet

- Destination MAC: 01:00:5e:00:00:05 - all OSPF routers, 01:00:5e:00:00:06 - DRs 
- Destination IP: 224.0.0.5 - all OSPF routers, 224.0.0.6 - DRs
- IP type: 89
- Message type: Hello - 1
- Router ID - Source OSPF router - unique within OSPF domain and processes - source router, who sent it - not origin, who generated
- Area ID - 0.0.0.0 - The OSPF area that the OSPF interface belongs to. It is a 32-bit number that can be written in dotted-decimal format (0.0.1.0) or decimal (256)
- Auth Data

Example:

```
OSPF Header
    Version: 2
    Message Type: Hello Packet (1)
    Packet Length: 52
    Source OSPF Router: 10.10.10.10
    Area ID: 0.0.0.2
    Checksum: 0xae65 [correct]
    Auth Type: Null (0)
    Auth Data (none): 0000000000000000

```

**Hello Packet**

OSPF routers periodically send Hello packets out OSPF enabled links every Hello lnterval. Hellos are sent to Multicast addresses (both IP and MAC), so all devices int he segment get them.  

- Active neighbors - their RIDs - all routers on this network segment
- DR/BDR - their IP addresses in this segment
- Router priority for DR/BDR
- Network mask
- RID is not here! It is in header

Example:

```
OSPF Hello Packet
    Network Mask: 255.255.255.0
    Hello Interval [sec]: 10
    Options: 0x12, (L) LLS Data block, (E) External Routing
    Router Priority: 1
    Router Dead Interval [sec]: 40
    Designated Router: 10.1.1.2
    Backup Designated Router: 10.1.1.1
    Active Neighbor: 8.8.8.8
    Active Neighbor: 9.9.9.9
    Active Neighbor: 10.10.10.10
```

Explanation:

- Network mask - Interface mask
- DR: IP address of DR in this broadcast domain
- BDR: IP address of BDR in this broadcast domain
- Active neighbor - all neighbors in broadcast domain - even if there are only 2 routers on the links, if R2 got Hello from R1, then it sends its own hello to R1 with R1's ID in this field > so R1 understands that R2 knows about him and 2-Way neighbor state is established

**DBD - Database Description Packet**

- Summary of what router knows - index
- Sent during adjacency forming

**Link State Request Packet**

- After router gets DBD, it requests details based on LS type and Link State ID
- In reply to this LSR LSUs with LSAs are sent

**LSU packet**

- OSPF header
- One or many LSAs
- In one LSU can be many LSAs from different Advertising Routers

**Link State Acknowledgment**

- Confirms that LSA has been received
- LSA which was received is inside, but less details
- Link state ID - 192.168.1.1
- Advertising router ID - 192.168.1.1
- Sequence number

## LSA

- All LSAs contain The LSA header which contains the LS type, Link State ID and Advertising Router fields.  The combination of these three fields uniquely identifies the LSA
- Link State ID depends on LS type:
  - 1 - The originating router's Router ID.
  - 2 - The IP interface address of the network's Designated Router.
  - 3 - The destination network's IP address.
  - 4 - The Router ID of ASBR
  - 5 - The destination network's IP address
- Every router stores all LSAs in its LSDB, where his own LSAs are stored as well
- LSDB is per area: every area has its own LSDB
- Only a router that has originated a particular LSA is allowed to modify it or withdraw it
- So Link State ID, Advertising Router, Metric are not changed! Metric is not accumulated!
- Other routers must process and flood this LSA within its defined flooding scope if they recognize the LSA’s type and contents, but they must not ever change its contents, block it, or drop it before its maximum lifetime has expired
- Summarization and route filtering can be done in a very limited fashion, unlike in distance vector protocols, where summarization and route filtering can be performed at any point in the network
- In one LSU can be many LSAs, including LSAs from different Advertising Routers
- Mostly used: 1,2,3,4,5,7
- 1,2,3 - for all routes exchanges inside OSPF domain - CCNP Core exam
- 4,5,7 - for external redistributed routes
- Sequence number - 32 bit number - it is incremented after each sending LSA - if router receives LSA with sequence number larger than in LSDB it processes it, and if it is smaller, router discards it
- LSA age - every 1800 seconds - 30 minutes - router sends new LSAs with LSA age set to 0 - every second this value increments in LSDB. When age is 3600 seconds and nothiing new arrived - LSA is purged
- LSAs are forwarded unchanged, if router gets the same LSAs from different routers, it keeps only 1 copy in database, because they are the same

**LSA types (11 in total) (6 used for IPv4)**

- 1 - Router LSA - generated for every interface
- 2 - Network - generated by DR/BDR
- 3 - Net Summary - Created by ABR, represent subnets listed in one's area LSA 1 and 2 to advertise to another area. Defines links(subnets) and costs, but no topology, goes between areas. We see them as “OIA” routes.
- 4 - ASBR Summary - The same as LSA 3, but how to reach ASBR router
- 5 - AS external - created by ASBRs. They are used to propogate external routes - routes, which are redistributed from other protocols or other OSPF process
- 6 - Group membership, defined for MOSPF, not supported by Cisco IOS
- 7 - NSSA External - Created by ASBRs inside an NSSA area, instead of LSA 5 
- 8 - Link LSA - for IPv6
- 9 - Intra area prefix LSA
- 10 - 11 - Opaque

**How LSA is sent:**

- OSPF header
- LSU
  - LSA 1
    - LSA Header
      - LS type
      - Link State ID
      - Advertising Router
    - LSA Data
  - LSA 2
  - LSA ...

**LSA-1**

- Is called Router LSA
- Is sent inside the area, every router generates LSA-1 for every enabled interface  
- Link-state ID and advertising router are shared for all links in LSA-1
- Link-state ID is always equal Advertising router
- We see this as “O” routes in the routing table
- One LSA-1 for all links on router is sent with particular sequence number
- Link State ID: Router ID
- Every link inside LSA has fields:
  - Link type
  - Link ID
  - Link Data
  - Metric
- Link ID and Link Data have different values depending on link type
- 4 types of Links are available:
    - 1 - Point-to-point link IP address assigned, Link ID Value - Neighbor RID, Link Data Value - Interface IP address
    - 1 - Point-to-point link IP unnumbered, Link ID Value - Neighbor RID, Link Data Value - MIB II IfIndex value
    - 2 - Transit network, Link ID Value - Interface address of DR, Link Data Value - Interface IP address - this type is used when interface type is Broadcast and there are other routers on the link
    - 3 - Stub network - Link ID Value - Network Address, Link Data Value - Subnet mask
    - 4 - Virtual Link - Link ID Value - Neighbor RID, Link Data Value - Interface IP address
- Transit - if there are other routers on a link, adjecency formed, DR elected
- Secondary connected networks are always advertised as Stub because adjecencies are impossible on them

Example, shared portion + Stub link + Transit link: 

```
LSA-type 1 (Router-LSA), len 60
    .000 0000 0011 0111 = LS Age (seconds): 55
    0... .... .... .... = Do Not Age Flag: 0
    Options: 0x22, (DC) Demand Circuits, (E) External Routing
    LS Type: Router-LSA (1)
    Link State ID: 2.2.2.2
    Advertising Router: 2.2.2.2
    Sequence Number: 0x8000000c
    Checksum: 0x572f
    Length: 60
    Flags: 0x00
    Number of Links: 3
    Type: Stub     ID: 10.1.3.0        Data: 255.255.255.0   Metric: 10
    Type: Stub     ID: 192.168.1.0     Data: 255.255.255.0   Metric: 10
        Link ID: 192.168.1.0 - IP network/subnet number
        Link Data: 255.255.255.0
        Link Type: 3 - Connection to a stub network
        Number of Metrics: 0 - TOS
        0 Metric: 10
    Type: Transit  ID: 192.168.3.1     Data: 192.168.3.2     Metric: 10
        Link ID: 192.168.3.1 - IP address of Designated Router
        Link Data: 192.168.3.2
        Link Type: 2 - Connection to a transit network
        Number of Metrics: 0 - TOS
        0 Metric: 10

```

**Show LSA-1 in OSPF database**

```
show ip ospf database router

   OSPF Router with ID (3.3.3.3) (Process ID 1)

		Router Link States (Area 0)

  LS age: 223
  Options: (No TOS-capability, DC)
  LS Type: Router Links
  Link State ID: 1.1.1.1
  Advertising Router: 1.1.1.1
  LS Seq Number: 80000010
  Checksum: 0x8467
  Length: 60
  Number of Links: 3

    Link connected to: a Transit Network
     (Link ID) Designated Router address: 192.168.2.2
     (Link Data) Router Interface address: 192.168.2.1
      Number of MTID metrics: 0
       TOS 0 Metrics: 10

    Link connected to: a Stub Network
     (Link ID) Network/subnet number: 10.1.1.0
     (Link Data) Network Mask: 255.255.255.0
      Number of MTID metrics: 0
       TOS 0 Metrics: 10

    Link connected to: a Stub Network
     (Link ID) Network/subnet number: 10.1.2.0
     (Link Data) Network Mask: 255.255.255.0
      Number of MTID metrics: 0
       TOS 0 Metrics: 10
```

**LSA-2**

- Is called Network LSA
- Sent by DR. Only inside area
- Represents multi access network segment that uses DR
- Identifies all the routers attached to this network segment, including itself
- It contains:
  - IP address of DR in corresponding multi access network - in Link State ID field
  - Network mask
  - RIDs of all(including DR) attached routers to corresponding multiaccess network
- Example:

```
LSA-type 2 (Network-LSA), len 32
    .000 0000 0011 1101 = LS Age (seconds): 61
    0... .... .... .... = Do Not Age Flag: 0
    Options: 0x22, (DC) Demand Circuits, (E) External Routing
    LS Type: Network-LSA (2)
    Link State ID: 192.168.3.1
    Advertising Router: 3.3.3.3
    Sequence Number: 0x80000001
    Checksum: 0x3379
    Length: 32
    Netmask: 255.255.255.0
    Attached Router: 3.3.3.3
    Attached Router: 2.2.2.2
```

**Show LSA-2 in OSPF Database**

```
r10#show ip ospf database network

            OSPF Router with ID (10.10.10.10) (Process ID 1)

		Net Link States (Area 2)

  LS age: 76
  Options: (No TOS-capability, DC)
  LS Type: Network Links
  Link State ID: 10.1.1.2 (address of Designated Router)
  Advertising Router: 10.10.10.10
  LS Seq Number: 80000003
  Checksum: 0x4F3A
  Length: 40
  Network Mask: /24
	Attached Router: 10.10.10.10
	Attached Router: 1.1.1.1
	Attached Router: 8.8.8.8
	Attached Router: 9.9.9.9
```

**LSA-3**

- Is called Summary
- Link State ID in this LSA is network number
- Is sent by ABR, contains all prefixes available in neighbor area
- LSA-3 are generated based on LSA-1 or LSA-3
- For example ABR connected to Area 0 and Area 1, takes all LSA-1 from Area 1 and generates LSA-3 which are sent to Area 0
- For example ABR connected to Area 0 and Area 2 receives LSA-3 from Area 0 regarding routes in Area 1, then it regenerates them to LSA-3 for area 2, during regeneration it changes Advertising router and Metric of LSA
- **LSA 3 received from non backbone area will be installed to routing table but will not be propogated further**
- When ABR receives LSA-1, it creates LSA-3 with same network as in LSA-1, LSA-2 are used to determine network mask for multi access network
- For example ABR sends everything he gets from Area 1 to Area 0 interfaces
- Every prefix contains network, mask, metric
- Metric:
    - After metric is generated on ABR it is not changed, it can be changed only on next ABR
    - ABR takes metric from LSA-1 and sends it as LSA-3 to Area 0, LSA-3 travels in Area 0, metric in LSA itself is not changed, but when routers install route to table they add to this metric distance till the ABR, which generated LSA-3
    - When ABR area 0 and 1 receives LSA-3 from Area 2 it regenarates LSA-3 and add it distance till ABR area 0 and area 2 and sends it to Area 1
- When LSA-3 from Area 1  travels inside Area 0 the Advertising Router (ABR) is not changed, metric is increasing not in LSA itself, but before installing to routing table
- LSA-3 does not contain area, from which it arrived
- All LSA-3 routes are marked as INTER in OSPF RIB
- O IA - this is how LSA-3 routes look like in routing table in Cisco
- Advertising Router in LSA is ABR: it is not changed while travelling inside area 0, it is changed only when leaves Area 0 on other ABR
- ABR generates only one LSA-3, even if it has several LSA-1 for this network, best metric is used before creating LSA-3 for network
- If route is deleted from LSDB ABR sends LSA-3 with maximum metric 16777215 to other Areas
- Separate LSA-3 for every route

LSA-3 example for one prefix

```
LSA-type 3 (Summary-LSA (IP network)), len 28
    .000 0000 0000 0001 = LS Age (seconds): 1
    0... .... .... .... = Do Not Age Flag: 0
    Options: 0x22, (DC) Demand Circuits, (E) External Routing
    LS Type: Summary-LSA (IP network) (3)
    Link State ID: 192.168.4.0
    Advertising Router: 192.168.1.2
    Sequence Number: 0x80000001
    Checksum: 0xf068
    Length: 28
    Netmask: 255.255.255.0
    TOS: 0
    Metric: 10
```

**Show LSA-3 in OSPF database**

```
r1#show ip ospf database summary

            OSPF Router with ID (1.1.1.1) (Process ID 1)

		Summary Net Link States (Area 0)

  LS age: 1050
  Options: (No TOS-capability, DC, Upward)
  LS Type: Summary Links(Network)
  Link State ID: 10.1.1.0 (summary Network Number)
  Advertising Router: 1.1.1.1
  LS Seq Number: 80000001
  Checksum: 0x36EC
  Length: 28
  Network Mask: /24
	MTID: 0 	Metric: 10
```

**Show Summary LSA for particular network**

```
R2#show ip ospf database summary 10.3.1.0
```

**LSA-4**

- It helps routers to find ASBR, if ASBR is in different area
- Essentialy this is LSA-3 only directly for ASBR
- It is created by first ABR after ASBR
- Metric - distance from first ABR to ASBR
- Every next ABR regenerated LSA-4
- ABR generates only one LSA-4 for one ASBR, even if there are many LSA-5 from it

What is inside

- Link State ID - ASBR RID
- Advertising router - ABR RID
- Network mask - /0

**Show LSA-4 in OSPF database**

```
r10#show ip ospf database asbr-summary

            OSPF Router with ID (10.10.10.10) (Process ID 1)

		Summary ASB Link States (Area 2)

  LS age: 98
  Options: (No TOS-capability, DC, Upward)
  LS Type: Summary Links(AS Boundary Router)
  Link State ID: 3.3.3.3 (AS Boundary Router address)
  Advertising Router: 1.1.1.1
  LS Seq Number: 80000002
  Checksum: 0x35EB
  Length: 28
  Network Mask: /0
	MTID: 0 	Metric: 10
```

**LSA-5**

- Used for sending redistributed routes, including default gateway
- Spreaded through all OSPF domain and all areas
- Two types: 1 and 2 - O E1 and O E2
    - Type 1 is prefered over Type 2
    - Type 1 metric = redistribution metric + total path metric to ASBR
    - Type 2 metric = only redistribution metric
    - Type 2 is default
    - Type is selected in redistribute command
    - Default route is sent like Type 2
- Only LSA age is modified during spreading
- Link State ID - network
- Netmask
- Advertising Router - ASBR itself
- Metric - 10 - default
- Metric type: 1 or 2
- Forwarding Address - Next hop for this network from ASBR
- External route tag - not used - 32 bit value - configured in redistribute command as well - can be used for filtering

```
LSA-type 5 (AS-External-LSA (ASBR)), len 36
    .000 0000 1010 1000 = LS Age (seconds): 168
    0... .... .... .... = Do Not Age Flag: 0
    Options: 0x20, (DC) Demand Circuits
    LS Type: AS-External-LSA (ASBR) (5)
    Link State ID: 0.0.0.0
    Advertising Router: 3.3.3.3
    Sequence Number: 0x80000001
    Checksum: 0x7b1d
    Length: 36
    Netmask: 0.0.0.0
    1... .... = External Type: Type 2 (metric is larger than any other link state path)
    .000 0000 = TOS: 0
    Metric: 10
    Forwarding Address: 1.1.1.2
    External Route Tag: 1
```

Example of redistribution of static routes with metric type 1

```
Router(config)#ip route 2.2.2.0 255.255.255.0 1.1.1.2

router ospf 1
 router-id 3.3.3.3
 redistribute static metric-type 1
```

And on neighboor router we will see

```
r1#show ip route
O E1     2.2.2.0 [110/40] via 192.168.2.2, 00:00:04, Ethernet0/2
```

Show external routes in OSPF data base

```
r1#show ip ospf database external
OSPF Router with ID (1.1.1.1) (Process ID 1)

		Type-5 AS External Link States
LS age: 129
  Options: (No TOS-capability, DC, Upward)
  LS Type: AS External Link
  Link State ID: 2.2.2.0 (External Network Number )
  Advertising Router: 3.3.3.3
  LS Seq Number: 80000001
  Checksum: 0x208
  Length: 36
  Network Mask: /24
        Metric Type: 1 (Comparable directly to link state metric)
        MTID: 0
        Metric: 20
        Forward Address: 1.1.1.2
        External Route Tag: 0
```

**LSA-6**

**LSA-7**

 - Exists only in NSSA where redistribution occurs
 - ASBR generates LSA-7 in NSSA
 - ABR does not forward them to other areas, but converts it to LSA-5, and further ABR will of course generate LSA-4 as well
 - ASBR > Type 7 > ABR > Type 5 > ABR > Type 5 + Type 4

 What is inside

 - Link state ID - network address
 - Advertising router - ASBR RID
 - Network mask
 - Metric type - the same as for LSA-5
 - Metric - the same logic as for LSA-5
 - External route tag - the same as for LSA-5

 Show in OSPF database

 ```
 show ip ospf database nssa-external
 ```
## Route Deletion

- Router looses link
- It sends new LSA-1 with new sequence number and without this link
- After this ABRs send LSA-3 with maximum metric 16777215 to other Areas

## Discontiguous networks

Example:

```
Area 12 > R2 > Area 23 > R3 > Area 34
          |               |
        Area 0          Area 0
```

- Area 34 LSA-1 are converted to LSA 3 in Area 0
- LSA 3 from Area 0 are converted to LSA 3 in Area 23
- R2 installs LSA 3 into its routing table
- BUT IT WILL NOT BE SENT FURTHER TO AREA 12
- LSA 3 received from non backbone area will not be propogated to other areas
- Area 0 should be contigous
- Workaround: GRE tunnels and virtual links

## Neighbors

**Requirements**

- IP in the same subnet
- Not passive on the conencted interface
- The same area
- Timers
- Unique router IDs
- IP MTU must match
- Pass neighboor auth
- Stub area flag
- Network type
- If interface is unnumbered then address and network should not match mandatory. MTU maybe different for some vendors


- OSPF uses Hello packets to discover neighbors on OSPF enabled attached links
- Transport via IP protocol 89 (OSPF)
- Sent as multicast to 224.0.0.5 (all OSPF routers) - or MAC address 01:00:5E:00:00:05 or 224.0.0.6 (all DRs) - MAC address 01:00:5E:00:00:06
- Multicast is used to find neighbors, TTL 1, then unicast is used to exchange topologies
- Hello packets contain attributes that neighbors must agree on to form "adiacency"
- Once adjacency is negotiated, LSDB is exchanged
- Hello Packet > DB description > LSR > LSU
- Two neighbors choose who is master and who is transferring first
- Full updates - during discovery, partial otherwise. Router changes its LSDB, increases its number and sends LSU
- Authentication - MD5 and clear text

## Adjecency

- R1 sends Hello - multicast - 224.0.0.5
- R2 gets Hello and sends DB description packet without anything useful - unicast
- R2 also sends Hello Packet
- R1 sends many DB descriptions packets to R2 with very weird content
- R2 sends LS request where it provides Link State ID - Router ID of R1 - unicast
- R1 sends LS update, where there are 2 LSA type 1 - for both networks which are directly connected to R1, including the network between routers
- R1 also sends LSA-2, because it is DR
- Both routers send LS acknowledges, confirminf that they got everything they need
- After this only Hello packets

Debug adjecency

```
debug ip ospf adjacency
```

## Withdraw a route, link is down

- Router generates LSA-1 and LSA-2(if it is a transit network with DR) with higher sequence number and absence of this link - multicast 224.0.0.5
- Received routers send LS Acknowledge - multicast as well
- All routers in area run SPF alhorithm and recalculate topology
- Other areas should know about it as well
- ABR sends new Summary LSA with and updated sequence number. The prefix is flagged as unreachable by setting the 24-bit metric field to all ones. This is called LSInfinity and has a decimal value of 16777215

## Neighbor states

8 states

- Down - initial state - No hellos have been received from neighbor
- Attempt - for NBMA networks, if does not get updates from neighboor - try to reach it
- Init - I have received a hello packet from a neighbor, but they have not acknowledged a hello from me
- 2-Way - communication established, DR/BDR is elected, if needed
    - I have received a hello packet from a neighbor and they have acknowledged a hello from me
    - Indicated by my Router-ID in neighbor's hello packet in Active neighbors field  
- Exstart - master/slave is chosen based on Router ID - where master has higher Router-ID - First step of actual adjacency  - Master chooses the starting sequence number for the Database Descriptor (DBD) packets that are used for actual LSA exchange
- Exchange
    - Local link state database is sent through DBD packets
    - DBD sequence number is used for reliable acknowledgement/retransmission
- Loading - LSR packets are sent to the neighbor, asking for the more recent LSAs that have been discovered (but not received) in the Exchange state
- Full - Neighbors are fully adjacent and databases are synchronized

To see the state of adjecency + who is DR: 

```text
Router2# show ip ospf neighbor 

Neighbor ID     Pri    State      Dead Time    Address     Interface
192.168.45.1    1      FULL/DR    00:00:36     10.0.0.1    Ethernet0
```

Priority  
The Pri field indicates the priority of the neighbor router. The router with the highest priority becomes the designated router (DR). If the priorities are the same, then the router with the highest router ID becomes the DR. By default, priorities are set to 1. A router with a priority of 0 never becomes a DR or a backup designated router (BDR); it is always a DROTHER, that means a router that is neither the DR or the BDR.  

Dead Time  
The Dead Time field indicates the amount of time that remains as the router waits to receive an OSPF hello packet from the neighbor before it declares the neighbor is down. On broadcast and point-to-point media, the default dead interval is 40 seconds. On non-broadcast and point-to-multipoint links, the default dead interval is 120 seconds. In the previous example, the Dead Time is 36 seconds before the neighbor 192.168.45.1 is declared down  

State  
The state of NEIGHBOR + Neighbor's status - if it is DR or BDR or DROTHER  
  
**Tracking Topology Changes** 

When a new LSA is received it is checked against the database for changes such as...

- Sequence number - Used to track new vs old LSAs
- Age - Used to keep information new and withdraw old information
- Periodic flooding occurs after 30 minutes + "paranoid" update
- LSAs that reach MaxAge (60 minutes) are withdrawn
- Checksum - Used to avoid transmission & memory corruption
  
**LSA Flooding**

- When change is detected new LSA is generated and "flooded" (sent) out all links
- OSPF does not use split horizon
- Self-originated LSAs are simply dropped
- Not all LSA changes require SPF to recalculate + e.g. link up/down event vs. seq number change
- See RFC 2328 "13. The Flooding Procedure" for details

## Areas

- Areas are required to control amount of updates and SPF launches to decrease load on CPU of routers  
- OSPF is like a flower - there is a center and petals around - the main mechanism against loops  
- Each interface is in one area  
- Area ID - 32 bit field - decimal 0 through 4294967295 - dotted decimal 0.0.0.0 through 255.255.255.255
- Area ID is advertised in dotted decimal form in Hello packet
- Inside area - detailed route exchange  
- Outside area - brief exchange  
- Area 0 backbone area - is connected to all areas and all thraffic goes via it  
- If a router is connected to Area 1 and Area 2, it will not forward information between them, because non of them is Area 0
- Every area has its own LSDB
- ABR does not pass denser and more detailed type 1 and 2 LSAs from one area to another—instead, it passes type 3 summary LSAs
- OSPF always chooses an intra-area route over an inter-area route for the same prefix, regardless of metric
- ABRs ignore type 3 LSAs learned in a nonbackbone area during SPF calculation, which prevents an ABR from choosing a route that goes into a nonbackbone area and then back into the backbone
- Router can be connected to 3 and more areas: for example to area 0, 1 and 2, routes between areas 1 and 2 are exchanged via area 0
  
Using areas provides the following benefits:

- Generally smaller per-area LSDBs, requiring less memory.
- Faster SPF computation thanks to the sparser LSDB
- A link failure in one area only requires a partial SPF computation in other areas
- Routes can be summarized and filtered only at ABRs (and ASBRs). Having areas permits summarization, again shrinking the LSDB and improving SPF calculation performance

Area types (6 in total):

- Backbone area (area 0) - area 0 - connects all areas - all LSAs can pass it
- Regular area - all LSAs can pass it - areas that do not perform any automatic filtering on the type of accepted information
- Stubby area - No LSAs 5 and 7 - A default route is substituted for external routes.
- Totally stubby area - Only LSAs 1 and 2, and a single type 3 LSA. The type 3 LSA describes a default route, substituted for all external and inter-area routes.
- Not-so-stubby area (NSSA) - no LSA 5 - implement stub or totally stubby functionality yet contain an ASBR. Type 7 LSAs generated by the ASBR are converted to type 5 by ABRs to be flooded to the rest of the OSPF domain
- Totally NSSA (NSSA-TS)

We configure area after network command and so put interface in particular area.  

### Stubby area

Different stub areas were invented to even more reduce the overhead.  
All stubby areas stop type 4 (ASBR summary) and type 5 (external) LSAs from being injected into them by the ABRs.  

- Stub - area with single exit point. LSA 5 and 4 are not propogated. ABR will send default route to all Internal routers. No additional load on Internal routers
- Every internal router in a stubby area will ignore any received type 5 LSAs, and will not originate any such LSAs itself
- **All external routes in stub area are substituted by default route, intra area routes remains. Default route is injected as LSA 3**
- Stub area restrictions are that a stub area cannot be used as a transit area for virtual links
- A stubby area is an area that does not contain an ASBR
- All OSPF routers inside a stub area have to be configured as stub routers
- When an area is configured as stub, all interfaces that belong to that area should be configured as stub. If it is not done they will not become neighnors. They exchange Hello packets with a flag that indicates that the interface is stub. Actually this is just a bit in the Hello packet (E bit) that gets set to 0.
- To make area stub we add the command after network command in router section:

```text
router ospf 10
  network 203.0.113.150 0.0.0.255 area 2
  network 203.0.113.140 0.0.0.255 area 0
  area 2 stub
```

### Totally stubby area

- This is an extension to stub area
- Blocks external routes and summary routes (inter-area routes) from entrance into the area
- This way, intra-area routes and the default of 0.0.0.0 are the only routes injected into that area
- We configure total stubby area by adding no-summary only on the ABR, no need to add it on Internal routers:

```text
router ospf 10
  network 203.0.113.150 0.0.0.255 area 2
  network 203.0.113.140 0.0.0.255 area 0
  area 2 stub no-summary
  area 2 default cost 10
```

- **The external and inter-area routes have been blocked**
- By default default gateway is sent with metric 1

## Route types

- Intra-area - O
- Inter-area - O IA

## Tables

- Neighbor table
- Topology table - all routes
- Routing table - best routes

## Loopback intefaces

OSPF treats Loopback interfaces as STUB NETWORKS and advertise them as HOST ROUTES (with mask /32) regardless of their configured/native mask. According to RFC 2328, Host routes are considered to be subnets whose mask is "all ones (0xffffffff)".A router with one loopback interface generates a router-LSA with Type-1 link (stub network).

## Link types

Link Type	Description	Link ID
1	Point-to-point connection to another router.	Neighbor router ID
2	Connection to transit network.	IP address of DR
3	Connection to stub network.	IP Network
4	Virtual Link	Neighbor router ID

## Timers

Timers depend on interface network type

- Hello: 1-65535 seconds
- Dead: 4 times Hello by default
- Wait - If no DR exists on the network, routes will wait until Wait Timer runs out. The Wait Timer is used in OSPF to allow newly-booted routers to determine the DR/BDR on their multiaccess segments. It allows these routers to wait to see if any DR/BDRs exist on those links, before declaring themselves as the DR/BDR. The waiting timer (or state) is equal to OSPF dead interval on the interface
- Retransmit - When OSPF sends an advertisement to an adjacent router, it expects to receive an acknowledgment from that neighbor. If no acknowledgment is received, the router will retransmit the advertisement to its neighbor. The retransmit-interval timer controls the number of seconds between retransmissions

```
r1(config)#int ethernet 0/1
  ip ospf hello-interval 1-65535
  ip ospf dead-interval 1-65535

show ip ospf interface | i Timer|line
```

## Network types

This is a per interface setting  
Ethernet is broadcast by default   
Network type influences DR/BDR, timers, Hello types(multicast/unicast), Updates(multicast, unicast)

- Point to point - No ARP protocol, Serial, GRE, point-to-point Frame Relay sub interfaces - no DR is required
- Broadcast Multi Access - DR is needed
- Loopback - always advertised as /s2, even if it is not 
- Nonbroadcast multi access - NBMA - Frame Relay, ATM, X.25 - broadcasts from one interface cannot reach all other interfaces - DR is needed
- Point to multipoint - used in hub and spoke - requires manual configuration - no DR - L2VPN and Frame Relay - 3 routers on the same subnet - 2 routers estalish peering only with hub
- Point to multipoint non broadcast  
- All interfaces will be point to point in CLOS network  
- Interface command or configure priority for DR/BDR - 0

Configure network type for interface

```
ip ospf network point-to-point_broadcast|non-broadcast
```

Static neighbor configuration is required when OSPF packets cannot be received via Broadcast/Multicast

```
router ospf 1
  neighbor 10.1.1.1
```

Verify network type for the interface

```
show ip ospf serial 0/0 | include Type
```

## Router types

- Internal - all interfaces are in one area
- ABR - Area Border Router - connects one or more areas to area 0
- ASBR - Autonomous System Border Router - connects with other autononomous systems or non-OSPF routers
- Backbone - router with at least one interface in area 0

## DR/BDR

- Used in multi access networks: Ethernet, Frame Relay
- Main goal is to avoid LSA flooding
- DR/BDR are chosen based on hello messages in broadcast segment
- Non-DR and non-BDR routers only exchange routing information with the DR and BDR, rather than exchanging updates with every other router upon the segment. This, in turn significantly reduces the amount of OSPF routing updates that need to be sent
- Other routers have state FULL with DR/BDR, with other routers they have state 2WAY
- In the event of DR failure, a backup designated router (BDR) becomes the new DR; then an election occurs to replace the BDR
- Only DR generates type 2 LSAs
- To minimize transition time, the BDR also forms full OSPF adjacencies with all OSPF routers on that segment
- All OSPF routers (DR, BDR, and DROTHER) on a segment form full OSPF adjacencies with the DR and BDR
- As an OSPF router learns of a new route, it sends the updated LSA to the AllDRouters (224.0.0.6) address, which only the DR and BDR receive and process
- The DR sends a unicast acknowledgment to the router that sent the initial LSA update
- The DR floods the LSA to all the routers on the segment via the AllSPFRouters (224.0.0.5) address

**Elections**

- First router start sending HELLO with DR and BDR 0.0.0.0
- After they elected DR nad BDR they put their values into Hello
- If router is alone in segment: It waits for 40 seconds in broadcast network ( default dead interval is 40 in broadcast) and then elects itself as DR and then continues sending hello packets specifying itself as DR in the DR field in hello packets.  The waiting timer (or state) is equal to OSPF dead interval on the interface
- Newly added router  does not wait for wait state timer. It gets hello from others, it agrees on R1 and R2 being DR and BDR and goes directly for DBD exchange even though it has higher interface IP address (eligible to be DR)
- If next router is added to segment, and it has high priority or high RID - it does not mean anything - DR and BDR are already elected
- Lets talk about a case when several routers come up at the same time. In this case they all send hello packets with 0.0.0.0 in DR/BDR field. They all wait until waiting state ends and then elect DR and BDR
- 2 DRs at the same time - this is possible - if we connect two segements, which already have DRs
- Only DR sends LSA-2, BDR does not
- All routers have FULL neighbor state only with DR/BDR, with others they have 2WAY
- If we kill BDR - only it will be reelected - DR will be untouched
- If we kill DR, BDR will become DR, new BDR will be reelected
- The DR/BDR election occurs during OSPF neighborship—specifically during the last phase of 2-Way neighbor state and just before the ExStart state
- If the hello packet includes a RID other than 0.0.0.0 for the DR or BDR, the new router assumes that the current routers are the actual DR and BDR
- Any router with OSPF priority of 1 to 255 on its OSPF interface attempts to become the DR
- By default, all OSPF interfaces use a priority of 1
- The routers place their RID and OSPF priorities in their OSPF hellos for that segment
- Priority for the interface is the highest for that segment - DR
- If the OSPF priority is the same, the higher RID is more favorable
- Once all the routers have agreed on the same DR, all routers for that segment become adjacent with the DR
- Then the election for the BDR takes place
- The election follows the same logic for the DR election, except that the DR does not add its RID to the BDR field of the hello packet
- The OSPF DR and BDR roles cannot be preempted after the DR/BDR election. Only upon the failure (or process restart of the DR or BDR) does the election start to replace the role that is missing
- What routers send in Hello when reelection starts? - 
- New routers added to DR/BDR domain do not influence DR/BDR election - they are already elected
- Priority 0 - router does not pretend on DR
- Modifying a router’s RID for DR placement is a bad design strategy. A better technique involves modifying the interface priority to a higher value than the existing DR has

**Show DR/BDR state of current router and neighbors**

```
R1# show ip ospf interface brief

Interface    PID   Area            IP Address/Mask    Cost  State Nbrs F/C
Et0/0        1     2               10.1.1.4/24        10    DROTH 2/3
```

**Show state of neighbors, their priority, their status: DR, BDR, or DROTHER**

```
r8#show ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
1.1.1.1           1   FULL/BDR        00:00:34    10.1.1.1        Ethernet0/0
9.9.9.9           1   2WAY/DROTHER    00:00:39    10.1.1.3        Ethernet0/0
10.10.10.10       1   FULL/DR         00:00:31    10.1.1.2        Ethernet0/0
```

**Configure interface priority on IOS**

```
R1(config-if)# ip ospf priority 100
```

**Restart OSPD processes to change DR/BDR after changing priority**

```
R3# clear ip ospf process
```

## Router ID

- 32 bits, 4 octets
- Highest IP of loopback interface
- Highest IP of interface
- Changed when OSPF process restarts
- OSPF topology is heavy based on RID
- Recomended to configure manually

```
router ospf 1
	router-id 1.1.1.1
```

To change RID we need to restart OSPF

```
clear ip ospf process
```

## Path Selection

- Intra-area - with the lowest metric, intra-area is chosen even if it is slower then inter-area
- Inter-area
- External routes

If two routes have equal metric, both of them are installed in RIB  
Default max ECMP is 4 paths, it can be changed

## Authentication

- Enabled per interface basis or per area
- Password is always per interface
- Plaintext
- MD5

Per interface enable and configure password

```
interface GigabitEthernet0/0
    ip address 10.1.1.1 255.255.255.0
    ip ospf authentication
    ip ospf authentication message-digest
    ip ospf authentication-key CISCO
    ip ospf message-digest-key 1 md5 CISCO
```

Per area enable

```
router ospf 1
    area 0 authetication message-digest
    area 12 autentication
```

Verify

```
show ip ospf interface | include line|authetication|key
```

## ECMP

## Redistribution

## Virtual links

- They are used when there are two area 0, and with them both area 0 are connected with each other. It can happen if 2 companies are merged
- A virtual link is not a tunnel for data packets; rather, it is a targeted session that allows two remote routers within a single area to become fully adjacent and synchro- nize their LSDBs. The virtual link is internally represented as an unnumbered point-to- point link between the two endpoint routers and exists in the backbone area, regardless of the area through which it is created. The area through which the virtual link is created is called a transit area and it must be a regular area: As no tunneling is involved, packets routed through this transit area are forwarded based on their true destination addresses, requiring the transit area to know all networks in the OSPF domain, intra-area, inter-area, and external

## Summarization

- Disabled by default
- Method 1: create many areas, mnay LSA-1 and LSA-2 inside area are transformed into s small amount of LSA-3
- Method 2: sunnarize network prefixes on ABR or ASBR
- On ABR the lowest metric among summarized networks will be used. If new network with lower metric appears then it will be used instead
- Metric on the ABR can be configured manually
- Small routes are suppressed
- ABR installs discard route to its RIB to avoid loops and points this route to interface Null0s - if he gets packet for small network which does not exist on it he will not send this packet back, he will drop it
- ABR will only summarize LSA-1s from source area, if he gets LSA-3 from source area, it will not add it to summary, and will advertise separatly :)
- On ASBR default metric will be 20 for routes redistributed from other protocols

On ABR, send to Area 0 only summary from area 1 instead of 10 nerworks

```
router ospf 1
area 1 range 192.168.16.0 255.255.255.248.0 [cost 45]
```

Summarization on ASBR router - it will send only one external route, from BGP for example, to OSPF domain

```
router ospf 1
summary-address 192.168.16.0 255.255.255.248.0
```

## Route filtering

OSPF supports filtering when type 3 LSA generation occurs
  
**3 methods**

1. **Via summarization**

Use word not-advertise - then summary will not be sent to other area. We may use it not for all summary but only for one network:

```
area 12 range 192.168.1.0 255.255.255.0 not-advertise
```

2. **Area filtering**

  - Filtering happens before sending or receiving route
  - Prefix list is used

Router will not send LSA-3 to area 2 about 192.168.3.0/24 from area 0

```
ip prefix-list TEST deny 192.168.3.0/24
ip prefix-list TEST permit 0.0.0.0/0 le 32

router ospf 1
area 2 filter-list prefix TEST in
```

The same but using different approach: 192.168.3.0/24 will be blocked from Area 0 to all areas

```
area 0 filter-list prefix TEST out
```

After this route will dissapear from LSA database and routing table on all routers after ABR

3. **Local OSPF filtering**

- Route is in LSDB, but not installed in RIB 
- Distribute list is used
- It is applied to all ospf process, not to area
- It prevents route from installing to RIB
- It can be used on any router, not only on ABR/ASBR, even inside area 
- Distribute list can use ACL, prefix list, Route Map
- Word IN is always used
- Word OUT is used for filtering LSA type 5
 
This configuration will remove 192.168.1.0/24 from RIB

```
access-list 1 deny 192.168.1.0 0.0.0.255
access-list 1 permit any

router ospf 1
distribute-list 1 in
```

## Route types in Cisco

6 in total

- O - inside area - LSA-1 + LSA-2
- IA - Inter Area - LSA-3
- N1 - NSSA external type 1
- N2 - NSSA external type 2
- E1 - external type 1 - preffered over Type 2 - redistribution metric + tptal path metric to ASBR
- E2 - external type 2 - always equals to redistribution metric

## Default route

Default route is sent via different LSAs, depending on Area type:

- LSA 5 - in normal Areas
- LSA 3 - in stub & totally-stub area
- LSA 7 - in NSSA
- ? - In a NSSA-totally-stub area

Default route is required to be advertised

## Configuration

**Nexus**  

- Interface point to point is necessary on Loopback  
- It is better to configure RID manually - so it will not be changed  
- Network command can be excessive  
- IP OSPF area command on interface  

```text
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

**IOS**

```text
interface loopback 1
ip address 2.2.2.2 255.255.255.255
router ospf 2
network 10.1.12.2 0.0.0.0 area 1
network 10.1.0.0 0.0.255.255 area 0
network 10.0.0.10 0.0.0.0 area 0 - explicit only one IP - only on interface
network 0.0.0.0 255.255.255.255 area 0 - all interfaces
passive-interface ethernet 0/1
passive-unterface default
no passive-interface ethernet 0/1 - when default is enabled
default-information originate
```

**Send default route to OSPF domain**

```
router ospf 1
  default-information originate
```


**IOS interface specific configuration**

```
interface GigabitEthernet 0/0
  ip ospf 1 area 0
```

**IOS VRF**

```
router ospf 1 vrf Red
network 0.0.0.0 255.255.255.255 area 0
!
router ospf 2 vrf Green
network 0.0.0.0 255.255.255.255 area 0
```

**Change default reference bandwidth** 

```
auto-cost reference bandwidth 200 mmps
```

**Change interface cost**

```
ip ospf cost 10
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

**Restart OSPF process**

```
clear ip ospf process
```

## Virtual Links

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

**Show all OSPF configuration details**

```
r1#show ip ospf
 Routing Process "ospf 1" with ID 1.1.1.1
 Start time: 00:00:05.210, Time elapsed: 01:01:28.848
 Supports only single TOS(TOS0) routes
 Supports opaque LSA
 Supports Link-local Signaling (LLS)
 ...
```
**Show OSPF interfaces in detail: up/down/disabled/timers/DR/BDR/area/**

```
Router#show ip ospf interface

Ethernet0/3 is up, line protocol is up
  Internet Address 192.168.1.1/30, Area 0, Attached via Network Statement
  Process ID 1, Router ID 192.168.1.1, Network Type BROADCAST, Cost: 10
  Topology-MTID    Cost    Disabled    Shutdown      Topology Name
        0           10        no          no            Base
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 192.168.1.1, Interface address 192.168.1.1
  Backup Designated router (ID) 192.168.1.2, Interface address 192.168.1.2
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    oob-resync timeout 40
    Hello due in 00:00:04
  Supports Link-local Signaling (LLS)
  Cisco NSF helper support enabled
  IETF NSF helper support enabled
  Index 1/1/1, flood queue length 0
  Next 0x0(0)/0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 2
  Last flood scan time is 0 msec, maximum is 6 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 192.168.1.2  (Backup Designated Router)
  Suppress hello for 0 neighbor(s)
```

**List interfaces, where OSPF is enabled based on network command, omitting passive interfaces. Show all costs**

```
show ip ospf interface brief

Interface    PID   Area            IP Address/Mask    Cost  State Nbrs F/C
Et0/1        1     0               10.1.1.1/24        10    DR  0/0
Et0/3        1     0               192.168.1.1/30     10    DR    1/1
```

- State: DR, BDR, DROTHER, LOOP, Down  
- Nbrs F - fully adjacent neighbors  
- Nbrs C - number of neighbors in 2Way state

**Show neighbor table: neighbor priority, state of adjecency, DR state of neighbor, dead time, address, local interface**

```
Router#show ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
192.168.1.2       1   FULL/BDR        00:00:33    192.168.1.2     Ethernet0/3
```

**Show OSPF routes installed to RIB**

```
Router#show ip route ospf
Codes: L - local, C - connected, S - static, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2
       i - IS-IS, su - IS-IS summary, L1 - IS-IS level-1, L2 - IS-IS level-2
       ia - IS-IS inter area, * - candidate default, U - per-user static route
       o - ODR, P - periodic downloaded static route, H - NHRP, l - LISP
       a - application route
       + - replicated route, % - next hop override, p - overrides from PfR

Gateway of last resort is not set

      10.0.0.0/8 is variably subnetted, 3 subnets, 2 masks
O        10.1.3.0/24 [110/20] via 192.168.1.2, 3d23h, Ethernet0/3
```

- 110 - administrative distance
- 20 - OSPF cost

**Show all OSPF routes in OSPF RIB**

```
Router#show ip ospf rib

            OSPF Router with ID (192.168.1.1) (Process ID 1)


		Base Topology (MTID 0)

OSPF local RIB
Codes: * - Best, > - Installed in global RIB

*   10.1.1.0/24, Intra, cost 10, area 0, Connected
      via 10.1.1.1, Ethernet0/1
*>  10.1.3.0/24, Intra, cost 20, area 0
      via 192.168.1.2, Ethernet0/3
*   192.168.1.0/30, Intra, cost 10, area 0, Connected
      via 192.168.1.1, Ethernet0/3
*>  192.168.4.0/24, Inter, cost 20, area 0
      via 192.168.1.2, Ethernet0/3
*>  192.168.5.0/24, Inter, cost 30, area 0
      via 192.168.1.2, Ethernet0/3
```

**Show how many LSAs of each type in a database**

```
Router#show ip ospf database database-summary

            OSPF Router with ID (192.168.1.1) (Process ID 1)

Area 0 database summary
  LSA Type      Count    Delete   Maxage
  Router        2        0        0
  Network       1        0        0
  Summary Net   2        0        0
  Summary ASBR  0        0        0
  Type-7 Ext    0        0        0
    Prefixes redistributed in Type-7  0
  Opaque Link   0        0        0
  Opaque Area   0        0        0
  Subtotal      5        0        0

Process 1 database summary
  LSA Type      Count    Delete   Maxage
  Router        2        0        0
  Network       1        0        0
  Summary Net   2        0        0
  Summary ASBR  0        0        0
  Type-7 Ext    0        0        0
  Opaque Link   0        0        0
  Opaque Area   0        0        0
  Type-5 Ext    0        0        0
      Prefixes redistributed in Type-5  0
  Opaque AS     0        0        0
  Non-self      3
  Total         5        0        0
```

**Show all LSA-3**

```
Router#show ip ospf database summary

            OSPF Router with ID (192.168.1.1) (Process ID 1)

		Summary Net Link States (Area 0)

  LS age: 1707
  Options: (No TOS-capability, DC, Upward)
  LS Type: Summary Links(Network)
  Link State ID: 192.168.4.0 (summary Network Number)
  Advertising Router: 192.168.1.2
  LS Seq Number: 80000001
  Checksum: 0xF068
  Length: 28
  Network Mask: /24
	MTID: 0 	Metric: 10

  LS age: 1707
  Options: (No TOS-capability, DC, Upward)
  LS Type: Summary Links(Network)
  Link State ID: 192.168.5.0 (summary Network Number)
  Advertising Router: 192.168.1.2
  LS Seq Number: 80000001
  Checksum: 0x4A04
  Length: 28
  Network Mask: /24
        MTID: 0 	Metric: 20
```
**Show how many types OSPF was launched and area type**

```
show ip ospf
```

Show?

```
show ip protocols
```

**List all LSAs for all connected areas**

```
show ip ospf database
```

**Show LSAs from one particular router**
```
sh ip ospf database router 192.168.2.2
```

**Show virtual links**  
To prove whether the virtual link works, a neighbor relationship between C1 and C2 must reach the FULL state, resulting in all routers in both parts of area 0 having the same area 0 LSDB.
```
show ip ospf virtual-links
```

## Debug

```
debug ip ospf adj
debug ip ospf hello
debug ip ospf events

undebug all
```

## Wireshark display filters

**Show only LSU packets**

```
ospf and ip.src==192.168.2.2 and ospf.msg.lsupdate
```

**Show only LSA-1**

```
ospf.lsa == 1
```

**Show packets from particular source router - not origin router, but router who sent packet**

```
ospf.srcrouter == 192.168.3.1 
```

**From particular advertising router**

```
ospf.advrouter == 3.3.3.3
```

# OSPF v3

- Separate instances for OSPFv2 and OSPFv3
