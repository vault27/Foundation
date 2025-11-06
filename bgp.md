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

## Main features

- Regular TCP application to exchange data for different address families
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
- NLRI consists of: network prefix, prefix length, path attributes (next hop is a path attribute as well)
- Path vector routing protocol
- Does not use hello packets to discover neighbors
- TCP port 179
- Neighbors may be several hops away
- Multi hop sessions require that the router uses underlying route installed in the RIB static or from routing protocol
- BGP routers do not have to be in a data path
- 2 types of sessions: iBGP and eBGP
- 2 BGP processes with different AS on one router - supported on some platforms
- BGP is not a routing protocol: BGP is an application used to exchange NLRI, IPv4, IPv6, l2vpn, VPnv4...All data in a packet is presented in the form of Path attributes, all these make it very flexible
- For different addresses different AFI/SAFI numbers are used
- Internet de facto protocol, Routing protocol of Intenet, Port 179 TCP, EGP
- BGP knows the next-hop, but not the outgoing interface
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
- What happens when route is deleted - Generates a withdrawal message and sends it to all affected BGP peers
- Huge routing table
- Announces only best path to prefix, even if got three for example, and all three are in ECMP and work well - anyway it will select best and propogate it
- Router ID - Highest Loopback/Highest Active Physical Interface/Manual
- When IP redundancy exists between two eBGP peers, the eBGP neighbor commands should use loopback IP addresses to take advantage of that redundancy
- Loops are avoided by AS_PATH
- Does not select the best path from a performance point of view, it will select the best path from a business point of view
- The Internet, in its purest form, is a loosely connected graph of independent networks (also called Autonomous Systems (AS for short)). These networks use a signaling protocol called BGP (Border Gateway Protocol) to inform their neighbors (also known as peers) about the reachability of IP prefixes (a group of IP addresses) in and through their network. Part of this exchange contains useful metadata about the IP prefix that are used to inform network routing decisions. One example of the metadata is the full AS-path, which consists of the different autonomous systems an IP packet needs to pass through to reach its destination
- Traffic engineering can be done with BGP - outbound is much easier, we just have to choose where to send traffic. Inbound is done with manipulating BGP attributes: AS_PATH(prepending) and communities(community-based local preference)
- Prepending - form of traffic engineering - artificially increases AS-path length. Example: AS_PATH: 64500 64496 64496. Usually the operator uses their own AS, but that’s not enforced in the protocol. Unfortunately, prepending has a catch: To be the deciding factor, all the other attributes need to be equal. Excessive prepending opens a network up to wider spread route hijacks
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

## Multihoming

Resiliency in Service Providers

- One router in company - one in ISP - 2 lines
- One router in company - 2 routers in ISP - 2 lines
- One router in company - 2 ISPs - 2 lines
- Two routers in company (iBGP between them) - 2 ISPs - 2 lines

Internet transit routing - when 2 ISPs are connected to a company - company AS can become a transit AS - to avoid it company routers should advertise only local prefixes. 

Determenistic path - flow between sites is predetermined and predictable. 

Branch routers may become transit routers as well if one of determenistic path fails. Then routing becomes non determenistic. Transit routing can be avoided by configuring outbound routing filtering at each branch. Branch do not advertise what they learn from WAN. They advertise only theie LANs.

## Operations workflow

- If everything is fine, only keepalives are sent, nothing inside them
- When connection starts, routers send OPEN messages with AS number, router id and capabilities list
- Then they send UPDATE messages with next hop as themselfs. One packet can contain several UPDATE messages and even KEEPALIVE inside. UPDATE message contains PATH ATTRIBUTES: ORIGIN, AS_PATH, NLRI, MP_REACH_NLRI
- Only the following routes are sent: network command, redistribute command via route map of local addresses, redistribute from other protocols, routes received via BGP, nothing is sent by default

## Messages

- Open - negotiation parametres: BGP version, AS number, RID, Hold Time, BGP ID, other capabilities
    - Hold time - after receipt of an UPDATE or KEEPALIVE, hold time resets, if it reachs zero, router deletes all routes from this neighbor and UPDATE ROUTE WITHDRAW message is sent to other neighbors. Smaller hold time is used during negotiations. Cisco - 180 sec
- Notification - for errors: hold time expired, reset requested, capabilities changed...
- Update - routing information: NLRI+attributes, new ones or withdraw, withdraw contains only prefix. Can act as KEEPALIVE.
- Keep alive - sent every one third of hold time
- Route refresh - request all routes for particular AFI/SAFI

### Open message

- List of optional parametres - Capabilities: multiprotocol (AFI/SAFI), route refresh capability, route refresh capability Cisco, enhanced route refresh capability, 4 octet AS number, graceful restart

```
Border Gateway Protocol - OPEN Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 57
    Type: OPEN Message (1)
    Version: 4
    My AS: 23456 (AS_TRANS)
    Hold Time: 60
    BGP Identifier: 10.125.0.144
    Optional Parameters Length: 28
    Optional Parameters
        Optional Parameter: Capability
        Optional Parameter: Capability
        Optional Parameter: Capability
        Optional Parameter: Capability
        Optional Parameter: Capability

```

```
Optional Parameters
    Optional Parameter: Capability
        Parameter Type: Capability (2)
        Parameter Length: 6
        Capability: Multiprotocol extensions capability
            Type: Multiprotocol extensions capability (1)
            Length: 4
            AFI: IPv4 (1)
            Reserved: 00
            SAFI: Unicast (1)
    Optional Parameter: Capability
    Optional Parameter: Capability
    Optional Parameter: Capability
    Optional Parameter: Capability

```

```
Optional Parameter: Capability
    Parameter Type: Capability (2)
    Parameter Length: 6
    Capability: Support for 4-octet AS number capability
        Type: Support for 4-octet AS number capability (65)
        Length: 4
        AS Number: 4294965187

```

### Update message

 - NLRI + Path Attributes pairs, both for BGP and MP-BGP 
 - Many messages in one TCP packet

```
Transmission Control Protocol, Src Port: 179, Dst Port: 42209, Seq: 96, Ack: 75, Len: 539
Border Gateway Protocol - UPDATE Message
Border Gateway Protocol - UPDATE Message
Border Gateway Protocol - UPDATE Message
Border Gateway Protocol - UPDATE Message
Border Gateway Protocol - UPDATE Message
```

- Many NLRIs in one message

```
Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 102
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 43
    Path attributes
        Path Attribute - ORIGIN: INCOMPLETE
        Path Attribute - AS_PATH: 4294965187 65532 65532 65532 65532 
        Path Attribute - NEXT_HOP: 10.125.5.17 
        Path Attribute - COMMUNITIES: 65534:1304 
    Network Layer Reachability Information (NLRI)
        10.11.46.0/24
        10.11.47.0/24
        10.11.64.0/24
        10.11.79.0/24
        10.11.83.0/24
        10.11.88.0/24
        10.11.145.0/24
        10.11.148.0/24
        10.11.150.0/24
```
## NLRI

- NLRI - used for IPv4 only
- MP_REACH_NLRI used for
    - IPv6 Unicast and Multicast
    - VPNv4 / VPNv6
    - L2VPN (EVPN)
    - MPLS-labeled routes
    - Multicast routes (e.g., SAFI 2)

