# BGP

## History

- It was first described in 1989
- In use on the Internet since 1994
- The current version of BGP is version 4 (BGP4)

## RFC

- RFC 4271 - 2006
- RFC 2283 - IPv6 - 1998
- RFC 2858 - MP-BGP
- RFC 7938 - Use of BGP for Routing in Large-Scale Data Centers: private ASN, single-hop, AS numbering to avoid path hunting, timers hardening, BFD

## Books

- Google Talks - BGP at 18: Lessons In Protocol Design - Dr. Yakov Rekhter, co-designer of BGP
- Cisco Live 365 BRKRST-3321 Scaling BGP

## Main features

- Path attributes
  - AS_Path
  - Origin
  - MED
  - Local preference
- Communities
  - Route target
- MP-BGP: MPLS L3VPN, EVPN, IPv6
  - Route distinguisher
- eBGP and iBGP
- iBGP - shares only once to iBGP
  - Full mesh
  - Route reflector
    - Route reflector cluster
    - Virtual route reflector
  - Confiderations
  - IGP recursion
- eBGP - TTL 1

## Concepts

- Routing protocol that is used to exchange network layer reachability information (NLRI) between routing domains
- Path vector routing protocol
- 2 BGP processes with different AS on one router - ?
- BGP is not a routing protocol: BGP is an application used to exchange NLRI, IPv4, IPv6, l2vpn, VPnv4...All data in a packet is presented in the form of Path attributes, all these make it very flexible
- For different addresses different AFI/SAFI numbers are used
- IPV4 NLRI contains..
    - Prefix/len
    - Attributes
      - Local-pref, AS-Path, MED, etc.
  - Next-Hop
- Internet de facto protocol, Routing protocol of Intenet, Port 179 TCP, EGP
- BGP knows the next-hop but not the outgoing interface
- IGP must be able to perform recursion otherwise the route cannot be used
- It is not binded to interface, we just configure neighbors and then connect to them according to routing table
- It does not use metric like IGP to calculate best route, it uses many steps and PAs
- Only one BGP process can be launched with VRFs and using local-as option to send different AS number
- If we use VRF, one BGP process, one AS number, different neighbors for different VRFs
- Updates are sent only after changes in network
- Metric: attributes
- Does not know about all networks, knows only about neighboors
- Very slow convergance by design, Hello - 60 sec, Dead - 180 sec
- ECMP to work: AS Path should be absolutely identical
- The AD Values: eBGP - 20, iBGP - 200
- eBGP changes next-hop to self by default, if update-source is Loopback0, next-hop is LoopbackO, can be modified: "route-map action set ip next-hop" or "neighbor next-hop-unchanged"
- Flow control, route manipulation, PBR - ???
- What is happend when route is deleted??
- Huge routing table
- Announces only best path to prefix, even if got three for example, and all three are in ECMP and work well - anyway it will select best and propogate it
- Router ID - Highest Loopback/Highest Active Physical Interface/Manual
- When IP redundancy exists between two eBGP peers, the eBGP neighbor commands should use loopback IP addresses to take advantage of that redundancy
- Loops are avoided by AS_PATH
- Does not select the best path from a performance point of view, it will select the best path from a business point of view
- The Internet, in its purest form, is a loosely connected graph of independent networks (also called Autonomous Systems (AS for short)). These networks use a signaling protocol called BGP (Border Gateway Protocol) to inform their neighbors (also known as peers) about the reachability of IP prefixes (a group of IP addresses) in and through their network. Part of this exchange contains useful metadata about the IP prefix that are used to inform network routing decisions. One example of the metadata is the full AS-path, which consists of the different autonomous systems an IP packet needs to pass through to reach its destination
- Traffic engineering can be done with BGP - outbound is much easier, we just have to choose where to send traffic. Inbound is done with manipulating BGP attributes: AS_PATH(prepending) and communities(community-based local preference)
- Prepending - form of traffic engineering - artificially increases AS-path length. Example: AS_PATH: 64500 64496 64496. Usually the operator uses their own AS, but that’s not enforced in the protocol. Unfortunately, prepending has a catch: To be the deciding factor, all the other attributes need to be equal. Excessive prepending opens a network up to wider spread route hijacks - ???.
- Default TTL - 1 for eBGP, >1 for iBGP, that is why peering from Loopback will not work by default, multihop command can help
- By default most routers will not send BGP updates to routers with the same AS. It should be enabled with special command. For example, router A has neighbors B and C, which are in the same AS. Updates, received from B, will not be forwarded to C by default
- Inbound updates containing local AS are discarded

## Design

What you need to think through, when you design BGP network

- ASN numbering
- IP addresses, VRFs, subinterfaces
- Router-ID - the same as loopback - configured manually
- Timers: Hold, Hello, Reconnect, Advertisment
- BFD
- Addresses family
- bestpath as-path multipath-relax - treat two BGP routes as equal cost even if their AS-paths differ, as long as their AS-path lengths and other relevant attributes are the same, used for ECMP
- ECMP maximum-paths
- Which networks to redistribute and how: networks command or route map
- Route maps and other variables are written in CAPS to distinquish them in a config
- allowas-in 1 - Accept as-path with my AS present in it
- Prioritize particular routes via route map and increasing local preference
- Allow only certain prefixes from certain neighboors via ip prefixes and route maps 

