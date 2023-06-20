# OSPF

Everything I need to know about OSPF in one place.

## Additional reading

- OSPF: Anatomy of an Internet Routing Protocol
- Routing TCP/IP Volume 1
- Cisco IP Routing: Packet Forwarding and Intra-domain Routing Protocols
- OSPF Technology Documentation
- OSPF Configuration Guide

## Standards

- RFC 2328 "OSPF Version 2"
- RFC 5340 "OSPF for IPv6"

## Main features to know

- DR/BDR
- Area types
- Virtual links
- LSA types

## Typical tasks

- Add network to OSPF domain - network command
- Add router to OSPF domain
- Redistribute routes to OSPF domain
- Make one path preferable - using cost
- Summarize routes


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
- BDR - BAckup Designated Router  
- DBD - Database Descriptor packets - The DBD packets are OSPF packet Type 2. The OSPF router summarizes the local database and the DBD packets carry a set of LSAs belonging to the database
- Stub network: A subnet on which a router has not formed any neighbor relationships.

## Concepts

- Open standard, IGP, Link-state, classless (VLSM, Summarization), Dikstra SPF Algorithm, guaranties loop free, hierarchi through areas - large scalability, topology summarization, interopeability between vendors
- Router knows all network and builds a tree - The algorithm places each router at the root of a tree
- OSPF runs directly over IPv4, using its own protocol 89, which is reserved for OSPF by the Internet Assigned Numbers Authority (IANA)
- Each router has its own view of the topology even though all the routers build a shortest path tree which uses the same link-state database
- OSPF is very good for traffic engineering in ISP with MPLS
- IPv4 and IPv6
- Supports multiple forms of authentication: Clear Text, MD5, SHA, IPsec, etc.
- Main cons is bad performance when many hosts - high CPU load - several thousand prefixes max - because every router has to calculate a tree
- Operates in one Autonomous System
- LSDB is identical on all routers in 1 area
- Administrative distance 110
- Metric is cost, cost is dependent on bandwidth of the link, cost is inversly proportional to the bandwidth, the greater the bandwidth the less the cost, the better the path, cost=Reference bandwidth/100 in Mbps - More flexible than static hop count
- Loops are impossible inside the area because every router knows all topology. And between areas all areas have to be connected to area 0, so loops are avoided as well like in distance vector
- One area - 500 routers
- A router can run multiple OSPF processes. Each process maintains its own unique database, and routes learned in one OSPF process are not available to a different OSPF process with- out redistribution of routes between processes. The OSPF process numbers are locally sig- nificant and do not have to match among routers. Running OSPF process number 1 on one router and running OSPF process number 1234 will still allow the two routers to become neighbors
- Metric is based on cumulitive cost of all outgoing interfaces, the lower the mitric the better, it is a price of the route
- No hop limit
- All networks are connected via backbone areas to avoid loops
- Hello interval - router sends Hello messages
- Dead timer - after it neighboor is considered dead
- Route tags- tag routes as they are redistributed into OSPF
- Next-hop field - supports the advertisment of routes with a different next-hop router than the advertising router
- Manual route summarization - summarization is supported on ABR only
- If there is an topology change - router sends LSA, if no changes LSAs are sent every 30 mins
- Each router stores the data, composed of individual link-state advertisements (LSA) , in its own copy of the link-state database (LSDB) . Then, the router applies the Shortest Path First (SPF) algorithm to the LSDB to determine the best (lowest-cost) route for each reachable subnet (prefix/length) 

## Design

We have to think through the following:

- IP networks between routers - /31 is ok
- Loopback interfaces and Router-IDs - loopback is actually not needed if we configure router-id manually, which is recomended. Loopback numbers on all devices.
- Authentication
- Areas
- Network types
- Process ID - it has local significance, it is better to use the same ID on all devices
- Timers, maybe it is better to harden them

## Two OSPF links between sites via IPSec link

- In order to make one link primary - we need to change its cost: either directly via interface command, on indirectly via changing bandwidth

## Data centre CLOS specifics

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
- If the IP address for an interface matches two network statements with different areas, the most explicit network statement (that is, the longest match) preempts the other network statements for area allocation
- The connected network for the OSPF-enabled interface is added to the OSPF LSDB under the corresponding OSPF area in which the interface participates. Secondary connected net- works are added to the LSDB only if the secondary IP address matches a network statement associated with the same area
- Enable OSPF on required interfaces and specify area - on Nexus
- Enable OSPF on loopback to announce it