## Neighbors

States:

- Idle - tries to initiate a TCP connection and listens for connections
- Connect - BGP initiates a TCP connection. If there is a TCP collision the router ID is compared and the device with the higher RID becomes the client
- Active - BGP starts a new TCP hand shake
- OpenSent - Open message has been sent - wating for the open message from other Router
- OpenConfirm - Open messages are checked for errors, if everything is OK, Keep alive is sent, it goes to OpenConfirm, if there are errors it goes to Idle
- Established - after this Update messages and Keepalives are sent

### Show neighbors

- `show bgp afi safi neighbors ip-address`

## Path Attributes

<img width="671" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/c5e511a8-6318-4367-9c34-3bacd0ffa26c">
    
**10** attributes in total!   
Only **3** are absolutely mandatory!   

Path attributes fall into four separate categories:

- Well-known mandatory - The PA must be in every BGP Update, all devices have to support it
- Well-known discretionary - he PA is not required in every BGP Update, all devices have to support it
- Optional transitive - not all have to support it, if the router does not understand it, then router should silently forward the PA to other routers without needing to consider the meaning of the PA, so PA will be forwarded anyway
- Optional non-transitive - not all have to support it, if the router does not understand it then it should remove the PA so that it is not propagated to any peers, but if router understands it, it may modify it and send further

### Well-known mandatory

- AS_PATH
- NEXT_HOP
- ORIGIN
  - i - originate the prefix through BGP, network statement
  - e - is no longer used
  - ? - distribute a prefix into BGP from another routing protocol

### Well-known disretionary

- **Local Preference** - used only in iBGP, used to show the best exit from AS, the higher the better route, default - 100. Default value exists only for routes, which originate from this router and with in AS, if router is received from different AS, local preference is empty. If an AS receives multiple routes to the same destination via different eBGP neighbors, it can set a higher LOCAL_PREF on one route (via route maps or policies), and that preference will be communicated to all iBGP peers within the AS. They will then choose the path with the higher LOCAL_PREF when routing traffic out of the AS

- **ATOMIC_AGGREGATE** - The purpose of the attribute is to alert BGP speakers along the path that some information have been lost due to the route aggregation process and that the aggregate path might not be the best path to the destination

### Optional transitive

- **AGGREGATOR** - When some routes are aggregated by an aggregator, the aggregator does attache its Router-ID to the aggregated route into the AGGREGATOR_ID attribute

- **COMMUNITIES**
 
### Optional non transitive

- **ORIGINATOR_ID** - new optional, non-transitive BGP attribute of Type code 9.  This attribute is 4 bytes long and it will be created by an RR in reflecting a route.  This attribute will carry the BGP Identifier of the originator of the route in the local AS. Created by the first route reflector and sets the RID of the router that advertised the route(not the RID of RR!) into AS. If this attribute already exists, then it should not be touched. If routers sees its RID in ORIGINATOR_ID, NLRI is discarded

- **CLUSTER_LIST** - is a new, optional, non-transitive BGP attribute of Type code 10.  It is a sequence of CLUSTER_ID values representing the reflection path that the route has passed. When an RR reflects a route, it MUST prepend the local CLUSTER_ID to the CLUSTER_LIST.  If the CLUSTER_LIST is empty, it MUST create a new one.  Using this attribute an RR can identify if the routing information has looped back to the same cluster due to misconfiguration.  If the local CLUSTER_ID is found in the CLUSTER_LIST, the advertisement received SHOULD be ignored - to put it simple - all RRs, via which route passed, should be on this list

- **Multi Exit Discriminator (MED)** - suggestion to other directly connected networks on which path should be taken if multiple options are available, and the lowest value wins. Transfered from iBGP to eBGP. Allow routers in one AS to tell routers in a neighboring AS how good a particular route is. We send a route with lower MED, and this route becomes preferable. MED is not propagated to a third AS. A router sends MED only to external (eBGP) peers for prefixes that originated inside its own AS. `AS1 > AS2 > iBGP > AS2`  - this will work.

- **Accumulated IGP (Interior Gateway Protocol) metric** - The AIGP attribute allows BGP to use IGP-like metric accumulation across multiple autonomous systems (or within one large AS) to select the shortest path based on true cumulative IGP cost, not just BGP policy values
  - When a route is imported into BGP, the router sets the AIGP metric to the IGP cost from itself to the BGP next-hop
  - Each BGP router that propagates the route adds its own IGP cost to the AIGP value before advertising it onward
  - The receiving router then compares AIGP values among routes — lower is preferred, just like in an IGP 

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

### Weight

- Only for Cisco, works only locally
- Influences only outbound traffic
- Checked in the first place
- Set for a neighbor or via route map for particular matches
- The higher - ther better!

## Best path selection

- BGP router advertises only best path for the route to neighbors
- Best path recalculation happens when:
  - Next hop reachability changes
  - Failure of an interface
  - Redistribution change
  - Reception of new or removed paths

**14 steps/attributes** 

First 10 are main  
Remaining 4 are tiebreackers

1. Is next hop reachable?
2. Weight
3. Local preference - is set when router receives a route. A higher value is a higher preference
4. Locally injected routes - injected into BGP locally (using the network command, redistribution, or route summarization)
5. AIGP
6. AS Path length
7. Origin code, the less - the better
8. Lowest MED
9. Neighbor Type: Prefer external BGP (eBGP) routes over internal BGP (iBGP)
10. IGP metric for reaching the NEXT_HOP, the lower the value, the better the route
11. The oldest path - first which was received
12. Smallest RID of the neighbor
13. Route with the minimum cluster list length
14. Smallest neighbor IP address

- If the best path for an NLRI is determined in Steps 1 through 9, BGP adds only one BGP route to the IP routing table—the best route, of course
- If the best path for an NLRI is determined after Step 9, BGP considers placing mul-tiple BGP routes into the IP routing table
- Even if multiple BGP routes are added to the IP routing table according to ECMP, BGP still chooses only one route per NLRI as the best route; that best route is the only route to that NLRI that BGP will advertise to neighbors

Community based local preference:  

- They are used for inbound traffic engineering. 
- Some transit providers allow their customers to influence the local preference in the transit network through the use of BGP communities
- For example community 174:10 means local preference 10

## Communities

- Cummunity is optional transitive BGP attribute that can traverse from AS to AS
- Any BGP prefix can have more than one tag (BGP community), you can attach up to 32 communities to a single route
- Additional capability for tagging routes and for modifying BGP routing policy
- BGP communities can be appended, removed, or modified selectively on each attribute as a route travels from router to router
- Service providers can make an agreement with your customers on a specific policy to be applied to their prefixes using BGP communities - Incoming traffic engineering - set local preference based on community

Types of BGP communnities
- Standard communities
- Extended communities
- Large communities
- Private communities - work only in local AS
- Public communities - known everywhere

### Standard communities