## Data Centre Design

- ASN numbering to exclude path hunting: Spines have the same AS
- Multipath
- One BGP session for multiple address families - !!!!!!!!!
- Aggressive timers: Hold - 9, Hello - 3, reconnect - 12
- BFD
- Route maps to propogate local prefixes - ?
- Summarize routes only on Leafs
- As simple as possible
- If two Leafs are in vPC pair - they may have the same AS number
- If Leafs have the same AS number - there will be a loop - can be disabled manually
- Redistribute only networks connected to Leafs, looopbacks for instance
- On Spines we configure dynamic neighboring using peer filter, where we configure which AS we accept from leafs, and listen command to specify networks on which we listen for BGP connections. Listen command is a passive mode. Leafs cannot be configured in this mode, they should be active. Listen command specifies which networks to listen, to which peer group place these neighbores and which AS accept

## Operations workflow

- If everything is fine, only keepalives are sent, nothing inside them
- When connection starts, routers send OPEN messages with AS number, router id and capabilities list
- Then they send UPDATE messages with next hop as themselfs. One packet can contain several UPDATE messages and even KEEPALIVE inside. UPDATE message contains PATH ATTRIBUTES: ORIGIN, AS_PATH, MP_REACH_NLRI
- Only the following routes are sent: network command, redistribute command via route map of local addresses, redistribute from other protocols, routes received via BGP, nothing is sent by default

## Packet types

- Open - negotiation parametres: BGP version, AS number, RID, Timers...
- Notification - for errors
- Update - routing information
- Keep alive
- Route refresh - request all routes for particular AFI/SAFI

### Update message

 NLRI + Path Attributes, both for BGP and MP-BGP  

 ```
 Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 61
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 35
    Path attributes
        Path Attribute - ORIGIN: IGP
        Path Attribute - AS_PATH: 65100 
        Path Attribute - NEXT_HOP: 192.168.51.2 
        Path Attribute - MULTI_EXIT_DISC: 0
        Path Attribute - COMMUNITIES: 321:654 
    Network Layer Reachability Information (NLRI)

 ```

## Neighbor states

## Path Attributes

<img width="671" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/c5e511a8-6318-4367-9c34-3bacd0ffa26c">

10 attributes in total! 
Only 3 are absolutely mandatory!   

Path attributes fall into four separate categories:

- Well-known mandatory - The PA must be in every BGP Update, all devices have to support it
- Well-known discretionary - he PA is not required in every BGP Update, all devices have to support it
- Optional transitive - not all have to support it, the router should silently forward the PA to other routers without needing to consider the meaning of the PA
- Optional non-transitive - not all have to support it, the router should remove the PA so that it is not propagated to any peers

### Well-known mandatory

- AS_PATH
- NEXT_HOP
- ORIGIN - 
  - i - originate the prefix through BGP
  - e - is no longer used
  - ? - distribute a prefix into BGP from another routing protocol

### Well-known disretionary

- Local Preference - used only in iBGP, used to show the best exit from AS, the higher the better route, default - 100. Default value exists only for routes, which originate from this router and with in AS, if router is received from different AS, local preference is empty
- ATOMIC_AGGREGATE - The purpose of the attribute is to alert BGP speakers along the path that some information have been lost due to the route aggregation process and that the aggregate path might not be the best path to the destination

### Optional transitive

- AGGREGATOR - When some routes are aggregated by an aggregator, the aggregator does attache its Router-ID to the aggregated route into the AGGREGATOR_ID attribute
- COMMUNITIES
 
### Optional non transitive

- ORIGINATOR_ID - new optional, non-transitive BGP attribute of Type code 9.  This attribute is 4 bytes long and it will be created by an RR in reflecting a route.  This attribute will carry the BGP Identifier of the originator of the route in the local AS
- CLUSTER_LIST - is a new, optional, non-transitive BGP attribute of Type code 10.  It is a sequence of CLUSTER_ID values representing the reflection path that the route has passed. When an RR reflects a route, it MUST prepend the local CLUSTER_ID to the CLUSTER_LIST.  If the CLUSTER_LIST is empty, it MUST create a new one.  Using this attribute an RR can identify if the routing information has looped back to the same cluster due to misconfiguration.  If the local CLUSTER_ID is found in the CLUSTER_LIST, the advertisement received SHOULD be ignored - to put it simple - all RRs, via which route passed, should be on this list
- Multi Exit Discriminator (MED) - suggestion to other directly connected networks on which path should be taken if multiple options are available, and the lowest value wins. Transfered from iBGP to eBGP. allow routers in one AS to tell routers in a neighboring AS how good a particular route is. We send a route with lower MED, and this route becomes preferable