## Neighbor & Topology Discovery, Adjacency

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

## Packet flow during adjecency

- R1 sends Hello - multicast - 224.0.0.5
- R2 gets Hello and sends DB description packet without anything useful - unicast
- R2 also sends Hello Packet
- R1 sends many DB descriptions packets to R2 with very weird content
- R2 sends LS request where it provides Link State ID - Router ID of R1 - unicast
- R1 sends LS update, where there are 2 LSA type 1 - for both networks which are directly connected to R1, including the network between routers
- 



### Unique OSPF Adjacency Attributes

- Router-ID - 32 bit number, must be unique.
  - Manual configuration
  - Highest active Loopback IP
  - Highest active Interface IP
- Interface IP Address
  - For OSPFv2 the interface's primary IP address 
  - For OSPFv3 the interface's link-local address

### Common OSPF Adjacency Attributes

- Interface Area-ID
- Hello interval & dead interval
- Interface network address
- Interface MTU
- Network Type
- Authentication
- Stub Flags
- Other optional capabilities

### Neighbor states - OSPF Adjacency State Machine - 8 states**

- Down - initial state - No hellos have been received from neighbor
- Attempt - for NBMA networks, if does not get updates from neighboor - try to reach it
- Init - I have received a hello packet from a neighbor, but they have not acknowledged a hello from me
- 2-Way - communication established, DR/BDR is elected, if needed
    - I have received a hello packet from a neighbor and they have acknowledged a hello from me
    - Indicated by my Router-ID in neighbor's hello packet
- Exstart - master/slave is chosen based on Router ID - where master has higher Router-ID - First step of actual adjacency - Master chooses the starting sequence number for the Database Descriptor (DBD) packets that are used for actual LSA exchange
- Exchange
    - Local link state database is sent through DBD packets
    - DBD sequence number is used for reliable acknowledgement/retransmission
- Loading - LSR packets are sent to the neighbor, asking for the more recent LSAs that have been discovered (but not received) in the Exchange state
- Full - Neighbors are fully adjacent and databases are synchronized

To see the state of adjecency: 

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
- Inside area - detailed route exchange  
- Outside area - brief exchange  
- Area 0 backbone area - is connected to all areas and all thraffic goes via it  
- In general, NSSA is same as normal area except that it can generate LSA Type 7 (redistribute from another domain)  
- Every area has its own LSDB
- ABR does not pass denser and more detailed type 1 and 2 LSAs from one area to another—instead, it passes type 3 summary LSAs
- OSPF always chooses an intra-area route over an inter-area route for the same prefix, regardless of metric
- ABRs ignore type 3 LSAs learned in a nonbackbone area during SPF calculation, which prevents an ABR from choosing a route that goes into a nonbackbone area and then back into the backbone

Note that these conditions can result in both asymmetric routing and suboptimal routing across multiarea OSPF networks.
  
Using areas provides the following benefits:

- Generally smaller per-area LSDBs, requiring less memory.
- Faster SPF computation thanks to the sparser LSDB
- A link failure in one area only requires a partial SPF computation in other areas
- Routes can be summarized and filtered only at ABRs (and ASBRs). Having areas permits summarization, again shrinking the LSDB and improving SPF calculation performance

Area types:

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

## Tables

- Neighbor table
- Topology table - all routes
- Routing table - best routes

## Loopback intefaces

OSPF treats Loopback interfaces as STUB NETWORKS and advertise them as HOST ROUTES (with mask /32) regardless of their configured/native mask. According to RFC 2328, Host routes are considered to be subnets whose mask is "all ones (0xffffffff)".  
A router with one loopback interface generates a router-LSA with Type-1 link (stub network).

## LSA

- All LSAs contain Link state ID and Advertising router(RID)
- Only a router that has originated a particular LSA is allowed to modify it or withdraw it
- Other routers must process and flood this LSA within its defined flooding scope if they recognize the LSA’s type and contents, but they must not ever change its contents, block it, or drop it before its maximum lifetime has expired
- Summarization and route filtering can be done in a very limited fashion, unlike in distance vector protocols, where summarization and route filtering can be performed at any point in the network

LSA types:

- 1 - Router LSA
   - Contains all links with IPs, masks and metrics, link type, and a list of neighboring routers (in that area) on each interface
   - Flooded only within its area of origin, represents stub networks as well
   - Does it contain connected routers?
   - We see this as “O” routes in the routing table
- 2 - Network
  - Used in transit broadcast of NBMA Network: network, where several routers are connected, and where DR exists
  - Created by DR 
  - Flooded only inside area
  - It includes the network ID, subnet mask and also the list of attached routers in the transit
  - We see this as “O” routes in the routing table
- 3 - Net Summary - Created by ABR, represent subnets listed in one's area LSA 1 and 2 to advertise to another area. Defines links(subnets) and costs , but no topology, goes between areas. We see them as “OIA” routes.
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

This is a per interface setting  
Ethernet is broadcast by default   
Network type influences DR/BDR, timers, Hello types(multicast/unicast), Updates(multicast, unicast)

- Point to point - Frame Relay by default
- Broadcast  
- Loopback  
- Nonbroadcast - NBMA - Frame Relay by default
- Point to multipoint - used in hub and spoke  
- Point to multipoint non broadcast  
- All interfaces will be point to point in CLOS network  
- Interface command or configure priority for DR/BDR - 0


## OSPF packet

High-level view on OSPF packet

```text
Open Shortest Path First
    OSPF Header
        Version: 2
        Message Type: LS Update (4)
        Packet Length: 400
        Source OSPF Router: 4.4.4.4
        Area ID: 0.0.0.20
        Checksum: 0xd794 [correct]
        Auth Type: Null (0)
        Auth Data (none): 0000000000000000
    LS Update Packet
        Number of LSAs: 11
        LSA-type 1 (Router-LSA), len 48
        LSA-type 1 (Router-LSA), len 36
        LSA-type 2 (Network-LSA), len 32
        LSA-type 3 (Summary-LSA (IP network)), len 28
        LSA-type 3 (Summary-LSA (IP network)), len 28
        LSA-type 3 (Summary-LSA (IP network)), len 28
        LSA-type 4 (Summary-LSA (ASBR)), len 28
        LSA-type 5 (AS-External-LSA (ASBR)), len 36
        LSA-type 5 (AS-External-LSA (ASBR)), len 36
        LSA-type 5 (AS-External-LSA (ASBR)), len 36
        LSA-type 5 (AS-External-LSA (ASBR)), len 36

```

LSA-1 packet

```text

LSA-type 1 (Router-LSA), len 48
    .000 0001 1011 1110 = LS Age (seconds): 446
    0... .... .... .... = Do Not Age Flag: 0
    Options: 0x22, (DC) Demand Circuits, (E) External Routing
    LS Type: Router-LSA (1)
    Link State ID: 5.5.5.5
    Advertising Router: 5.5.5.5
    Sequence Number: 0x80000004
    Checksum: 0x7caa
    Length: 48
    Flags: 0x00
    Number of Links: 2
    Type: Stub     ID: 192.168.20.0    Data: 255.255.255.0   Metric: 10
        Link ID: 192.168.20.0 - IP network/subnet number
        Link Data: 255.255.255.0
        Link Type: 3 - Connection to a stub network
        Number of Metrics: 0 - TOS
        0 Metric: 10
    Type: Transit  ID: 10.0.20.2       Data: 10.0.20.2       Metric: 10
        Link ID: 10.0.20.2 - IP address of Designated Router
        Link Data: 10.0.20.2
        Link Type: 2 - Connection to a transit network
        Number of Metrics: 0 - TOS
        0 Metric: 10

```

## OSPF packets

OSPF packet consists of:

- OSPF header
- OSPF packet
- OSPF LLS Data Block - ?

There are 5 different types of OSPF packets:

- 1 - Hello - discover and maintain neighbors. Are sent periodically via all interfaces to discover new neighbors and test existing
- 2 - DBD - Database Description - summer of database, during first adjecency
- 3 - LSR - Link State Request - request a portion of neighbors database
- 4 - LSU - Link State Update - contains LSA - sent in direct response to LSR
- 5 - Link State Acknowledgment - acknowledge of LSA

### OSPF header

OSPF header is included in any OSPF packet

- Destination MAC: 01:00:5e:00:00:05
- Destination IP: 224.0.0.5
- IP type: 89
- Message type: Hello - 1
- Router ID
- Area ID - 0.0.0.0 - The OSPF area that the OSPF interface belongs to. It is a 32-bit number that can be written in dotted-decimal format (0.0.1.0) or decimal (256)
- Auth Data