- Written as numeric 32-bit tags in (AS:Action) format: 3356:70
- The first 16 bits is the (AS) number of the AS that defines the community
- The second 16 bits have the local significance (Action)
- The primary purpose of standard communities is to the group and tag routes so that actions can perform
- The BGP community can be displayed in full 32-bit format (4259840100) or as two 16 bit numbers (0-65535):(0-65535) commonly referred to as new-format

### Well-known standard communities

- Even in configuration we use them as words
- Internet: should be advertised on the Internet - 0:0
- No_Advertise: Routes with this community should not be advertised to any BGP peer (iBGP or eBGP) - 65535:65281
- No_Export: When a route with this community is received, the route is not advertised to any eBGP peer. Routes with this community can be advertised to iBGP peers - 65535:65282
- Local-as: prevent sending tagged routes outside the local AS within the confederation.(route will not send to any EBGP neighbor or any to intra-confederation external neighbor) - 65535:65283

### Extended communities 

- Standard - Not enough for modern uses like MPLS VPNs or cross-provider coordination
- No type field / no structure - Routers just see a 32-bit number — they don’t know what it means
- There’s no built-in way to say, “This tag is a Route Target” vs. “This tag is a QoS policy.”
- No support for IPv6 or 4-byte ASNs
- No room for extended attributes
- MPLS VPNs needed to carry more information per route
- Which VPN a route belongs to (Route Target)
- Which site originated it (Route Origin)
- QoS markings (Color, Bandwidth hints, etc.)
- Written as numeric 64-bit tags in (Type:AS:Membership) format: rt:65000:100
- The first 16 bits are used to encode a type that defines a specific purpose for an extended community, extended community type numbers are assigned by Internet Assigned Numbers Authority (IANA)
- The remaining 48 bits can be used by operators
- Examples: Site of Origin (SOO), Ethernet VPN (EVPN), OSPF Domain Identifier, Route Target

### Large communities 

- Written as numeric 96-bit tags in (Source AS:Action:Target AS) 
- Format split into three 32-bit values which can accommodate more identification data including 4-byte AS numbers

### Configuration

Using Route-maps associated with:

- Network Command
- Aggregate address
- Neighbor command
- Redistribution command

IOS and IOS XE routers do not advertise BGP communities to peers by default

```
#Show in new format
ip bgp-community new-format

neighbor ip-address send-community [standard | extended | both] [additive] - for additional community
```

- Show BGP table with community detail: `show bgp afi safi detail`
- Show BGP table for particular community: `show bgp ipv4 unicast community 333:333`
- Can Delete Community by setting to none on route-map

Match occurs via community list

- Define list
- Standard list matches community name or number 
  - ip community-list 1 standard permit no-export
- Expanded matches regular expression
  - ip community-list expanded AS100 permit 100: [0-9]+
- Reference from route-map
  - match community AS100

### BGP Cost-Community 

- Extended community attribute
- Allows a route originator or controller to signal a cost or preference value across the network — especially for intra-domain traffic engineering
- Influence path selection within an AS

### GSHUT Community

- Standard BGP community used to signal to neighbors that a route is being withdrawn intentionally, such as during a planned maintenance or shutdown
- So before tearing down the BGP session, you advertise routes with the GSHUT community
- Graceful BGP session shutdown
- Used in conjunction with Graceful Restart
- Takes the restarting peer out of the data-path by modifying local preference
- Similar to IS-IS Overload or OSPF Max Metric LSA
- Introduce on Cisco IOS XE Release 3.6S

## BGP tables

- Adj-RIB-In - routes in original form, `before filters`, deleted after processed
- Loc-RIB - all local routes and routes received from beighbors. Validity checked. Next hop reachibility checked. Best path is chosen from this table and presented to routing table
- Adj-RIB-Out - routes `after` outbound filters. It is mainteined for every neighbor separately. Next hop in it is 0.0.0.0 - local router, will be changed after sending

Four flows are possible:

- `Routes from peer > Adj-RIB-In > Inbound Policies > Loc-RIB (BGP database) > Next hop and validity check > Identify best Path > Global Rib`
- `Routes from peer > Adj-RIB-In > Inbound Policies > Loc-RIB (BGP database) > Next hop and validity check > Identify best Path > Outbound policies > Adj-RIB-Out > Routes to peer`
- `Network statement > RIB Check > Loc-RIB (BGP database) > Next hop and validity check > Identify best Path > Global Rib`
- `Network statement > RIB Check > Loc-RIB (BGP database) > Next hop and validity check > Identify best Path > Outbound policies > Adj-RIB-Out > Routes to peer`

- `show bgp` is a newer version than `show ip bgp`, because it takes into an account multiprotocol capabilities of MP-BGP
- `show bgp` afi safi ....` - shows Loc-RIB table

### Show summary

- `show bgp afi safi summary`
- `show bgp all summary` - summary for all address families neighbors
- `show bgp ipv4 unicast summary` - summary for 1 address family
- `show bgp vrf CORE vpnv4 unicast summary` - summary for particular VRF and particular address family

### Show BGP table - Loc-RIB

- `show bgp vrf VRF afi safi`
    - `show bgp ipv4 unicast`
    - `show bgp vrf CORE vpnv4 unicast`
    - `show bgp all`

### Show Advertised networks - Adj-RIB-Out table

`show ip bgp all neighbors 10.90.0.18 advertised-route`

### Show Detailed Loc-RIB table about particular NLRI

`show bgp ipv4 unicast 10.12.10`

### Show Detailed Loc-RIB about all routes

`show bgp afi safi detail`

### Show Global RIB BGP routes

`sh ip route bgpe`

## Capabilities

Specified in OPEN message

```
Border Gateway Protocol - OPEN Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 157
    Type: OPEN Message (1)
    Version: 4
    My AS: 65001
    Hold Time: 90
    BGP Identifier: 192.0.2.1
    Optional Parameters Length: 104
    Optional Parameters (104 bytes)
        Parameter: Capability (2), length: 6
            Capability Code: Multiprotocol extensions (1)
            Capability Length: 4
            AFI: IPv6 (2)
            Reserved: 0
            SAFI: Unicast (1)
        Parameter: Capability (2), length: 6
            Capability Code: Multiprotocol extensions (1)
            Capability Length: 4
            AFI: L3VPN (1)
            Reserved: 0
            SAFI: MPLS-labeled VPN address (128)
        Parameter: Capability (2), length: 2
            Capability Code: Route Refresh (2)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: Outbound Route Filtering (3)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: Extended Next Hop Encoding (5)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: Graceful Restart (64)
            Capability Length: 0
        Parameter: Capability (2), length: 6
            Capability Code: 4-Octet AS Number (65)
            Capability Length: 4
            4-Octet ASN: 65001
        Parameter: Capability (2), length: 2
            Capability Code: Add-Path (69)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: Enhanced Route Refresh (70)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: Long-Lived Graceful Restart (71)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: FQDN Capability (73)
            Capability Length: 0
        Parameter: Capability (2), length: 2
            Capability Code: BGP Role (9)
            Capability Length: 1
            Role: Provider