```
BGP Message
    Type: UPDATE Message
    Path Attributes:
        Path Attribute - Origin: IGP
        Path Attribute - AS_PATH: 64500 64496
        Path Attribute - NEXT_HOP: 198.51.100.1
        Path Attribute - COMMUNITIES: 64500:13335
        Path Attribute - Multi Exit Discriminator (MED): 100
    Network Layer Reachability Information (NLRI):
        192.0.2.0/24
```

## Communities

What is BGP community?

- Cummunity is optional transitive BGP attribute that can traverse from AS to AS
- Any BGP prefix can have more than one tag (BGP community), you can attach up to 32 communities to a single route

Why use BGP communities?

- Additional capability for tagging routes and for modifying BGP routing policy
- BGP communities can be appended, removed, or modified selectively on each attribute as a route travels from router to router
- Service providers can make an agreement with your customers on a specific policy to be applied to their prefixes using BGP communities - Incoming traffic engineering - set local preference based on community

Types of BGP communnities
- Standard communities
- Extended communities
- Large communities

Standard communities

- Written as numeric 32-bit tags in (AS:Action) format
- The first 16 bits is the (AS) number of the AS that defines the community
- The second 16 bits have the local significance (Action)
- The primary purpose of standard communities is to the group and tag routes so that actions can perform
- The BGP community can be displayed in full 32-bit format (0-4,294,967,295) or as two 16 bit numbers (0-65535):(0-65535) commonly referred to as new-format

Well-known standard communities

- Internet: should be advertised on the Internet
- No_Advertise: Routes with this community should not be advertised to any BGP peer (iBGP or eBGP)
- No_Export: When a route with this community is received, the route is not advertised to any eBGP peer. Routes with this community can be advertised to iBGP peers
- Local-as: prevent sending tagged routes outside the local AS within the confederation.(route will not send to any EBGP neighbor or any to intra-confederation external neighbor )

Extended communities 

- Written as numeric 64-bit tags in (Type:AS:Membership) format
- The first 16 bits are used to encode a type that defines a specific purpose for an extended community, extended community type numbers are assigned by Internet Assigned Numbers Authority (IANA)
- The remaining 48 bits can be used by operators
- Examples: Site of Origin (SOO), Ethernet VPN (EVPN), OSPF Domain Identifier, Route Target

Large communities 

- Written as numeric 96-bit tags in (Source AS:Action: Target AS) 
- Format split into three 32-bit values which can accommodate more identification data including 4-byte AS numbers

How to set community attribute values?

Using Route-maps associated with:

- Network Command
- Aggregate address
- Neighbor command
- Redistribution command

Configuration  
IOS and IOS XE routers do not advertise BGP communities to peers by default

```
#Show in new format
ip bgp-community new-format

neighbor ip-address send-community [standard | extended | both] [additive] - for additional community
```

Can Delete Community by setting to none on route-map

Match occurs via community list

- Define list
- Standard list matches community name or number 
  - ip community-list 1 standard permit no-export
- Expanded matches regular expression
  - ip community-list expanded AS100 permit 100: [0-9]+
- Reference from route-map
  - match community AS100

BGP Cost-Community - BGP Custom Decision Process

- http://tools.ietf.org/html/draft-retana-bqp-custom-decision-02
- Only advertised within the AS or to confederation peers
- Influences BGP path selection at the Point of Insertion 
  - "pre-bestpath" point of insertion can be used 
  - Compares cost-community value before Weight
- EIGRP PE/CE
  - Uses "pre-bestpath" cost-community to encode composite metric into BGP

GSHUT Community

- Graceful BGP session shutdown
- http://tools.ietf.org/html/draft-ietf-grow-bgp-gshut-05
- Used in conjunction with Graceful Restart
- Takes the restarting peer out of the data-path by modifying local preference
- Similar to IS-IS Overload or OSPF Max Metric LSA
- Introduce on Cisco IOS XE Release 3.6S

## Best path selection

**12 steps** 

First nine are main  
Remaining 3 are tiebreackers

1. Is next hop reachable?
2. Weight
3. Local preference - is set when router receives a route. A higher value is a higher preference
4. Locally injected routes - injected into BGP locally (using the network command, redistribution, or route summarization)
5. AS PAth length
6. Origin code, the less - the better
7. MED
8. Neighbor Type: Prefer external BGP (eBGP) routes over internal BGP (iBGP)
9. IGP metric for reaching the NEXT_HOP, the lower the value, the better the route
10. The oldest path
11. Smallest RID
12. Smallest neighbor ID

The decision for eBGP routes can reach Step 11 if at Step 10 the formerly best route fails and BGP is comparing two other alternate routes.  
- If the best path for an NLRI is determined in Steps 1 through 9, BGP adds only one BGP route to the IP routing table—the best route, of course
- If the best path for an NLRI is determined after Step 9, BGP considers placing mul- tiple BGP routes into the IP routing table
- Even if multiple BGP routes are added to the IP routing table, BGP still chooses only one route per NLRI as the best route; that best route is the only route to that NLRI that BGP will advertise to neighbors

