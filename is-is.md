# IS-IS

## Concepts

- Which networks are advertised by default???
- Intermediate System to Intermediate System, there is also ES-IS: End system to Intermediate System in OSI world
- Initially created for OSI networks
- ISO was working on it at the same time as Internet Architecture Board (IAB) was working on OSPF. People thought that IS-IS will replace OSPF and that TCP/IP is temporary, OSI stack will be used instead
- Integrated IS-IS or Dual IS-IS - provides both routing for IP and CLNS
- At the end IETF adopted OSPF as recomended IGP
- Mostly used in high-end ISP
- Uses so-called Network Service Access Point (NSAP) addressing
- Designed to provide Level 1 (intra-area) and Level 2 (inter-area) routing according to OSI routing hierarchies
- First implementation is made by Digital Equipment Corporation for DECnet Phase 5
- IGP
- Link state routing protocol
- Two level hierarchical 
- Classless
- Dijkstra Shortest Path First (SPF) algorithm, it was conceived by computer scientist Edsger W. Dijkstra(scientist from Netherlands) in 1956 and published three years later.
- Address summarzation between areas
- Designated router to represent broadcast networks
- Network Entity Title (NET) is configured on every router. It is NSAP address in which the SEL octet is set to 0. In NET we specify format - 49, AS, area and system ID 
- Supports authentication
- It was conceived by computer scientist Edsger W. Dijkstra(scientist from Netherlands) in 1956 and published three years later.
- IS-IS does not run over any network layer protocol
- It encapsulates its messages directly into data-link frames - Uses Ethernet v1 - 802.3 - Logical link control and then IS-IS packet
- Adjacency and addressing information in IS-IS messages is encoded as Type-Length-Value (TLV) records
- If we need to add new address family we just need to add new TLV
- Subnetwork Point of Attachement - interface attached to a subnetwork
- Protocol Data Unit (PDU) - data passed from one peer to another
- Data Link PDU - frame
- Network PDU - packet
- Link State PDU - LSP - The same as OSPF LSA
- Whole router should be in the same zone - all interfaces - if it is connected with a router from different area - then it is L2 router
- IS-IS backbone area is a level 2 area, other areas are Level 1
- It is worse than OSPF because it canot be used over VPN, it does not use IP, even in L2 VPNs it may not work because of Ethernet v1
- All areas do not have to be connected to area 0 as in OSPF - it is possible: Area 1 - Area 2 - Area 3. The only condition: all areas have to be connected via L2 adjency, for example Area 1 router > L2 > Area 2 router > L2 >  Area 2 router > L2 > Area 3 router
- L2 connections should be continious through all areas
- We can connect all areas with each over - it is ok

## Pros and cons

- Supports more devices in one area than OSPF
- Very quick convergence, because very short adjency process - only 3 steps
- No many type of LSAs like in OSPF, one LSP for all updates

## Design


## Data centre design

- Different areas for PODS, L1 inside pod, L2 between pods and superspine
- Distributed spreading of LSP - dynamic flooding - primary and secondary leader for area
- If only one area is used - we may use L2 for all adjemcies, just for comfort, so we can use filtering
- For every router we configure different or the same area and System ID???

## Router types

- L1 - as OSPF internal
- L2 - as OSPF backbone
- L1/2 - as OSPF ABR - maintain both link state database for level 1 and level 2

## Metrics

- Default: Required to be supported by all IS-IS implementations; usually relates to the bandwidth of the link (higher value represents a slower link)
- Delay: Relates to the transit delay on the link
- Expense: Relates to the monetary cost of carrying data through the link
- Error: Relates to the residual bit error rate of the link

Each metric is evaluated independently and separate SPF calculation for each, and thus routing table.  
Only default is used today.  
Cisco assignes all interfaces default metric 10. It is up to admin to change it accordingly. 
Initially mteric was 6 bits wide, range was 1-63.  
The complete path metric as 10 bits wide in the range of 1–1023.  
Wide metrics were introduced: 24 bits for interface and 32 bits for entire path metric.  
It is strongly recommended to use wide metrics.  
All routers in an area must use the same type of metrics.  