```

## Autonomous System Numbers

- Can be 16 bit (2 bytes) and 32 bit (4 bytes)
- 0 to 65535 - for 2 bytes
- Reserved: 0, 23456, 65535 - ?
- Public: 1 - 64495, 65552 - 4 199 999 999
- Private: 64512 - 65534, 4 200 000 000 - 4 294 967 294
- Notation options: ASPLAIN 0 - 4 294 967 294, ASDOT 0 - 65535.65535
- We can substitute AS number for particular neighbor. For example we can do it, when we connect VRFs in fabric via external Firewall and to avoid "allow as in" option we configure different ASNs for different VRFs to peer with firewall 

## Prefix Advertisment

- What networks are advertised by default? - none - only received via BGP
- Network command: Look for a route in the router’s current IP routing table (global RIB) that **exactly** matches the parameters of the network command; if the IP route exists, put the equivalent NLRI into the local BGP table (Loc-RIB). With this logic, connected routes, static routes, or IGP routes could be taken from the IP routing table and placed into the BGP table for later advertisement. When the router removes that route from its IP routing table, BGP then removes the NLRI from the BGP table, and notifies neighbors that the route has been withdrawn. If auto-summary is enabled, then it matched all of its subnets
- network command limits may be overiden with route maps. If there is an explicit route-map specifying which routes can be advertised out, then even if there is NO route in routing table, but route is specified in network command + in route map, it will be advertised. Route map is applied to neighbor out. Example:

```
ip prefix-list INFRA-out seq 100 permit 42.153.2.0/24
route-map INFRA_out permit 10
 match ip address prefix-list INFRA-out
router bgp 4294965111
  network 42.153.2.0/24
  neighbor 10.127.117.2 route-map INFRA_out out

```

- network command does not enable interfaces
- route-map can be used in network command to manipulate path attributes, including next hop
- BGP only advertises the best path to other BGP peers, regardless of the number of routes in Loc-RIB table
- network command is used under address family section
- `network network mask subnet-mask route-map route-map-name`
- route map is used for setting specific PAs, when prefix is installed into Loc-RIB

Attributes set for network command:

- Connected network - next hop BGP attribute - 0.0.0.0, BGP origin - i (IGP), wight - 32768
- Static route or routing protocol - next hop IP is taken from the RIB, BGP origin - i (IGP), wight - 32768, MED - IGP metric

Checks before sending routes from Loc-RIB to peers:

- Validity check - NLRI is valid, next hop is reachable
- Outbound neighbor route policies
- If next hop BGP PA is 0.0.0.0, it is changed to the IP address of BGP session

Process flow: `Network statement > RIB check > Loc-RIB (BGP database) > Validity check > Outbound route policies > Adj-RIB-Out table > Routes to peer`  

Example:

```
router bgp 3
neighbor 1.1.1.1 remote-as 4

address-family ipv4
  network 2.2.2.0 mask 255.255.255.0
  neighbor 1.1.1.1 activate
```

## Summarization/aggregation

- In BGP world it is called aggregation - it is a whole world with attributes and rules
- Conserve router resources
- Accelerated best path calculation
- Stability: hiding route flaps from downstream routes
- Most service providers do not except prefixes larger then /24
- We configure summarization in address family section for Nexus and it works for all neighbors, we specify summarized prefix there with as-set option and summer only, without summer only option it will advertise all prefixes plus summary
- No auto-summary is the default
- Dynamic route summarization is done via address-family command 
    - aggregate-address network subnet-mask [summary-only] [as-set]
- `as-set` means to keep AS_PATH information from small agregated routes
- Example: 172.16.1.0/24, 172.16.2.0/24, 172.16.3.0/24 are aggregated with command: aggregate-address 172.16.0.0 255.255.240.0
- This command will add to BGP table prefix 172.16.0.0/20 - but it will not delete smaller route
- summer-only option suppresses the component network prefixes
- Suppression - when BGP process does not advertise routes (fo example connected) because of aggregation
- When new summary route is advertised it is advertised without any previous attributes or AS Path. It is sent as if an aggregating router is an originator of route: AS Path contains only AS of aggregating router
- Atomic-aggregate and Aggregator Path Attributes is added by the aggregator and all other routers see in BGP table: aggregated by 65200 192.168.2.2 
- Aggregated route appears in BGP table only after at least one viable component route enters BGP table, for example 172.16.1.0/24
- After enabling aggregation BGP installs aggregated route to RIB of originating router with gateway Null0 - it is called summary discard route it is created to avoid loops
- Loops explanation: R1 aggregates 192.168.1.0/24 and 192.168.2.0/24 and sends to everyone 192.168.0.0/16. After this it gets a packet with destination 192.168.3.1 - it does not know about this network - and what it does? It sends it to default gateway! - Bad! And if summary discard route is installed this packaet will be silently dropped :)
- To sum up agrregated route is in two tables: RIB and BGP, in BGP default route is 0.0.0.0 and in RIB NULL0
- Component routes are still in BGP table but they have status - s -suppressed
- If we configure summarization, for example two LANs connected to Leaf, and then if we disconnect one LAN, summerized route will continue propogating and everyone will consider this LAN available. Especially summarization is unacceptable on Spines. This is relevant only with "summer only" option
- Static summarization: we add static route with Null0 as gateway,then advertise it with `network` command or `redistribute static`
- The route with AD 254 ensures the prefix remains in the routing table only as a last resort when no other routes exist
- The tag 50 in the static route can be used for route filtering or policy purposes, such as identifying and applying specific policies to this route in redistribution or routing decisions

Example:

```
ip route vrf core 192.168.0.0 255.255.0.0 Null0 254 tag 50

router bgp <ASN>
 address-family ipv4
   aggregate-address 10.99.0.0/31 summary-only
   redistribute static route-map redistribute_static

route-map redistribute_static permit 10 
 match tag 50
 set local-preference 50
 set weight 0
 set origin incomplete
 set community 65534:10 additive
```

## Route filtering

- Pure filtering: In BGP, you can directly apply prefix-lists, distribute-lists, or filter-lists(AS Path ACL) to a neighbor without a route-map
- Advanced filtering: When you do need a route-map
  - Match multiple attributes (prefix + AS_PATH + community, etc.)
  - Set attributes (e.g. local-pref, MED, next-hop, weight)
  - Perform conditional redistribution (e.g., from OSPF into BGP)
  - Filter based on communities
  - Tag or modify routes
- Distribute lists - old syntax  - Based on ACL

Conditional matching

- ACL
- Prefix list
- AS Path ACL + Regex

### ACL

- Compesed of access control entries - ACE
- Starts at the top and proceeds down
- Once match is found, action is applied and processing is stopped
- At the end implicit deny
- Standard ACL: only source network, named ACL, 1-99, 1300-1999
- Extended ACL - source, destination, protocol, port, named, 100-199, 2000-2699

```
ip access-list standard 85|name
10 permit|deny 192.168.0.0 0.255.255.255
20 permit|deny any
30 permit|deny host 192.168.1.1