Community based local preference:  

- They are used for inbound traffic engineering. 
- Some transit providers allow their customers to influence the local preference in the transit network through the use of BGP communities
- For example community 174:10 means local preference 10

## Address families

- Originally, BGP was intended for routing of IPv4 prefixes
- RFC 2858 added Multi-Protocol BGP (MP-BGP) capability by adding an extension called the address family identifier (AFI)
- Address family shows particular network protocol, for example IPv4, IPv6
- Additional granularity is provided through a subsequent address-family identifier (SAFI) such as unicast or multicast
- MBGP achieves this separation by using the BGP path attributes (PAs) MP_REACH_NLRI and MP_UNREACH_NLRI
- These attributes are carried inside BGP update messages and are used to carry network reachability information for different address families
- Every address family maintains a separate database and configuration for each protocol (address family + sub-address family) in BGP.
- BGP includes an AFI and SAFI with every route advertisement to differentiate between the AFI and SAFI databases

## Capabilities

## ASN

- Can be 16 bit (2 bytes) and 32 bit (4 bytes)
- 0 to 65535
- Reserved: 0, 23456, 65535 - ?
- Public: 1 - 64495, 65552 - 4 199 999 999
- Private: 64512 - 65534, 4 200 000 000 - 4 294 967 294
- Notation options: ASPLAIN 0 - 4 294 967 294, ASDOT 0 - 65535.65535
- We can substitute AS number for particular neighbor. For example we can do it, when we connect VRFs in fabric via external Firewall and to avoid "allow as in" option we configure different ASNs for different VRFs to peer with firewall 

## Injecting Routes/Prefixes

- We configure summarization in address family section for Nexus and it works for all neighbors, we specify summarized prefix there wit as-set option and summer only, without summer only option it will advertise all prefixes plus summer
- No auto-summary is the default
- What networks are advertised by default? - none - only received via BGP
- Network command: Look for a route in the router’s current IP routing table that **exactly** matches the parameters of the network command; if the IP route exists, put the equivalent NLRI into the local BGP table. With this logic, connected routes, static routes, or IGP routes could be taken from the IP routing table and placed into the BGP table for later advertisement. When the router removes that route from its IP routing table, BGP then removes the NLRI from the BGP table, and notifies neighbors that the route has been withdrawn. If auto-summary is enabled, then it matched all of its subnets
- route-map can be used in network command to manipulate path attributes, including next hop

## Summarization

- In BGP world it is called aggegation - it is a whole world with attributes and rules
- Conserve router resources
- Accelerated best path calculation
- Stability: hiding route flaps from downstream routes
- Most service providers do not except prefixes larger then /24
- Dynamic route summarization is done vian address-family command 
    - aggregate-address network subnet-mask [summary-only] [as-set]
- Example: 172.16.1.0/24, 172.16.2.0/24, 172.16.3.0/24 are aggregated with command: aggregate -address 172.16.0.0 255.255.240.0
- This command will add to BGP table prefix 172.16.0.0/20 - but it will not delete smaller route
- summer-only option suppresses the component network prefixes
- Suppression - when BGP process does not advertise routes (fo example connected) because of aggregation
- When new summary route is advertised it is advertised without any previous attributes or AS Path. It is sent as if an aggregating router is an originator of route: AS Path contains only AS of aggregating router
- Atomic-aggregate and Aggregator Path Attributes is added by the aggregator and all other routers see in BGP table: aggregated by 65200 192.168.2.2 
- Aggregated route appears in BGP table only after at least one viable component route enters BGP table, for example 172.16.1.0/24
- After enabling aggregation BGP installs aggrgated route to RIB of originating router with gateway Null0 - it is called summary discard route it is created to avoid loops
- Loops explanation: R1 aggregates 192.168.1.0/24 and 192.168.2.0/24 and sends to everyone 192.168.0.0/16. After this it gets a packet with destination 192.168.3.1 - it does not know about this network - and what it does? It sends it to default gateway! - Bad! And if summary discard route is installed this packaet will be silently dropped :)
- To sum up agrregated route is in two tables: RIB and BGP, in BGP default route is 0.0.0.0 and in RIB NULL0
- Component routes are still in BGP table but they have status - s -suppressed
- If we configure summarization, for example two LANs connected to Leaf, and then if we disconnect one LAN, summerized route will continue propogating and everyone will consider this LAN available. Especially summarization is unacceptable on Spines. This is relevant only with "summer only" option

 ## Redistribution

 - When we configure redistribution from OSPF weight is 32768, Path is ?, Local Pref is not set by default, origin code is Incomplete - ?

## Route maps

- Route map can be added after network command and after neighbor command
- network route-map command changes attrivutes before adding prefix to BGP table, except AS path
- neighbor route-map in|out applies changes to updates, sent or received. It also acts as filter, it can drop update based on match

## Timers