## Adjacency

For each routing level, be it Level 1 or Level 2, an IS-IS router establishes separate adjacencies with its neighbors running on the same level, and maintains a separate link-state database.  
Two neighboring routers configured for both Level 1 and Level 2 routing will create two independent adjacencies, one for each level. In addition, as each router belongs to a single area (recall that only a single NET is usually configured on a router, and the NET carries the area identifier), Level 1 adjacencies are created only between routers with the same area identifier.  
Routing information may be injected between L1 and L2 LSDB.  

**Neighbor States**

- Down: The initial state. No IIHs have been received from the neighbor
- Init: IIHs have been received from the neighbor, but it is not certain that the neighbor is properly receiving this router’s IIH.
- Up: Now it’s confirmed that neighboring router is receiving local router’s hellos. 
  
  
- Three packets are sent: A sends  HELLO to B(INIT), B sends HELLO to A and then A sends another HELLO to B
- TLV "IS Neighboor" means that it is a reply on HELLO
- All frames are sent to multicast MAC
- Also there is a Sender MAC adress in HELLO reply
- Level and area number are specified in hello
- HELLO packets also work as a keep alive packets
- System ID - the same as router ID - is written in the form of MAC
- Holding timer - maybe different on different routers
- PDU length - 1497 bytes - Ehernet frame is 1514 bytes
- Priority - for choosing DR - Designated IS - DIS
- And then go TLVs inside HELLO, every TLV has its own number and information
- IP addresses are inside hello as well

## Packet types

- Hello - IS-IS Hello - IIH
- Link State PDU
- Complete Sequence Numbers PDU
- Partial Sequence Numbers PDU

## Hello packet

- Three types of Hello: Level 1 Hello, Level 2 Hello (both used on broad- cast networks), and L1L2 Hello (used on point-to-point interfaces) 
- Detecting neighbors and their loss, verifying bidirectional visibility, establishing and maintaining adjacencies, electing a Designated IS
- On broadcast-type interfaces, IS-IS routers use separate Hello packet types for L1 and L2 adjacencies
- On point-to-point type interfaces, for efficiency reasons, a single L1L2 Hello, also called a point-to-point Hello, is used
- Each router sends Hello packets every 10 seconds by default
- Instead of defining a Hold timer directly, a Hello multiplier value is used to compute the Hold time as the Hello value multiplied by the Hello multiplier value
- The default Hello multiplier value is 3, Hold time = 30 sec
- On a DIS, the individual timers are always one-third of the configured timers

## Link state PDU

- Contains routing information and updates
- Only one LSP for all changes, no LSA types like for LSA
- Two types of LSP:
  - Level 1 - for connected networks
  - Level 2 - all prefixes of one area - Level 1/2 router aggregates all L1 LSPs, summarize them and sends to L2 neighboor.
 - They are described by distinct Type-Length- Value (TLV) records inside an LSP’s variably sized payload
 - LSPs are also uniquely identified by:
    - System ID of the router that originated this LSP (6 octets; taken from the router’s NET address)
    - Pseudonode ID that differentiates between the LSP describing the router itself and the LSPs for multiaccess networks in which the router is a Designated IS (1 octet)
 - LSP Number denoting the fragment number of this LSP (1 octet). The LSP Number is also called simply the Fragment Number or Fragment for short.
 - We will denote this triplet of System ID + Pseudonode ID + LSP Number as LSPID
 - For LSPs that describe routers themselves, the Pseudonode ID is always set to 0

## Areas