ip access-list extended 150|name
10 permit|deny ip any any
20 permit|deny ip host 192.168.1.1 host 192.168.1.2
```

- Different matching for BGP and IGP
- For BGP: source and source wildcard for Matches Networks
- For BGP: destination and destination wildcard for Matches Network Mask
- For BGP: `permit ip 10.0.0.0 0.0.255.0(permit any 10.0.x.0 network) 255.255.255.0 0.0.0.0 (with /24 prefix length)`
- For IGP - ?
 
 ### IP prefix

- Describes prefix number and its length
- Used by route map, and route map is used by redistribute
- One or more statements with the same name
- Each has a sequence number
- Permit or deny, means if packet should match statement or not
- Goes up to down
- First match - stop

Example on Cisco IOS, allow send to BGP neighboor all networks except one:

```
ip prefix-list BLOCK_EXTERNAL seq 10 deny 159.33.0.0/24
ip prefix-list BLOCK_EXTERNAL seq 20 permit 0.0.0.0/0 le 32

route-map BLOCK_EXTERNAL permit 10
match ip address prefix-list BLOCK_EXTERNAL
 
neighbor 192.168.5.1 route-map BLOCK_EXTERNAL out
```

**le/ge**

- `ip prefix-list test seq 5 permit 192.168.1.0/24 ge 32` - allow all /32 prefixes in 192.168.1.0/24 network - 192.168.1.1/32, 192.168.1.100/32, 192.168.1.255/32
- `ip prefix-list test seq 10 deny 192.168.1.0/24 ge 25 le 27` - allow all /25-/27 networks in 192.168.1.0/24 network - 192.168.1.0/25, 192.168.1.128/25, 192.168.1.0/26
- To avoid writing dozens (or hundreds) of individual entries for subnets of a larger prefix
 
### AS Path ACL + Regex

```
ip as-path access-list 1 permit ^65001$
# ^65001$ means: “The entire AS_PATH consists of just AS 65001

ip as-path access-list 2 permit _65001_
#_65001_ means: “AS 65001 appears anywhere in the path

route-map FROM_CUSTOMER permit 10
 match as-path 3
```

### Route maps

- Allow or denies a route based on conditions + change route options
- Route map can be added after network command and after neighbor command
- network route-map command changes attributes before adding prefix to BGP table, except AS path
- neighbor route-map in|out applies changes to updates, sent or received. It also acts as filter, it can drop update based on match
- Implicit deny at the end
- Continue keyword - continue even after match
- Allow or deny route is specified in route map action: permit or deny
- If match is empty - all routes
- Set command to change route options
- Has 4 components:
  - Sequence number
  - Conditional matching criteria - if empty - all prefixes - as-path, ip address, ip address prefix list, local preference, metric, tag
  - Processing action: permit(default) or deny
  - Optional action: modify route options: as=path prepend, next hop, local preference, metric, origin, tag, weight

```
route-map example 10 permit 10
match ip address ACL
set metric 20
```

## Redistribution

 - When we configure redistribution from OSPF weight is 32768, Path is ?, Local Pref is not set by default, origin code is Incomplete - ?
 - Metric of origin protocol is reflected in MED - one to one
 - To control it  we need route map
 - OSPF external (E1/E2) routes default to MED = 0 unless overridden

Redistribution from ospf

```
#Option 1

router bgp 2
redistribute ospf 1

#Option 2 - MED control

route-map OSPF-to-BGP permit 10
set metric 50  ! Manually set MED to 50

router bgp 65000
redistribute ospf 1 route-map OSPF-to-BGP
```

## Timers

- Advertisment interval - default eBGP 30 sec, iBGP 0 sec - 0 secs for Clos - send updates immediately after receiving
- Keepalive - default 60 secs - 3 sec for CLOS - how often to send HELLOs
- Hold - default 180 sec -  9 sec for CLOS - how long to wait for dead peer
- Connect - default 30 sec - reconnect interval on Nexus - 12 sec for CLOS - interval after which a dropped BGP connection can automatically reconnect
- BFD - Tx/Rx 100 ms x 3 - for CLOS
- MicroBFD if LAG is used - for CLOS

## Restart/Clear/Reset BGP connections

**Hard reset**

- Tearing down the TCP session between BGP peers, forcing a complete re-establishment and full route exchange
- It interrupts traffic for that session
- Use hard reset only when:
  - A session is stuck (e.g., Active/Idle forever).
  - Route refresh or soft reset doesn’t fix route inconsistency
- Otherwise, prefer `clear ip bgp <neighbor> in` (route refresh) — it’s safe and non-disruptive

```
configure terminal
router bgp 4294965004
clear ip bgp 10.125.5.20
```

**BGP Graceful Restart (GR)**

- Purpose: Keep forwarding traffic during a control-plane restart
- When a BGP process (or router) restarts, but the data plane keeps forwarding packets
- Before restart, both peers must have advertised the Graceful Restart capability
- If one router restarts, its peer marks routes from it as “stale” instead of removing them immediately
- If the restarting router comes back before a timer expires and re-advertises routes — session recovery is seamless
- If it doesn’t, the stale routes are withdrawn after the timer expires
- Graceful shutdown A feature in routing protocols allowing a router to inform its neighbors about its impending deactivation. The neighbors can react to this indication immediately, instead of waiting for the Hold or Dead intervals to expire.

```
router bgp <ASN>
 bgp graceful-restart