- Advertisment interval - default eBGP 30 sec, iBGP 0 sec - 0 secs for Clos - send updates immediately after receiving
- Keepalive - default 60 secs - 3 sec for CLOS - how often to send HELLOs
- Hold - default 180 sec -  9 sec for CLOS - how long to wait for dead peer
- Connect - default 30 sec - reconnect interval on Nexus - 12 sec for CLOS - interval after which a dropped BGP connection can automatically reconnect
- BFD - Tx/Rx 100 ms x 3 - for CLOS
- MicroBFD if LAG is used - for CLOS

## Graceful restart and shutdown

- BGP Graceful Restart is a feature of the Border Gateway Protocol (BGP) that enables BGP sessions to be restarted without causing a disruption in the network. It works by allowing routers to maintain their established routes even after a session reset or restart
- When a BGP session is established, GR capability for BGP is negotiated by neighbors through the BGP OPEN message
- If the neighbor also advertises support for GR, GR is activated for that neighbor session
- If the BGP session is lost, the BGP peer router, known as a GR helper, marks all routes associated with the device as “stale” but continues to forward packets to these routes for a set period of time. The restarting device also continues to forward packets for the duration of the graceful restart. When the graceful restart is complete, routes are obtained from the helper so that the device is able to quickly resume full operation
- Graceful shutdown A feature in routing protocols allowing a router to inform its neighbors about its impending deactivation. The neighbors can react to this indication immediately, instead of waiting for the Hold or Dead intervals to expire.


## Path hunting

- Starts on big networks, 30 routers and above
- It is relevant for CLOS networks as well
- Spines in one AS helps to avoid this issue, because in this case route which passed spine 1 will be dropped by spine 2. Super spines have the same AS as well
- The same AS on leafs is not good idea, it will prevent from getting a route on Leaf 2 from Leaf 1 via Spine 1

## ECMP

Criteria:
- weight
- local preference - only for iBGP
- AS_PATH - whole path, not only length
- origin
- MED - only from iBGP to eBGP
- IGP metric
- Next hop should be different
Five tuples are used for load balancing. Hash is calculated for these 5 parametres. If all traffic is absolutely identical, it will always go via one link. It is called traffic polarization. Traffic entropy is zero. The entropy can be added manually.

## Maintenence

- Use AS_PATH prepend
- Increse MED
- isolate command for NX-OS
- Well-known community - GRACEFUL_SHUTDOWN

## Synchronization

Don't use or advertise the route/s learned via an iBGP neighbor to an eBG neighbor unless & until the same is/are learned via some other IP like RIP, OSPF, EIGRP...

## MP-BGP

-  IETF RFC 4760
-  Extension to BGP, which allows to transfer different address families
-  IPv4, IPv6, multicast, unicast, VPN
-  Unicast and multicast are stored in different tables
-  When MP-BGP is configured, BGP installs the MP-BGP routes into different routing tables. Each routing table is identified by the protocol family or address family indicator (AFI) and a subsequent address family identifier (SAFI).
-  EVPN AFI/SAFI - 25/70 - RFC 7209, 7432, 8365

## Route Distinguisher

- Used to distinguish different routes for different VRFs in BGP routing table, the routes are different from Best Path Algorithm point of view
- Part of MP-BGP
- Route distinguisher and route target were also devised for MPLS
- Transfered in NLRI: RD:IP
- 3 types:
    - ASN2:NN - 64701:1
    - ASN4:NN - 12000012:1
    - IPV4:NN - 192.168.1.1:1
- RDs allow BGP to advertise and distinguish between duplicate IPv4 prefixes. The concept is simple: Advertise each NLRI (prefix) as the traditional IPv4 prefix, but add another number (the RD) that uniquely identifies the route
- Route distinguisher is configured for VRF, after this all routes, exported from this VRF to BGP table, will be with this RD, only one RD for VRF

## Route target

- MPLS uses Route Targets to determine into which VRFs a PE places IBGP-learned routes
- Transfered in Extended Community
- Format the same as in RD
- Several route targets for prefix
- Route target have meaning local and remotely, it can be used even without BGP peer
- It is configured for address family in VRF: import command sets which routes to import from global VPNv4 BGP table and export command sets which RT to set to routes which are exported
- Term export to mean “redistribute out of the VRF into BGP” and the term import to mean “redistribute into the VRF from BGP.”
- During import we may decrease routes priority by decreasing local preference or weight (these attributes are local and will not leave AS) with route map after import command
- Type 2 - MAC/IP advertisment route


## Load Share with BGP in Single and Multihomed Environments

## iBGP

- iBGP packets default to TTL 255
    - Implies neighbors do not have to be connected as long as IGP reachability exists
- iBGP peers typically peer via Loopbacks
    - Allows rerouting around failed paths via IP
    - Required for some application such as MPLS L3VPN
- Loop prevention via route filtering: IBGP learned routes cannot be advertised on to another iBGP neighbor, as a result it requires:
    - Fully meshed iBGP peerings
    - Route reflectors
    - Confederation
- You don't need to only choose one design
  - E.g full mesh, RR, and Confed can interoperate
  - Pockets of full mesh for path diversity + Inter-cluster RR for scaling larger