- Only a single NSAP address is assigned to a node, and the NSAP address contains the domain and area identifier, the entire node with all its interfaces belongs only to a single area
- L1/L2 router sends the default route in L1 Area, so that the L1 routers can reach the other parts of the network.  
- It is in fact possible to configure up to three different NSAP addresses on an IS-IS router in a single IS-IS instance, provided that the System ID in all NSAP addresses is identical and the NSAP addresses differ only in their Area ID. A router with multiple NSAP addresses will nonetheless maintain only a single link-state database, caus- ing all configured areas to merge together. This behavior is useful when splitting, joining, or renumbering areas.
- For example, when you are renumbering an area, all routers are first added a second NSAP address with the new Area ID and then the old NSAP address is removed—without causing any adjacencies between routers to flap
- Multiple NSAP addresses on an IS-IS instance are nonetheless used only during network changes, and in stable operation, there should be only a single NSAP address configured per IS-IS process
- Each L2 router advertises its directly connected IP networks to achieve contig- uous IP connectivity in the backbone, plus all other L1 routes from its own area with appropriate metrics, to advertise IP networks present in particular areas
- IP routing information flows from L1 into L2. There is no opposite flow of routing information
- L1 routers in an area have a visibility identical to routers in an OSPF Totally Stubby Area—they see their own area but nothing more. Yet, an L1 router can still perform redistribution from external sources, and these redistributed networks will be visible both in that area and uptaken by L2 routers into the backbone. Therefore, L1 routers in an area behave more as if they were in an OSPF Not So Stubby-Totally Stubby (NSSA-TS) area
- L2 routers create adjacencies with other L2 routers regardless of the area ID, and share all information present in their L2 link-state databases. Therefore, the entire L2 subdomain across all areas in the entire domain can be likened to a single OSPF backbone area
- IS-IS on Cisco routers defaults to L1L2 operation, meaning that both L1 and L2 routing are enabled by default
- Separate L2 LSDB

## Packet flow - to be created

## Timers

- MaxAge, a.k.a. RemainingLifetime - The maximum remaining lifetime of an without receiving a newer copy of the LSP, before the LSP expires. Default is 1200 seconds
- ZeroAgeLifetime - The minimum time an LSP must be retained in the link-state database after expiring or initiating an LSP purge. Default is 60 seconds
- Hello - Per interface; time interval between Hellos. Default is 10 seconds. Independent for L1 and L2 Hellos on broadcast interfaces
- Hold - Per interface; time interval in which a Hello should be received from a neighbor. If not received, the neighbor is considered to have failed. Default is three times Hello
- CSNP Interval - Per interface; defines the time interval between sending consecutive CSNP packets if the router is a DIS on that interface. Defaults to 10 seconds

## Designated Intermediate System - DIS

Elected based on:
- Priority
- MAC - bigger wins 
---------
- No Backup DIS
- DIS sends its actual LSDB every 30 secs to all neighbors, all of them with actual LSDB will ignore them, excepts those with broken or incomplete one
- Adjencies are full mesh anyway, they all send updates to each over
- Priority=0 - DOES NOT exclude device from elections
- Reelections when new device added
- Different DIS for Level 1 and 2
- Priority=64 by default
- If link is P2P, DIS can be disabled, by changing interface type, the same as for OSPF

## Type-Length-Value (TLV)

- They exist in HELLO and in LSP
- There are many types of them, every type carry its own data
- Extended IP reachability -  type 135 - iformation about prefixes

## Configuration

**Nexus**

```
feature isis
router isis isis
net 49.0011.0001.0001.0001.00
# 49 - const, 0011 - area, 0001.0001.0001 - Sys ID, 00 - nselector, should be always 00
is-type level-2

interface Ethernet1/2
  ip router isis isis
  #Optional level for inrterface
  isis circuit-type level-2
```

## Verification to be continued

**Show database as a list of LSPs**

```
show isis database l2
```

Show which routes we got from particular router using LSPID
```
show isis database detail leaf-1.00-00
```

```
show ip protocols
show ip route isis

show isis database
show isisdatabase level-1 verbose
show isis neighbors
show isis dynamic-flooding
show isis dynamic flooding detail
```