```

**Soft Reset (Inbound / Outbound)**

- Historically, if you changed a route-map, you had to clear ip bgp * — which resets the TCP session (bad)
- Soft reset allows you to reapply policies without session reset
- nbound soft reset originally required storing all received routes in memory — heavy resource use. That’s why route refresh was introduced
- `clear ip bgp <neighbor> soft in|out`

**Route Refresh**

- Purpose: Lightweight alternative to **inbound** soft reset
- If both peers support Route Refresh capability, your router can simply ask the neighbor to resend its routes
- The neighbor re-advertises its routes; your router applies new inbound policies when processing them
- No need to store Adj-RIB-In in memory
- `clear ip bgp <neighbor> in`

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

Don't use or advertise the route/s learned via an iBGP neighbor to an eBG neighbor unless & until the same is/are learned via some other IP like RIP, OSPF, EIGRP... Synchronization is no longer a default  and is not commonly used. Earlier it was used when network prefixes were redistributed to IGP.

## MP-BGP

- MP-BGP (Multiprotocol BGP, defined in RFC 4760) is not a separate protocol — it’s the same BGP-4, but extended with new capabilities and attributes to support multiple address families (AFI/SAFI), such as IPv6, VPNv4, multicast, EVPN, etc
- Over **one IPv4 BGP session**, MP-BGP can exchange IPv4, IPv6, EVPN, VPNv4, and other address families — as long as both peers advertise support for those AFI/SAFI values
- During session establishment (OPEN message), both peers advertise their capabilities (Capability Advertisement, per RFC 5492)
  - One of these is the Multiprotocol Extensions Capability, which lists which AFI/SAFI pairs the router supports (e.g., IPv4-unicast, VPNv4, EVPN)
  - If both sides support the same AFI/SAFI, MP-BGP for that family becomes active
- After the session is established, routes for each AFI/SAFI are exchanged **using The MP_REACH_NLRI and MP_UNREACH_NLRI path attributes instead of NLRI field in BGP-4 UPDATEs**
- If peers don’t advertise MP-BGP capability, the session defaults to classic BGP-4 (IPv4 unicast only)
- AFI/SAFI pair is explicitly encoded in each UPDATE’s MP_REACH_NLRI (or MP_UNREACH_NLRI) attribute, defining which address family the NLRI belongs to (e.g., IPv6, VPNv4, EVPN, etc.)
- Unicast and multicast are stored in different tables
- When MP-BGP is configured, BGP installs the MP-BGP routes into different routing tables. Each routing table is identified by the protocol family or address family indicator (AFI) and a subsequent address family identifier (SAFI).
- New optional and nontransitive attributes in the UPDATE message (specifically the MP_REACH_NLRI and MP_UNREACH_NLRI attributes):
  - Multiprotocol reachable NLRI - install route
  - Multiprotocol unreachable NLRI - withdraws route
- Non-Transitive: Means they are not passed to other BGP peers only if router does not understand it
- Enabling MP-BGP capability doesn’t automatically move IPv4 routes into MP attributes
- IPv4 Unicast still uses the legacy NLRI
- All other AFI/SAFI families (IPv6, VPNv4, EVPN, etc.) use MP_REACH_NLRI and MP_UNREACH_NLRI
- Some modern vendors (Cisco IOS XR, Juniper, Arista, Nokia SR OS, etc.) do support exchanging IPv4 unicast routes via MP_REACH_NLRI — but only if both sides explicitly negotiate AFI 1 / SAFI 1 under the multiprotocol capability
- The next hop can even be IPv6, allowing “IPv4 NLRI over IPv6 transport” (common in IPv6-only cores)

Open message:

```
Border Gateway Protocol - OPEN Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 73
    Type: OPEN Message (1)
    Version: 4
    My AS: 65001
    Hold Time: 90
    BGP Identifier: 192.0.2.1
    Optional Parameters Length: 32
    Optional Parameters (32 bytes)
        Parameter: Capability (2), length: 6
            Capability code: Multiprotocol extensions (1)
            Capability length: 4
            AFI: IPv6 (2)
            Reserved: 0
            SAFI: Unicast (1)
        Parameter: Capability (2), length: 6
            Capability code: Multiprotocol extensions (1)
            Capability length: 4
            AFI: L3VPN (VPNv4) (1)
            Reserved: 0
            SAFI: MPLS-labeled VPN address (128)
        Parameter: Capability (2), length: 2
            Capability code: Route Refresh (2)
            Capability length: 0
        Parameter: Capability (2), length: 6
            Capability code: 64-bit ASN (65)
            Capability length: 4
            4-octet ASN: 65001
        Parameter: Capability (2), length: 2
            Capability code: Graceful Restart (64)
            Capability length: 0
```

Update message for EVPN:

```
Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 160
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 124
    Path attributes
        Path Attribute - ORIGIN: IGP (1)
        Path Attribute - AS_PATH: 65001
        Path Attribute - NEXT_HOP: 0.0.0.0
        Path Attribute - LOCAL_PREF: 100
        Path Attribute - MP_REACH_NLRI (14), length: 104
            Flags: 0x90 (Optional, Non-transitive, Extended Length)
            Type Code: MP_REACH_NLRI (14)
            Address Family Identifier (AFI): L2VPN (25)
            Subsequent Address Family Identifier (SAFI): EVPN (70)
            Next Hop Network Address Length: 4
            Next Hop: 192.0.2.1
            Reserved: 0
            Network Layer Reachability Information (NLRI)
                EVPN NLRI: Route Type 2 (MAC/IP Advertisement)
                    Route Type: 2 (MAC/IP Advertisement)
                    Length: 49
                    Route Type 2 - Fields
                        RD: 65001:100
                        Ethernet Segment Identifier (ESI): 00:00:00:00:00:00:00:00:00:00
                        Ethernet Tag ID: 100
                        MAC Address Length: 48
                        MAC Address: 00:11:22:33:44:55
                        IP Address Length: 32
                        IP Address: 10.1.1.10
                        MPLS Label1: 2000
                        MPLS Label2: 0 (Bottom of Stack)
```

Update message for IPv6

```
Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 104
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 78
    Path attributes
        Path Attribute - ORIGIN: IGP (1)
        Path Attribute - AS_PATH: 65001
        Path Attribute - LOCAL_PREF: 100
        Path Attribute - MP_REACH_NLRI (14), length: 54
            Flags: 0x90 (Optional, Non-transitive, Extended Length)
            Type Code: MP_REACH_NLRI (14)
            Address Family Identifier (AFI): IPv6 (2)
            Subsequent Address Family Identifier (SAFI): Unicast (1)
            Next Hop Network Address Length: 16
            Next Hop: 2001:db8:0:1::1
            Reserved: 0
            Network Layer Reachability Information (NLRI)
                2001:db8:100::/64
```

### Address families

- Originally, BGP was intended for routing of IPv4 prefixes
- RFC 2858 added Multi-Protocol BGP (MP-BGP) capability by adding an extension called the address family identifier (AFI)
- Address family shows particular network protocol, for example IPv4, IPv6
- Additional granularity is provided through a subsequent address-family identifier (SAFI) such as unicast or multicast
- MP-BGP achieves this separation by using the BGP path attributes (PAs) MP_REACH_NLRI and MP_UNREACH_NLRI
- These attributes are carried inside BGP update messages and are used to carry network reachability information for different address families
- Every address family maintains a separate database and configuration for each protocol (address family + sub-address family) in BGP
- BGP includes an AFI and SAFI with every route advertisement to differentiate between the AFI and SAFI databases
- IOS activates IPv4 address family by default
- On IOS and IOS XE default SAFI is Unicast
- One TCP connection → multiple AFI/SAFI route exchanges possible
- Each AFI/SAFI = separate routing context, import/export policy, and RIB
- Address family is activated for each neighbor

Example of several address families for 1 neighbor:

```
router bgp 65001
  neighbor 10.0.0.2 remote-as 65002
  address-family ipv4
    neighbor 10.0.0.2 activate
  address-family ipv6
    neighbor 10.0.0.2 activate
  address-family vpnv4
    neighbor 10.0.0.2 activate
