# BGP

## Concepts
- Routing protocol that is used to exchange network layer reachability information (NLRI) between routing domains
- Internet de facto protocol, Routing protocol of Intenet, Port 179 TCP, EGP
- In general, it is an application, which establishes connection and exchange information: IPv4, IPv6, l2vpn, VPnv4...All data in a packet is presented in the form of Path attributes, all these make it very flexible
- It is not binded to interface, we just configure neighbors and then connect to them according to routing table
- It does not use metric like IGP to calculate best route, it uses many steps and PAs
- Only one BGP process can be launched with VRFs and using local-as option to send different AS number
- If we use VRF, one BGP process, one AS number, different neighbors for different VRFs
- Path vector protocol
- Updates are sent only after changes in network
- Metric: attributes
- Does not know about all networks, knows only about neighboors
- Use of BGP for Routing in Large-Scale Data Centers - RFC 7938: private ASN, single-hop, AS numbering to avoid path hunting, timers hardening, BFD
- Very slow convergance by design, Hello - 60 sec, Dead - 180 sec
- ECMP to work: AS Path should be absolutely identical
- The AD Values: eBGP - 20, iBGP - 200
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

## Design
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
- One BGP session for multiple address families
- Aggressive timers: Hold - 9, Hello - 3, reconnect - 12
- BFD
- Route maps to propogate local prefixes - ?
- Summarize routes only on Leafs
- As simple as possible
- If two Leafs are in vPC pair - they may have the same AS number
- If Leafs have the same AS number - there will be a loop - can be disabled manually
- Redistribute only networks connected to Leafs, looopbacks for instance
- On Spines we configure dynamic neighboring using peer filter, where we configure which AS we accept from leafs, and listen command to specify networks on which we listen for BGP connections. Listen command is a passive mode. Leafs cannot be configured in this mode, they should be active. Listen command specifies which networks to listen, to which peer group place these neighbores and which AS accept

## Operations
- If everything is fine, only keepalives are sent, nothing inside them
- When connection starts, routers send OPEN messages with AS number, router id and capabilities list
- Then they send UPDATE messages with next hop as themselfs. One packet can contain several UPDATE messgaes and even KEEPALIVE inside. UPDATE message contains PATH ATTRIBUTES: ORIGIN, AS_PATH, MP_REACH_NLRI
- Only the following routes are sent: network command, redistribute command via route map of local addresses, redistribute from other protocols, routes received via BGP, nothing is sent by default

## Capabilities


## ASN
- Can be 16 bit (2 bytes) and 32 bit (4 bytes)
- 0 to 65535
- Reserved: 0, 23456, 65535 - ?
- Public: 1 - 64495, 65552 - 4 199 999 999
- Private: 64512 - 65534, 4 200 000 000 - 4 294 967 294
- Notation options: ASPLAIN 0 - 4 294 967 294, ASDOT 0 - 65535.65535

## Injecting Routes/Prefixes,Summarization, Redistribution
- If we configure summarization, for example two LANs connected to Leaf, and then if we disconnect one LAN, summerized route will continue propogating and everyone will consider this LAN available. Especially summarization is unacceptable on Spines. This is relevant only with "summer only" option.  
- no auto-summary is the default
- What networks are advertised by default? - none - only received via BGP
- Network command: Look for a route in the router’s current IP routing table that **exactly** matches the parameters of the network command; if the IP route exists, put the equivalent NLRI into the local BGP table. With this logic, connected routes, static routes, or IGP routes could be taken from the IP routing table and placed into the BGP table for later advertisement. When the router removes that route from its IP routing table, BGP then removes the NLRI from the BGP table, and notifies neighbors that the route has been withdrawn. If auto-summary is enabled, then it matched all of its subnets
- route-map can be used in network command to manipulate path attributes, including next hop

## Route maps
- Route map can be added after network command and after neighbor command
- network route-map command changes attrivutes before adding prefix to BGP table, except AS path
- neighbor route-map in|out applies changes to updates, sent or received. It also acts as filter, it can drop update based on match

## Packet types
- Open - negotiation parametres: BGP version, AS number, RID, Timers...
- Notification - for errors
- Update - routing information
- Keep alive
- Route refresh - request all routes for particular AFI/SAFI

## Neighbor states


## Attributes
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
- MED - suggestion to other directly connected networks on which path should be taken if multiple options are available, and the lowest value wins. transfered from iBGP to eBGP.
- Origin code can be one of three values: IGP(0, i), EGP(1, e) or Incomplete(2, ?). IGP will be set if you originate the prefix through BGP, EGP is no longer used (it’s an ancient routing protocol), and Incomplete is set when you distribute a prefix into BGP from another routing protocol (like IS-IS or OSPF)
- Communities - optional
- Local preference - used only in iBGP, used to show the best exit from AS, the higher the better route, default - 100. Default value exists only for routes, which originate from this router and with in AS, if router is received from different AS, local preference is empty

## Path attributes
- ORIGIN
- AS_PATH
- MP_REACH_NLRI

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


## Communities
Well known communioties

## Timers
- Advertisment interval - default eBGP 30 sec, iBGP 0 sec - 0 secs for Clos - send updates immediately after receiving
- Keepalive - default 60 secs - 3 sec for CLOS - how often to send HELLOs
- Hold - default 180 sec -  9 sec for CLOS - how long to wait for dead peer
- Connect - default 30 sec - reconnect interval on Nexus - 12 sec for CLOS - interval after which a dropped BGP connection can automatically reconnect
- BFD - Tx/Rx 100 ms x 3 - for CLOS
- MicroBFD if LAG is used - for CLOS

## Community based local preference
They are used for inbound traffic engineering. Some transit providers allow their customers to influence the local preference in the transit network through the use of BGP communities.  
For example community 174:10 means local preference 10

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
-  

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

## Configuration

**Origin code IGP**
```
network
neighbor default-originate
aggregate-address only when:
as-set is not set
as-set is et and all components of summarized route use IGP (i)
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

## Configuration
General approach:
- Enable BGP process and specify AS number
- Configure what to send in IPv4 address family via network command or via redistribute
- Configure neighbors configuring their AS number, address family, filters via route maps and additonal options like timers or allow-as-in
- One BGP process serves for all VRFS and can have different neighbors for different address families
- Dynamic neighbors can be configured
One large configuration file on Nexus with comments, base on my experience
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
    address-family l2vpn evpn
        send-community both
    update-source loopback 1
 
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