- One of the key component of the route reflection approach in addressing the scaling issue is that the RR summarizes routing information and only reflects its best path
- Certain route reflection topologies the route reflection approach may not yield the same route selection result as that of the full IBGP mesh approach
- A way to make route selection the same... is by configuring the intra-cluster IP metrics to be better than the inter-cluster IGP metrics, and maintaining full mesh within the cluster
- By default Outbound iBGP updates do not modify the next-hop attribute regardless of iBGP peer type
- Can be modified
  - neighbor next-hop-self
  - route-map action set ip next-hop
  - "next-hop-self ALL" for inserting RR in the data-path: packets will go via RR: Used in Unified MPLS design

Full Mesh Design Advantages

- Path Diversity - All BGP peers learn all possible egress paths
- Optimal Traffic Flows - All BGP peers learn the closest egress path
- Path selection by default would be based on IP metric to egress router - I.e. Hot Potato Routing

Full Mesh Design Disadvantages

- Control plane scaling is exponential
  - Full mesh means n*(n-1)/2 peerings
  - 10 routers = 45 peerings
  - 100 routers = 4950 peerings
  - 500 routers = 124750 peerings
- Operationally hard to scale
- Adding or changing peering config is administratively prohibitive
- Could be automated, but few out of the box solutions

### iBGP Route Reflection  

This is one if iBGP scaling techniques  

- Eliminates need for full mesh
- Only need peering(s) to the RR(s)
- Like OSPF DR & IS-IS DIS, minimizes prefix replication
- Send one update to the RR
- RR sends the update to its "clients"
- Does not modify other attributes when reflecting routes
- Loop prevention through Cluster-ID
- RR discards routes received with its own Cluster-ID
- Sets Originator-ID attribute to the router-id of RR client on routes RECEIVED from the client
- Client uses Originator-ID for loop prevention
- Route reflector can have three types of peers
  - EBGP peers
  - IBGP Client Peers
  - IBGP Non Client Peers

RR processes updates differently depending on what type of peer they came from

- EBGP learned routes...
  - Pass to EBGP peers, Clients, & Non-Clients 
- Client learned routes...
  - Pass to EBGP peers, Clients, & Non-Clients 
-  Non-Client learned routes...
  - Pass to EBGP peers & Clients
- RR placement based upon these rules

Large Scale Route Reflection

- Large scale BGP designs should not be serviced by a single RR
- RR "clusters" allow redundancy and hierarchy
- Cluster is defined by the clients a RR serves + RRs in the same cluster use the same Cluster-ID
- Per address-family RR pairs
- Avoids "fate sharing" of services

Inter-Cluster Peerings

- Inter-Cluster peerings between Rs can be client or non-client peerings
  - Depends on redundancy design
  - Duplicate routes, more processing
- Cluster-ID is based on Router-|D
  - By default all RR are in separate clusters
- Same cluster-id on both clusters or not?
  - Depends on redundancy design...

Virtual Route Reflectors

- RR generally does not need to be in data-path
- E.g. I give you the route but you forward through someone else
- High Memory/CPU VM can do the job
- IOS-XRv
- CSR1000v
- Quagga fort Linux
- No need to install 500k routes in the RIB/FIB if RR is not in the data-path
- Selective RIB Download Feature
- Prevents BGP paths from being installed in RIB/FIB
- table-map [route-map] filter
- Scale to 20 + Million VPNv4 routes

### Confederation

This is one if iBGP scaling techniques

- Reduces full mesh iBGP requirement by splitting AS into smaller Sub-AS
- Inside Sub-AS full mesh or R requirement remains
- Between Sub-AS acts like EBGP
- Devices outside the confederation do not know about the internal structure
- Sub-AS numbers are stripped from advertisements to "true" EBGP peers
- Typically uses ASs in private range: 64512 - 65535
- Can use different IGPs in each Sub-AS
- Next-hop self on border routers
- Next-hop, Local-Pref, and MED are kept across Sub-AS eBGP peerings
- BGP Confederation Loop Prevention: AS CONFED SEQUENCE, AS CONFED SET, these attributes never leave the confederation

### Configuration overview

- Enable router process with AS number - the same on all routers
- Configure router id
- Configure neighbors with specifiying their AS number - the same
- Configure update source
- Configure address families
- Configure communities
- Configure route reflector
- Configure dynamic neighbors if necessary: listen range, if request arrives from it put it to specified group, which is already configured

### Route Reflection vs. Confederation

- Why both?
  - Generally accomplish the same goal
- Migrations paths are different
  - Migrate to confederation is hard
  - Greenfield confederation is easier
  - Migrate to RR is easy, just add peers then remove old ones

## Incindents