```

### Families(15 in total)

| # | Address Family | AFI | SAFI | Description |
|---|----------------|-----|------|--------------|
| 1 | **IPv4 Unicast** | 1 | 1 | Standard BGP family for IPv4 unicast routing. Used to exchange regular IPv4 routes. |
| 2 | **IPv4 Multicast** | 1 | 2 | Used for IPv4 multicast routing. Carries multicast route and group information. |
| 3 | **IPv6 Unicast** | 2 | 1 | Used to advertise IPv6 unicast routes. |
| 4 | **IPv6 Multicast** | 2 | 2 | Used for IPv6 multicast routing. |
| 5 | **VPNv4 (IPv4 MPLS L3VPN)** | 1 | 128 | MPLS-based VPNs for IPv4 routes. Routes carry a Route Distinguisher (RD) and Route Target (RT) to identify VRFs. |
| 6 | **VPNv6 (IPv6 MPLS L3VPN)** | 2 | 128 | Same as VPNv4 but for IPv6 routes in MPLS-based VPNs. |
| 7 | **Labeled IPv4 Unicast** | 1 | 4 | Advertises IPv4 unicast routes with MPLS labels (RFC 8277). |
| 8 | **Labeled IPv6 Unicast** | 2 | 4 | Advertises IPv6 unicast routes with MPLS labels. |
| 9 | **L2VPN (VPLS / Pseudowire)** | 25 | 65 | Used for Layer 2 VPNs such as VPLS and point-to-point pseudowires (RFC 4761, RFC 6074). |
| 10 | **EVPN (Ethernet VPN)** | 25 | 70 | Used for Ethernet VPNs (RFC 7432, RFC 8365). Advertises MAC/IP bindings and Ethernet segments. |
| 11 | **FlowSpec IPv4** | 1 | 133 | Distributes IPv4 traffic flow specifications (RFC 8955). Used for DDoS mitigation and traffic control. |
| 12 | **FlowSpec IPv6** | 2 | 133 | IPv6 version of FlowSpec (RFC 8956). |
| 13 | **Multicast VPN (MVPN IPv4)** | 1 | 129 | Used for multicast routing within MPLS VPNs (RFC 6514). Carries multicast VPN membership info. |
| 14 | **EVPN Type 5 (IP Prefix Route)** | 25 | 70 | Not a separate AFI/SAFI — a route type within EVPN for IP prefix advertisement. |
| 15 | **SR-TE (Segment Routing Traffic Engineering)** | 1 or 2 | 73 or 76 | Used to advertise Segment Routing policies for IPv4/IPv6 (RFC 9012). |

## IPv6

```
router bgp 65100
no bgp default ipv4-unicast
neighbor 2001:DB8:0:12::2 remote-as 65200

address-family ipv6
neighbor 2001:DB8:0:12::2 activate
redistribute connected
network 2001:DB8::2/128
aggregate-address 2001:DB8::/59 summary-only

show bgp ipv6 unicast neighbors 2001:DB8:0:12::2
```

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

iBGP vs eBGP

- TTL in IP header, eBGP - 1, iBGP-255
- eBGP router modifies next hop to its own address sourcing BGP connection
- eBGP router prepends its ASN to the existing AS_Path variable
- Receiving eBGP router checks AS_Path, so it does not have its own AS already
- iBGP route cannot be forwarded to another iBGP router, to avoid loops

Concepts

- iBGP sessions: the same AS or the same confederation
- AD - 200
- Used for transit connectifity in one AS - used mostly in service providers
- eBGP routes are never redistributed to IGPs inside AS, there are too many of such routes
- AS 1 router > eBGP > AS 2 router > OSPF > AS 2 router > EIGRP > AS 2 router > eBGP > AS 3 router
- Thay just build iBGP mesh between all routers in AS 2 and IGP inside AS as underlay is used
- iBGP requires underlay IGP for full mesh or route reflectors or confederations
- iBGP carries routes about external subnets and IGP carries routes about internal AS subnets
- iBGP packets default to TTL 255
    - Implies neighbors do not have to be connected as long as IGP reachability exists
- iBGP peers typically peer via Loopbacks
    - Allows rerouting around failed paths via IP
    - Required for some application such as MPLS L3VPN
    - Loopback interfaces are advertised into the IGP
    - Interface update source should be configured for each neighbor as Loopback
    - No need to recompute best path if one of the links fails
    - Automatic load balancing if there are multiple equal-cost paths through IGP
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
- By default outbound iBGP updates do not modify the next-hop attribute regardless of iBGP peer type
- When next hop is not modified, then peering networks (between edge router and router of other AS) need to be advertised to iBGP or IGP, so all routers can reach unchanged next hop address of router from neighbor AS
- To avoid this advertisment of peer networks next modification is used
- Can be modified
  - neighbor next-hop-self - enabled on edge routers for neighborship with internal routers
  - route-map action set ip next-hop
  - "next-hop-self ALL" for inserting RR in the data-path: packets will go via RR: Used in Unified MPLS design

Full Mesh Design Advantages

- Path Diversity - All BGP peers learn all possible egress paths
- Optimal Traffic Flows - All BGP peers learn the closest egress path
- Path selection by default would be based on IP metric to egress router - I.e. Hot Potato Routing

Hot potato routing

- Network routing strategy
- Router forwards a packet to the next available hop as quickly as possible—**"getting rid of it" like a hot potato—**with minimal delay or consideration for the optimal end-to-end path
- Real-World Example:
  - Two ISPs, A and B, exchange traffic at multiple locations.
  - ISP A receives a packet destined for a customer of ISP B.
  - With hot potato routing, ISP A finds the nearest point where it peers with ISP B and forwards the packet there—letting ISP B handle the rest, regardless of overall efficiency.

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

This is one of iBGP scaling techniques  

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

- Inter-Cluster peerings between RRs can be client or non-client peerings
  - Depends on redundancy design
  - Duplicate routes, more processing
- Cluster-ID is based on Router-ID
  - By default all RR are in separate clusters
- Same cluster-id on both clusters or not?
  - Depends on redundancy design...
- An inter-cluster peering is a regular iBGP session between:
  - Two Route Reflectors from different clusters, or
  - A Route Reflector and a non-client router in a different cluster.
- These peers are not clients of each other, so route reflection rules do not apply. Instead, they follow the normal iBGP rules:
  - A route learned from one iBGP peer is not advertised to another iBGP peer, unless it's a client (which they are not in this case).
- To ensure full propagation between clusters, RRs need to peer with other RRs (or route reflector clients) in other clusters, or you use full mesh between RRs

Example Topology:

```
          Cluster A                   Cluster B
         -----------                -----------
         RR1 (1.1.1.1)              RR2 (2.2.2.2)
         /        \                /        \
       R1          R2            R3          R4

      iBGP          iBGP        iBGP         iBGP
      (client)      (client)    (client)     (client)

                Inter-cluster peering
                   RR1 <-------> RR2
```

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

### Cluster ID

- A Cluster ID is a unique identifier assigned to a Route Reflector cluster. A cluster is a group of iBGP routers that includes:
  - One Route Reflector (RR)
  - One or more Route Reflector Clients (RRCs)
- To prevent loops, each reflected route includes a Cluster List
- If an RR sees its own Cluster ID in a received update’s Cluster List, it rejects the route—this avoids looping the route back into the cluster
- Cluster ID is included in BGP UPDATE messages, but only within iBGP Route Reflector environments, and only for internal use between RRs and their peers—specifically as part of an optional, non-transitive BGP attribute called the Cluster List
- It is set by RR, not the client

Configuration example:

```
router bgp 65001
 bgp cluster-id 1.1.1.1      ! Set cluster ID manually (optional)
 neighbor 10.0.0.2 route-reflector-client