### Hello Packet

OSPF routers periodically send Hello packets out OSPF enabled links every Hellolnterval 

- Network mask
- Hello interval
- Router priority
- Dead interval
- DR: interface address itself
- BDR: 0.0.0.0
- Options (e.g. stub flags, etc.)
- Router IDs of other neighbors on the link - ??

## Router types

- Internal - all interfaces are in one area
- ABR - Area Border Router - connects one or more areas to area 0
- ASBR - Autonomous System Border Router - connects with other autononomous systems or non-OSPF routers
- Backbone - router with at least one interface in area 0

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

## DR/BDR

- Main goal is to avoid LSA flooding
- DR/BDR are chosen based on hello messages in broadcast segment
- Non-DR and non-BDR routers only exchange routing information with the DR and BDR, rather than exchanging updates with every other router upon the segment. This, in turn significantly reduces the amount of OSPF routing updates that need to be sent
- In the event of DR failure, a backup designated router (BDR) becomes the new DR; then an election occurs to replace the BDR
- Only DR generates type 2 LSAs
- To minimize transition time, the BDR also forms full OSPF adjacencies with all OSPF routers on that segment
- All OSPF routers (DR, BDR, and DROTHER) on a segment form full OSPF adjacencies with the DR and BDR
- As an OSPF router learns of a new route, it sends the updated LSA to the AllDRouters (224.0.0.6) address, which only the DR and BDR receive and process
- The DR sends a unicast acknowledgment to the router that sent the initial LSA update
- The DR floods the LSA to all the routers on the segment via the AllSPFRouters (224.0.0.5) address

Elections:

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
- Priority 0 - router does not pretend on DR
- Modifying a router’s RID for DR placement is a bad design strategy. A better technique involves modifying the interface priority to a higher value than the existing DR has
- Remember that OSPF does not preempt the DR or BDR roles, and the OSPF process might need to be restarted on the current DR/BDR for the changes to take effect

Show DR/BDR

```
R1# show ip ospf interface brief
```

Configure interface priority on IOS

```
R1(config-if)# ip ospf priority 100
```

Show all neighbors, their priority, state of adjecency with them, their status: DR, BDR, or DROTHER

```
R2# show ip ospf neighbor
```

Restart OSPD processes to change DR/BDR after changing priority

```
R3# clear ip ospf process
```

## Authentication

- NUll - without auth
- Clear text
- MD5

## Cost

- Cost = Reference Bandwidth/Interface Bandwidth
- IOS default reference bandwidth 100 mbit/s
- NX-OS default reference bandwidth 40 gbit/s

## Virtual links

- They are used when there are two area 0, and with them both area 0 are connected with each other. It can happen if 2 companies are merged
- A virtual link is not a tunnel for data packets; rather, it is a targeted session that allows two remote routers within a single area to become fully adjacent and synchro- nize their LSDBs. The virtual link is internally represented as an unnumbered point-to- point link between the two endpoint routers and exists in the backbone area, regardless of the area through which it is created. The area through which the virtual link is created is called a transit area and it must be a regular area: As no tunneling is involved, packets routed through this transit area are forwarded based on their true destination addresses, requiring the transit area to know all networks in the OSPF domain, intra-area, inter-area, and external
- 

## OSPFv3

Separate instances for OSPFv2 and OSPFv3

## Configuration

### Nexus  

- Interface point to point is necessary on Loopback  
- It is better to configure RID manually - so it will not be changed  
- Network command can be excessive  
- IP oSPF area command on interface  

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

### IOS

```text
interface loopback 1
ip address 2.2.2.2 255.255.255.255
router ospf 2
network 10.1.12.2 0.0.0.0 area 1
network 10.1.0.0 0.0.255.255 area 0
network 10.0.0.10 0.0.0.0 area 0 - explicit only one IP - only on interface
network 0.0.0.0 255.255.255.255 area 0 - all interfaces
```

### IOS VRF

```
router ospf 1 vrf Red
network 0.0.0.0 255.255.255.255 area 0
!
router ospf 2 vrf Green
network 0.0.0.0 255.255.255.255 area 0
```

### Change default reference bandwidth 

```
auto-cost reference bandwidth 
```

### Remove router from the network for maintenence

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

### Virtual Links

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