- Leaks - Customer gets prefixes from one provider and anounces them to other provider. This leads to traffic spikes via customer. Amount of hops rises. MITM is possible. RTT is rising. How to fight with it? If you are the leaker and you are not the transit AS, then just configure filtering: allow announces only for routes with 0 AS PATH - our own routes
- Hijacks - bad guy announces prefixes, which are not theirs, and traffic goes to them instead of legitimate user. Nobody is protected from hijacking, because BGP is not secure
- Bogons - bogon prefixes are leaked to public internet and hosts in LAN become available from th Internet. The same with bogon AS numbers - may be dropped by other provider.

### Bogon ASNs

- 0 - RFC 7607
- 23456 - RFC 4893 AS_TRANS
- 64496..64511 - RFC 5398 and documentation/example ASNs
- 64512..65534 - RFC 6996 Private ASNs
- 65535 - RFC 7300 Last 16 bit ASN
- 65536..65551 - RFC 5398 and documentation/example ASNs
- 65552..131071 - RFC IANA reserved ASNs
- 4200000000..4294967294 - RFC 6996 Private ASNs
- 4294967295 - RFC 7300 Last 32 bit ASN

## Filtering

- https://bgpfilterguide.nlnog.net  
- The bgpq4 utility is used to generate configurations (prefix-lists, extended access-lists, policy-statement terms and as-path lists) based on IRR data 
- https://github.com/bgp/bgpq4

## BGP Security

- RPKI
- ASPA
- Open Roles
- Peer Lock
- BGP Sec

## Monitoring

- Looking glasses - located in different parts of the world, it provides web access to router routing table, and you can BGP records for particular prefix
    - https://lg.he.net/
    - https://lookingglass.centurylink.com/
    - https://g.retn.net/
- BGP collectors - collects data from many locations by establishing BGP sessions with many routers around the world. Collectors make dumps periodically: full view and updates, we can download them as gzip archives and open with bgpdump - int his dump we see date, time, router IP, AS_PATH - we can grep prefix
    - RIPEstat - you enter prefix - and get detailed data
- Real time BGP monitoring - many open source projects

## Configuration

### Change default local preference

It will be added to all routes to all neighbors

```
R3(config)# router bgp 1
R3(config-router)# bgp default local-preference 200
```

### Change local preference per route

```
R3(config)# ip prefix-list net4 4.4.4.0/24
R3(config)# route-map PREF permit 10
R3(config-route-map)# match ip address prefix-list net4
R3(config-route-map)# set local-preference 300
R3(config)# router bgp 1
R3(config)# neighbour 192.168.35.5 route-map PREF in
```

**Configure different AS number for particular neighbor on Nexus**  
Peering will be made using 64704 ASN instead of 64703  
It is very usefull when we connect VRFs in Fabric via external firewall
```
router bgp 64703
  router-id 10.10.2.7
  address-family ipv4 unicast
    network 10.10.2.7/32

vrf OTUS2
    neighbor 192.168.6.2
      remote-as 64800
      local-as 64704 no-prepend replace-as
      address-family ipv4 unicast
```

**Configure routes summarization/aggregation: all /32 routes to /24 route in address family section**

```
border-leaf(config-router-vrf-af)# aggregate-address 192.168.1.0/24 as-set summary-only
```
Now only one /24 prefix will be sent


**Origin code IGP**

```
network
neighbor default-originate
aggregate-address only when:
as-set is not set
as-set is et and all components of summarized route use IGP (i)
```

**Allow announcing only empty AS path prefixes ( our own prefixes ), no transit prefixes**
To fight with route leaks, when you are connected to 2 providers
```
Leaker-R7(config)#ip as-path access-list 1 permit ^$
Leaker-R7(config)#ip as-path access-list 1 deny *

router bgp 777
    Leaker-R7(config-router)#neighbor 10.0.1.1 filter-list 1 out
```

**Allow announcing only prefixes that are behind you, if you a transit AS and dual homed to 2 providers**
```
Leaker-R7(config)#
ip prefix-list PL-NO-TRANSIT seq 5 permit 30.30.30.0/24
Leaker-R7(config)#router bgp 777
Leaker-R7(config-router)#neighbor 10.0.1.1 prefix-list PL-NO-TRANSIT out
Leaker-R7(config-router)#neighbor 20.0.1.2 prefix-list PL-NO-TRANSIT out
Leaker-R7(config-router)#end
```
**Origin code Incomplete**
```
redistribute
default-information originate
aggregate-address only when:
as-set is set and at least one subnet of summarized route use Incomplete (?)
```

**Configure Origin code in Route map**
```
dyn1(config-route-map)# set origin ?
 egp         remote EGP
 igp         local IGP
 incomplete  unknown heritage
```

**Configure summarization**
Traffic specified here will be available, while at least one network exists, which falls within this range, using LPM rule
```
aggregate-address 10.99.0.0/31 summary-only
```

Minimum required configuration
- Router process with AS number
- Router-ID - not required, but prefered
- Neighbor with its AS number and address family
- Advertise something if needed via redistribute or network commands

Additional features:
- Filters via route maps and additonal options like timers or allow-as-in
- One BGP process serves for all VRFS and can have different neighbors for different address families
- Dynamic neighbors can be configured