```

If bgp cluster-id is not set, the Router ID of the RR is used by default

### Confederation

This is one of iBGP scaling techniques

- Reduces full mesh iBGP requirement by splitting AS into smaller Sub-AS
- Inside Sub-AS full mesh or RR requirement remains
- Between Sub-AS acts like EBGP
- Devices outside the confederation do not know about the internal structure
- Sub-AS numbers are stripped from advertisements to "true" EBGP peers
- Typically uses ASs in private range: 64512 - 65535
- Can use different IGPs in each Sub-AS
- Next-hop self on border routers
- Next-hop, Local-Pref, and MED are kept across Sub-AS eBGP peerings
- BGP Confederation Loop Prevention: AS CONFED SEQUENCE, AS CONFED SET, these attributes never leave the confederation
- Any router in confederation in any sub-AS can form EBGP neighborship with external AS routers

  <img width="856" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/a77966f2-0f16-4a17-9c12-e7b121f45da6">

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
- Bogons - bogon prefixes are leaked to public internet and hosts in LAN become available from the Internet. The same with bogon AS numbers - may be dropped by other provider.

## Bogon ASNs

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

## BGP Route Dampening

- Route dampening is designed to minimize the propagation of flapping routes across an internetwork
- A route is considered to be flapping when its availability alternates repeatedly
- Cnfiguration

```
router bgp as-number
address-family ipv4 [unicast | multicast | vrf vrf-name ]
bgp dampening [half-life reuse suppress max-suppress-time ] [route-map map-name ]
```

## BGP AS Path Manipulations

### local-as

```
router bgp 65000
neighbor 1.1.1.1 local-as 2 no-prepend replace-as dual-as`
```

- Can only be used with EBGP peers
- By default, the **alternate** ASN is added to the AS_PATH for routes that are **sent** and **received** between the peers
- 2 will be used on peer router to establish neigborship
- Peer router will see in the PATH both AS numbers: 65000 and 2
- Routes received from remote route will also be prepanded with 2
- It is very usefull when we connect VRFs in Fabric via external  firewall
- no-prepend - if we want to stop the alternate ASN from being prepended when receiving routes
- replace-as - to stop the alternate ASN from being prepended when sending routes
- local-as directive does not influence how receiving of routes is checked, AS path in received routes will be still compared with general AS number 65000 - and you will see drops only on debug stage, you will not see it in a received route stage
- If route passes the same router twice via different VRFs, we need to use local-as in all VRFs not in only one
- dual-as - allows the remote peer to use either ASN for the BGP session

### allowas-in

### remove-pravate-as

### Prepend

### Regexp + as-path access-lists

### as-path replace

## Configuration

### IOS

- Initialize BGP routing process - `router bgp 65100`
- Optional - define RID - `bgp router-id 1.1.1.1` - can be done for VRF
- Configure neighbors - `neighbor 10.1.1.1. remote-as 65200`
- Initialize address families - `address family afi safi vrf VRF_NAME`
- `no bgp default ipv4-unicast` - prevents the router from automatically activating the IPv4 address family for new BGP neighbors
- Add neighbor to address family `neighbor 10.1.1.1 activate` - so we configure neibors for each address family separately
- Neighbor can be completely configured inside address family section - this is the only option when we work with VRF, in general section all neighbors are created for default vrf
- If VRF is used, ipv4 family cannot be used, so all VRF routes are stored in VPNv4 table, even though it is configured in ipv4 address family
- In BGP, the ipv4 address family is reserved for global (non-VRF) IPv4 routes
- For VRFs, IPv4 routes are included in the vpnv4 table, so commands like `show bgp vrf CORE vpnv4` are used to inspect the routes
- Inject routes: connected, static, from other protocols
- If VRF is used it requires to enable address family for it and RD
- If we enter `neighbor 1.1.1.1 remote-as 65200` - it will be enough, because ipv4 address family is enabled by default in IOS, no need to activate it under address family section  

Example

```
router bgp 1
 bgp log-neighbor-changes
 no bgp default ipv4-unicast
 !
 address-family ipv4 vrf CORE
  neighbor 192.168.1.2 remote-as 2
  neighbor 192.168.1.2 activate
 exit-address-family
```

### Neighbors

IOS-XE

```
router bgp 4294966004
address-family ipv4 vrf TEST
bgp router-id 10.16.0.144
neighbor 192.168.111.12 activate
neighbor 192.168.111.12 shutdown
neighbor 192.168.111.12 remote-as 65532
neighbor 192.168.111.12 local-as 396367 no-prepend replace-as
neighbor 192.168.111.12 description lab_tunnel
neighbor 192.168.111.12 shutdown
neighbor 192.168.111.12 ebgp-multihop 255
neighbor 192.168.111.12 password 7 121B0A051C591E1124
neighbor 192.168.111.12 version 4
neighbor 192.168.111.12 activate
neighbor 192.168.111.12 send-community
neighbor 192.168.111.12 soft-reconfiguration inbound
neighbor 192.168.111.12 route-map map1_in in
neighbor 192.168.111.12 route-map map1_out out
```

### Nexus

```
router bgp 64703
  router-id 10.10.2.7
  bgp default local-preference 200 - It will be added to all routes to all neighbors
  address-family ipv4 unicast
    network 10.10.2.7/32

vrf OTUS2
neighbor 192.168.6.2
remote-as 64800



neighbor 192.0.2.1 allowas-in 3
# router will accept routes from the neighbor that include up to 3 occurrences of the local AS

address-family ipv4 unicast

# Change local preference per route - done with a route map

R3(config)# ip prefix-list net4 4.4.4.0/24
R3(config)# route-map PREF permit 10
R3(config-route-map)# match ip address prefix-list net4
R3(config-route-map)# set local-preference 300
R3(config)# router bgp 1
R3(config)# neighbour 192.168.35.5 route-map PREF in

```

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

### Basic configuration


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

**One large configuration file on Nexus with comments, based on my experience**

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

### IOS XE neighbor in VRF with replace AS, BFD, community, route-map, authentication

```
address-family ipv4 vrf IPSEC
  bgp router-id 10.125.0.144
  neighbor 10.125.5.20 remote-as 4294965186
  neighbor 10.125.5.20 local-as 4294965187 no-prepend replace-as
  neighbor 10.125.5.20 description Firewall
  neighbor 10.125.5.20 ebgp-multihop 3
  neighbor 10.125.5.20 password 7 06040033421C1B0C0B
  neighbor 10.125.5.20 version 4
  neighbor 10.125.5.20 fall-over bfd
  neighbor 10.125.5.20 activate
  neighbor 10.125.5.20 send-community
  neighbor 10.125.5.20 soft-reconfiguration inbound
  neighbor 10.125.5.20 route-map IPSec_ASRVPN_BGP_in in
  neighbor 10.125.5.20 route-map IPSec_ASRVPN_BGP_out out
```

## Troubleshooting

### Debug BGP updates on Nexus

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

### Debug in IOS

```
debug ip bgp updates
debug ip bgp events
debug ip bgp filters
debug ip bgp dampening
debug ip bgp neighbor 10.125.5.20
debug ip bgp network 10.105.4.128
debug ip bgp 10.125.5.20
debug ip bgp 10.125.5.20 updates

conf t
logging buffered 100000000 debugging
end

no terminal monitor

Show logging -  after this - and log session to file

show debug

undebug all
```

## BGP InterAS Option A

## BGP InterAS Option C

## Outbound traffic manipulation

- Local preference
- Weight

## Inbound traffic manipulation

- AS Path Prepending
- BGP communities
- MED