Minimal configuration for EVPN adjacency:
- Define neighbor using its loopback interface with remote as number
- Configure address family for neighbor: l2vpn evpn
- Define loopback as update source
- Configure multihop 2
- Enable both types of community

One large configuration file on Nexus with comments, based on my experience
```
feature bgp

#Enable route leaking, RT, RD
install feature-set mpls
feature-set mpls
feature mpls l3vpn

#Enable VTEP for VXLAN on Leaf and border
nv overlay evpn

#Enable EVPN support in BGP
nv overlay evpn

router bgp 64701
  router-id 10.10.1.3
  # Treat two BGP routes as equal cost even if their AS-paths differ, as long as their AS-path lengths and other relevant attributes are the same, used in ECMP
  bestpath as-path multipath-relax
  reconnect-interval 12
  address-family ipv4 unicast
    redistribute direct route-map connected
    maximum-paths 64
  template peer spine
    timers 3 9
    address-family ipv4 unicast
    remote-as 64600
  neighbor ip-address-1
    inherit peer spine
    description spine-3
  neighbor 10.1.1.1
    remote-as 64600
    description Spine-1
    timers 3 9
    address-family ipv4 unicast
  neighbor 10.1.2.1
    remote-as 64600
    description Spine-2
    timers 3 9
    address-family ipv4 unicast
 
 #Neighboor config for EVPN overlay
  neighbor 10.10.2.1
    remote-as 64600
    address-family l2vpn evpn
        send-community both
    update-source loopback 1
    ebgp-multihop 2
 
 #VRF config in BGP
  vrf GOOGLE
    address-family ipv4 unicast
      redistribute direct route-map connected
      network 192.168.1.0/24 #route-map can be added here as well
    neighbor 172.16.1.1
      address-family ipv4 unicast - mandatory command
        allowas-in 1 - Accept as-path with my AS present in it
        disable-peer-as-check - allow forward updates between two routers in the same AS
```

## Verification

**Show BGP table for global VRF or VRF**  
It shows all BGP routes both best and secondary with all the options: Path,Weight, Local Pref, Next Hop, Status, Path type, Origin Code

```
leaf-1(config-router-vrf-af)# show ip bgp vrf GOOGLE
BGP routing table information for VRF GOOGLE, address family IPv4 Unicast
BGP table version is 4, Local Router ID is 192.168.1.1
Status: s-suppressed, x-deleted, S-stale, d-dampened, h-history, *-valid, >-best
Path type: i-internal, e-external, c-confed, l-local, a-aggregate, r-redist, I-i
njected
Origin codes: i - IGP, e - EGP, ? - incomplete, | - multipath, & - backup, 2 - b
est2

   Network            Next Hop            Metric     LocPrf     Weight Path
*>l192.168.1.0/24     0.0.0.0                           100      32768 i
```

**Show brief list of BGP neighbors**  
Here we can see amount of prefixes from neighbor, and if it is 0 - we have a problem

```
spine-1# show ip bgp summary
BGP summary information for VRF default, address family IPv4 Unicast
BGP router identifier 10.10.1.1, local AS number 64600
BGP table version is 37, IPv4 Unicast config peers 3, capable peers 2
2 network entries and 2 paths using 440 bytes of memory
BGP attribute entries [2/328], BGP AS path entries [2/12]
BGP community entries [0/0], BGP clusterlist entries [0/0]

Neighbor        V    AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
10.1.1.2        4 64701    9037    9088       37    0    0 03:00:25 1
10.1.1.6        4 64702    8958    9027       37    0    0 00:13:28 1
10.1.1.10       4 64703       0       0        0    0    0 08:13:08 Idle
```
The same for all VRFs
```
spine-1# show ip bgp summary vrf all
```

**Show routes advertised to particular neighbor**  

```
firewall(config-router)# show ip bgp neighbors 172.16.3.2 advertised-routes

Peer 172.16.3.2 routes for address family IPv4 Unicast:
BGP table version is 44, Local Router ID is 1.1.1.1
Status: s-suppressed, x-deleted, S-stale, d-dampened, h-history, *-valid, >-best
Path type: i-internal, e-external, c-confed, l-local, a-aggregate, r-redist, I-i
njected
Origin codes: i - IGP, e - EGP, ? - incomplete, | - multipath, & - backup, 2 - b
est2

   Network            Next Hop            Metric     LocPrf     Weight Path
*>l1.1.1.1/32         0.0.0.0                           100      32768 i
```

**Debug BGP updates on Nexus**

```
N7K-2# debug-filter bgp neighbor 10.2.3.3
N7K-2# debug-filter bgp prefix 10.255.255.1/32
N7K-2# debug bgp updates
N7K-2# 
N7K-2# debug logfile bgpdebug.log

N7K-2# show debug logfile bgpdebug.log

undebug all
no debug-filter all
clear debug logfile <FILE_NAME>
```

**Debug BGP updates on Cisco IOS**

```
R3#debug bgp ipv4 unicast 
R3#clear bgp ipv4 unicast * soft
R3#show debug
```
