# VxLAN & EVPN

Everything I need to know about VxLAN/EVPN in an extremely structured, brief language, that I understand the most
 
## Prerequisites of new approach: VxLAN and EVPN

- DC used Layer 2 technologies such as xSTP and MC-LAG
- xSTP blocks ports
- MC-LAG may not provide enough redundancy
- Device outage is a significant event and larger modular-chassis devices use a lot of power
- Amount of VLANs limit

## VxLAN 

### Concepts 

- RFC 7348
- VXLAN (Virtual eXtensible Local Area Network) is a Layer 2 overlay technology over a Layer 3 underlay infrastructure. It provides a means to stretch the Layer 2 network by pro- viding a tunneling encapsulation using MAC addresses in UDP (MAC in UDP) over an IP underlay. It is used to carry the MAC traffic from the individual VMs in an encapsulated format over a logical “tunnel”
- UDP encapsulation, port 4789, 50 bytes overhead
- MTU for transport underlay network should be large - 1550 bytes minimum, maybe even Jumbo Frames
- Only transport requirement is unicast IP
- There is nothing interesting inside VxLAN packet: only VNI number - that's all
- VLAN numbers can be different on all switches, but VNI number should be the same 
- Default gateway can be any device in a fabric
- VxLAN does not encapsulate CDP, STP....
- VxLAN cannot do traffic engineering, that is why MPLS is better
- VxLAN L2 is the same as VPLS
- VxLAN tunnels are not statefull - no keepalives
- VxLAN producers - Huawei, Juniper, Nexus 9k and Arista
- VNID - Vxlan Network Identifier - defines broadcast segment - transfered in VxLAN header - 3 bytes
- NVE - Network Virtualization Edge - interface where VXLAN ends - only 1 NVE interface is allowed on the switch.
- VTEP - VXLAN Tunnel Endpoint - Nexus - Leaf
- EVI - EVPN Virtual Instance
- Addresses the limitation of 4094 VLANs, allows 16M networks via VNI
- All paths are used via ECMP, UDP source port entropy ensures efficient load balancing
- Semaless moving VMs across DC
- L2 implementation - our fabric is a big L2 switch - VTEP knows nothing about IP addresses, only MAC addresses and where they are located (VTEP IP address)
- L2 + L3 - in addition to L2 (big switch) we add functionality of big L3 router (MLS - multi layered switch), with one VRF inside it or several...
- Load balancing: Nexus uses hash of (src ip, dst ip, protocol, src port, dst port) for ECMP load balancing underlay traffic, in VxLAN packets all these fields are the same, except UDP source port which is based on hash of inside VxLAN packet, thanks to this load balancing works good, that is why UDP is used, not direct IP for example

### Modes of learning MACs

- Flood and learn - no control plane - VTEP sends BUM traffic everywhere it is configured and then listens for reply, based on this learns where which MAC is located. First packet (ARP) and broadcast are sent to all peers, configured for this VNI. All next packets are sent only to particular VTEP. VxLAN packets between leafs are load balanced between spines. Host A in VLAN 1 SVI 1 sends ARP request for Host B in VLAN 2 svi 1. VTEP 1 encapsulates this ARP request to VXLAN and sends it to peer VTEPs for this SVI. VTEP 2 replies, and then all other traffic goes between these 2 VTEPs
- EVPN - VTEPs exchange data about MACs and IP addresses

### BUM traffic

Can be processed in 2 ways:
- Multicast replication for BUM/Flood and learn for MAC - multicast is enabled on Underlay - BUM is not packed inside VxlAN - it is sent via Underlay - replication point is on rendezvous point - spine - it is difficult to configure multicast on Underlay - not used today. Host sends broadcast. Leaf forwards it without VXLAN as a multicast to 225.2.2.1. We configure a match between VNI and multicast address - only one multicast packet - Spines will propogate it to all subscribers - load is much less then ingress replication
- Ingress replication for BUM- packed to VxLAN - and sent to all in VNI - configured statically: for every VNI we configure VTEPs IPs which have the same VNI - or we chaeck for BUM subscribtion (Route Type 3) in EVPN table

### Host mobility

- VM moves from one VTEP to another and continue
- VTEP-2 creates route type 2 with higher Sequence Number
- All other VTEPs get a new route
- Route with higher sequence number wins
- Problems may appear if MAC is configured staticly on port

## EVPN

### Concepts

- Ethernet VPN (EVPN) is a technology for carrying layer 2 Ethernet traffic as a virtual private network using wide area network protocols. EVPN technologies include Ethernet over MPLS and Ethernet over VXLAN
- AFI 25, SAFI 70
- EVPN - is an address family used in MP BGP, MP BGP is transport for it
- RFC 7432 - EVPN over MPLS
- RFC 8365 - EVPN over VXLAN
- RFC 7623 - Provider Backbone Bridges
- Dynamic discover of new VTEPs
- Dynamic learning of MAC and IP information
- Decrease amount of BUM traffic
- EVPN table contains: IP, MAC, L3 VNI, L2 VNI, Next hop
- Providing host mobility
- Providing multi-homing for active active connections - one host to several switches without any VPC
- We establish eBGP or iBGP sessions between leafs and spines. If BGP session is used for underlay, than it will be the second session via separate Loopback interfaces. This new BGP session uses only l2vpn address family
- When everything is stable, there are only BGP keep alives, nothing more
- It is recomended to use separate Loopbacks for l2vpn BGP adjecency and nve interface, vendors recommend
- When l2vpn BGP update is sent, nve interface IP is used as nexthop
- eBGP is better because if we have superspines we will have to configure hierarchical design for RR

### Inside EVPN packet

- Type: Update message (2)
- Path attributes:
  - Origin: IGP 
  - AS_PATH
  - MP_REACH_NLRI
    - Address Family Identifier (AFI) - Layer-2 VPN - 25
    - Subsequent Address Family Identifier (SAFI) - EVPN - 70
    - Nexthop - lookback IP
    - Network Layer Reachability Information (NLRI)
      - EVPN NLRI
        - Route type: MAC advertisment route (2)
        - Route Distinguisher
        - Ethernet TAG ID - 0
        - MAC address
        - VNI - it can be MPLS label here
- Extended communities
  - Route target
  - Encapsulation - VXLAN - because it can work via MPLS as well
  - Sequence number - the more the better, used when host moves from one VTEP to another, new VTEP increases this number and sends to everyone

### EVPN route types

All routes inside a fabric are in fact host /32 routes with MAC or MAC/IP.  
VTEP gets all BGP updates and stores them in global table, but installs them to VRF only if there is required VNI.  
In the beginning just after configuration is finished only Type 3 routes are sent to all l2vpn neighbors, announcing that VTEP is ready to process BUM traffic. Type 2 routes will appear only after client hosts will start to generate traffic.
- L2/L3 operations
  - Type 2 - Host Advertisment - advertising MACs - Generated when new MAC is discovered, is sent to all VTEPs within this VNI, VTEPs import it to required MAC VRF according to RT - also advertise IP together with MAC - this is a separate update called MAC/IP it is sent when new record appears in ARP table of VRF where VLAN interface is and this record ic connected with this VLAN interface - this MAC/IP update is used for assymetric routing of VxLAN traffic. Also in case of symmetric routing there are L3 VNI (in addition to L2 VNI) and router MAC address inside MAC-IP route
  - Type 3 - Inclusive Multicast Ethernet Tag  - for BUM - Ingress Replication - VTEP with particular VNI and VLAN sends this update to inform everyone that it is ready to accept BUM traffic for this particular VNI. Attribute PMSI_TUNNEL_ATTRIBUTE is added to BGP update, it contains VNI and replication type: Ingress Replication (or Multicast). This route update is generated for every VNI configured.
- M-LAG operations
  - Type 4 - Ethernet Segment Route - one LAN connected to two VTEPs - only one of them should process BUM - this is MLAG based on EVPN, without vPC
  - Type 1 - Ethernet Auto Discovery Route
- External connections
  - Type 5 - IP prefix route advertisment - when we peer IP VRF on VTEP with external router, routes from this router will be type 5
- Multicast
  - Type 6,7,8 - PIM, IGMP Leave/Join
 
#### Route type 1

- Used for quick convergence and load balancing, when we build MLAG without vPC
- One Route Type 1 is generated for all EVIs right after we enable Ethernet Segment
- One Route Type 1 is generated for each EVI for load balancing right after we enable Ethernet Segment - it is used for load balancing - every Leaf in a Fabric gets 2 Type 2 Routes for MACs which are behind 2 Leafs in MLAG
- When link is broken between Leaf and Host, Leaf sends Route Type 1 withdrawl and all Leafs delete this Leaf as next hop for specified Ethernet Segment - and all Type 2 Routes(Maybe thousands) are automatically withdrawn - as a result quick convergence

#### Route type 2

- Everything is pretty much the same here as in Route Type 3
- No PMSI_TUNNEL_ATTRIBUTE path attribute
- Only MP_REACH_NLRI differs - route type, MAC inside

```
Path Attribute - MP_REACH_NLRI
    Flags: 0x90, Optional, Extended-Length, Non-transitive, Complete
    Type Code: MP_REACH_NLRI (14)
    Length: 44
    Address family identifier (AFI): Layer-2 VPN (25)
    Subsequent address family identifier (SAFI): EVPN (70)
    Next hop network address (4 bytes)
        Next Hop: IPv4=10.10.2.3 - loopback address, not changed while travelling via Spines
    Number of Subnetwork points of attachment (SNPA): 0
    Network layer reachability information (35 bytes)
        EVPN NLRI: MAC Advertisement Route
            Route Type: MAC Advertisement Route (2)
            Length: 33
            Route Distinguisher: 00010a0a02030064 (10.10.2.3:100)
            ESI: 00:00:00:00:00:00:00:00:00:00
            Ethernet Tag ID: 0
            MAC Address Length: 48
            MAC Address: Private_66:68:3f (00:50:79:66:68:3f)
            IP Address Length: 0
            IP Address: NOT INCLUDED
            VNI: 100
```

#### Route type 3

In general route update message looks like typical BGP update:
```
Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 99
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 76
    Path attributes
        Path Attribute - MP_REACH_NLRI - here we have a route itself with AFI/SAFI, route type, next hop
        Path Attribute - ORIGIN: IGP
        Path Attribute - AS_PATH: 64701 
        Path Attribute - EXTENDED_COMMUNITIES - here we have route target, encapsulation type: VXLAN
        Path Attribute - PMSI_TUNNEL_ATTRIBUTE - here we have tunnel type - ingress replication, VNI number
```
**MP_REACH_NLRI:**
```
Path Attribute - MP_REACH_NLRI
    Flags: 0x90, Optional, Extended-Length, Non-transitive, Complete
    Type Code: MP_REACH_NLRI (14)
    Length: 28
    Address family identifier (AFI): Layer-2 VPN (25)
    Subsequent address family identifier (SAFI): EVPN (70)
    Next hop network address (4 bytes)
    Number of Subnetwork points of attachment (SNPA): 0
    Network layer reachability information (19 bytes)
        EVPN NLRI: Inclusive Multicast Route
            Route Type: Inclusive Multicast Route (3)
            Length: 17
            Route Distinguisher: 00010a0a02030064 (10.10.2.3:100)
            Ethernet Tag ID: 0
            IP Address Length: 32
            IPv4 address: 10.10.2.3
```
**PMSI_TUNNEL_ATTRIBUTE:**
```
Path Attribute - PMSI_TUNNEL_ATTRIBUTE
    Flags: 0xc0, Optional, Transitive, Complete
    Type Code: PMSI_TUNNEL_ATTRIBUTE (22)
    Length: 9
    Flags: 0
    Tunnel Type: Ingress Replication (6)
    VNI: 100
    Tunnel ID: tunnel end point -> 10.10.2.3
        Tunnel type ingress replication IP end point: 10.10.2.3
```

#### Route type 4

- This route type is created 1 for all EVIs on a switch
- It is used to discover all VTEPs, connected to one Ethernet segment
- It is used to choose Designated Forwarder - DF
- DF is responsible for BUM
- DF is chosen per EVI
- Right after you configure Ethernet Segment on a switch - it sends Route Type 4 to a fabric
- This update is accepted only by switches which have this Ethernet Segment
- How DF is chosen: every Leaf gets Index, based on Loopback IP, Leaf with bigger IP gets index 1, and other gets index 0
- VNI number is devided on amount of Leafs in Ethernet segment and remainder of division is calculated if it is zero, then switch with index zero is main
- Loop prevention: 2 Leafs connected to one Host receive BUM traffic for Host from Fabric, and ONLY DF will forward BUM to HOST, not DF Leaf will drop it
- If non DF Leaf gets BUM traffic from HOST, it will forward BUM to local ports in the same segment, and also send BUM to the Fabric, DF will get this BUM, but will not send it to HOSTs because other Leaf allready done it


**Route Type 4 Update example**

```
Border Gateway Protocol - UPDATE Message
Marker: ffffffffffffffffffffffffffffffff
Length: 94
Type: UPDATE Message (2)
Withdrawn Routes Length: 0
Total Path Attribute Length: 71
~ Path attributes
> Path Attribute - ORIGIN: IG
› Path Attribute - AS PATH: empty
> Path Attribute - LOCAL PREF: 100
~ Path Attribute
- MP_REACH_NLRI
> Flags: 0x90, Optional, Extended-Length, Non-transitive, Complete Type Code: MP_REACH_NLRI (14)
Length: 34
Address family identifier (AFI): Layer-2 VPN (25)
Subsequent address family identifier (SAFI): EVPN (70)
› Next hop: 10.16.0.2
Number of Subnetwork points of attachment (SNPA): 0
• Network Layer Reachability Information (NLRI)
~ EVPN NLRI: Ethernet Segment Route
Route Type: Ethernet Segment Route (4)
Length: 25
Route Distinguisher: 00010a1000020001 (10.16.0.2:1)
~ ESI: 00:00:11:11:11:11:11:11:00:00
ESI Type: ESI 9 bytes value (0)
ESI Que: 00 11 11 11 11 11 11 00 00
ESI 9 bytes value: 00 11 11 11 11 11 11 00 00
IP Address Length: 32
IPv4 address: 10.16.0.2
~ Path Attribute - EXTENDED COMMUNITIES
> Flags: Oxc0, Optional, Transitive, Complete Type Code: EXTENDED_COMMUNITIES (16)
Length: 16
Carried extended communities: (2 communities)
› Encapsulation: VLAN Encapsulation [Transitive Opaque]
~ ES Import: RT: 11:11:11:11:11:11 [Transitive EVPN1
› Type: Transitive EVPN (0x06)
Subtype (EVPN) : ES Import (0x02)
ES-Import Route Target: Private 11:11:11 (11:11:11:11:11:11)
```

#### Route type 5
- The only type, which transfers prefixes with different masks and not host routes with /32 mask
- External router is peered with IP interface inside VRF on Border Leaf
- Symmetric IRB is used
- What is transfered inside Route Type 5 from Border Leaf to all VTEPs?
  - Prefix
  - RD and RT from IP VRF
  - L3 VNI
  - Router's MAC
- Possible problem: too many Type-5 routes and TCAM overload
- Possible solution: reconfigure TCAM: increase for Type 5 or Type 2. For example on Arista you may choose one of 5 profiles with different amounts of supoorted routes: for example: 288k 12 entries, 16k l3 host, 32k lpm(prefixes) entries
- Possible solution: summarize as much as possible
- When Border leaf is peered with external firewall it sends /32 routes to it from whole fabric
- Summarization: before sending to firewall all fabric /32 routes we summarize them and send for example 192.168.1.0/24

## L2

- Fabric is a big Switch
- For every VLAN we configure VNI and MAC VRF
- Default Gateway for host is outside fabric
- We configure NVE interface with all VNIs, BUM traffic configuration, and hosts learning type

### Implementation types

- VLAN based service: one VLAN - one MAC VRF (RT, RD) - one bridge table, Ethernet Tag = 0 - one VNI - forwarding based on VNI - most popular - good for multi vendor - one subnet per EVI - EVPN route type 2
- VLAN bundle service - one bridge table, MAC VRF with RT RD for all VLANs - frames are sent with 802.1Q - Ethernet Tag = 0, MACs in different VLANs should not match
- VLAN aware bundle service - not supported by all vendors - all VLANs have one VRF(RT, RD) - every VLAN has its own bridge table with VNI and Ethernet tag = VNI. We create VLAN aware bundle with RD, RT and put all VLANS into it, for example 1-1000, this is a major pro. In this mode, in Route type 2, in NLRI path attribite in BGP update there will be Ethernet TAG ID - the same as VNI.

### Operations overview - VLAN based

- Host A is online, Leaf-1 sees its MAC and forwards Route Type 2 to all other VTEPS, and now all VTEPs know that Host A is behind Leaf-1
- Host A in VLAN 1 VNI 1 sends ARP request for Host B in VLAN 1 VNI 1
- Leaf 1 sends this ARP request in VXLAN to all VTEPs from which it got Route Type 3 - Inclusive Multicast Ethernet Tag with VNI 1
- All VTEPs which got ARP, forward it to all physical ports in this NVI
- Host B replies and Leaf 2 sends reply in VXLAN to Leaf 1

### MAC VRF

- RD:MAC-PREFIX:ETI
- RD:IP-PREFIX:ETI
- MAC-PREFIX = MAC/48
- Ethernet Tag ID = 0 - in most cases - defines bridge table inside VRF - several bridge tables can be in one vrf - in most cases we add 1 vlan to one MAC VRF, this is required only when several VLANs are in 1 MAC VRF
- We add VLAN to MAC VRF instead of interface in IP VRF

### Firewall/Deafult gateway injection

- Connected to border leaf via TRUNK interface
- All required subinterfaces are configured on firewall
- On all required clients we configure firewall as a default gateway
- All traffic between VLANs goes via firewall
- Bottle neck for the entire network
- High load on border leaf
- ePBR can be also used

### Configuration overview for L2

- Pure L2 configuration for VxLAN traffic, no L3, no routing
- MAC VRF for every VLAN 
- Special loopback for Overlay is created. From this overlay address we build l2vpn adjacency with Spines and send then only l2vpn route updates   
- For overlay neighbor we configure sending all communities, do not change next hop and multihop 
- On  leafs we configure BGP as host reachability protocol and as ingress replication protocol 
- Also we configure for each VNI RD, RT in evpn section. RD can be any, it is better to use loopbackIP:VNI for it, for better understanding when we see it in routing table. RT can be any as well, but it should be correlated what we import and export on all VTEPS, so it is better to do it the same on all VTEPS for one VNI
- This type of configuration will require configuration for every VLAN, if we have 1000 VLANs
- Route Type 2 dissapears, when host does not send any traffic for some time and disspears from switch MAC table, after this withdrawl is sent

## L3

### Concepts

- IRB - Integrated Routing and Bridging - It means that 2 services are provided at the same time: Routing and switching
- To isolate from Underlay we use VRfs for VxLAN routing
- During L3 routing of VxLAN traffic MACs of source and destination are changed the same as in regular routing
- TTL is decreamented as well
- Route Leaking between different VRFs is configured very simple: we just import to our VRF routes with route target of different VRF. But it works only for routes, which we got via EVPN, if route is local(connected to this leaf) it will not be leaked. VPNv4 route leaking can be used instead in this case
- Fabric is devided on VRFs, each VRF is a tenant, several VLANs (VNIs) in each VRF, L3 VNI for each VRF, RT and RD for each VRFs, if VRFs need connection between each over - external firewall is used, or route leaking
- Hosts may even not used in Fabric, it can be used just for stretching VRFs, to work as VPN

**Distributed anycast gateway**
- One default GW on all leafs for particular VLAN - Virtual IP
- One MAC for default GW on all leafs - Virtual MAC
- On all leafs we configure manually on Interface VLAN virtual IP and virtual MAC
- In route updates type 2 which contains MAC/IP real router mac is sent, not virtual one

**ARP suppression**
- Decrease BUM traffic
- VTEP intercepts all ARP traffic, if it has Type 2 route for it, it replies - ARP spoofing
- If no route for it, then it sends BUM traffic to fabric

**Implementation types - where VXLAN routing happens:**
- Bridged overlay - routing on external device
- Centrally-Routed Bridging (Spine Routed) - not recomended
- Edge-Routed Bridging (Leaf routed) - recomended

### Bridged overlay - no L3 functionality

- Does not provide a mechanism for inter-VXLAN routing functionality within the fabric
- Default gateway is outside fabric (firewall)
- All routing and L3 termination is outside fabric
- Fabric - is a large logic L2 switch
- Pros: segmentation, simplicity
- Cons: non-optimal traffic flow, no ARP suppression
- VLAN based segmentation
- Rarely used

### Edge-Routed Bridging

- Default Gateway - VTEP
- VRF based segmentation
- Pros: optimal traffic flow, ARP suppression
- Cons: expensive equipment
- Fabric: big L3 Switch - MLS
- Intra VRF traffic may go via Firewall

#### Edge-Routed Bridging - Assymetric

- Only L2VNI is used
- Does not require any specific configuration: just add VRF and SVI interfaces, maybe if you want, add virtual MAC, that's all
- Routing on ingress VTEP: Leaf1 gets frame in VLAN/VNI 1, and puts it to MAC VRF 2 according to destination IP and this packet with new VNI goes to LEAF 2
```
Host 1 (SRC MAC: Host 1; DST MAC: VLAN 1) > Leaf 1 > MAC VRF 1 VNI/VLAN 1 > MAC VRF 2 VNI/VLAN 2 (SRC MAC: VLAN 2; DST MAC: Host 2)> VXLAN > Leaf 2 > MAC VRF 2 > Host 2
```
- On egress VTEP only switching
- Assymetric: different VNIs on different directions of one flow: From Leaf 1 to Leaf 2 traffic is VNI2, and from Leaf 2 to Leaf 1 traffic is VNI1
- All VNI-VLANs should be configured on all VTEPs - Con - poor scalability - if on one VTEP no conf of VLAN, it will be black holed
- VRF-lite: Because info about VRFs is not spreaded across fabric
- Pros: low latency - TTL-1 and routing decision happens only once on ingress VTEP , simplicity
- Changing MAC: the same as in traditional routing: SRC MAC is changed VLAN SVI MAC and DST MAC is Changed to Destination Host Mac  
- Route Type 2 is used, besides MAC it also transfers IP/MAC bindings in the same NLRI, VNI is included in both routes. MAC update is imported into MAC table and IP/MAC update is imported into ARP table of destination MAC VRF

**Configuration overview (in addition to L2):**
- We need just to configure IP interface: we create VRF and add VLAN interfaces to it and add virtual IP and virtual MAC for them
- Virtual MAC is configured one per switch
- All VTEPs must have the same virtual MAC address
- Enable ARP suppression for every vni in nve interface - maybe not needed on Nexus
- Enable anycast distributed gateway on all VLAN interfaces - maybe no needed on Nexus

#### Edge-Routed Bridging - Symmetric

- Routing happends both on ingress and egress VTEP: Leaf1 gets frame in VLAN/VNI 1, puts it to IP VRF A, IP VRF sends it to Leaf 2 with VNI of this VRF, Leaf 2 puts it into proper MAC VRF
```
Host 1 (SRC MAC: Host 1; DST MAC: VLAN 1) > Leaf 1 > MAC VRF 1 VNI/VLAN 1 > IP VRF A (SRC MAC: VLAN 1; DST MAC: VLAN 2) > VXLAN VNI 555 > Leaf 2 > IP VRF A > MAC VRF 2 (SRC MAC: VLAN 2; DST MAC: HOST 2) > Host 2
```
- Symmetric: one L3VNI for both directions of traffic flow
- Routing through IP VRF, VNI configuration should not be the same on all VTEPs, we configure on VTEP only VLANS which are connected to it, we do not have to configure VLANS and VNIs for VLANS which are only on different VTEP
- One IP VRF may include several MAC VRFs
- Routes are installed directly to routing table of VRF
- Full VRF
- Pros: scalability, integration with out networks - this is main pro, external router peers with IP VRF
- Cons: 2 TTLs
- Route Type 2 is used, besides MAC it also transfers IP/MAC bindings in the same NLRI, VNI is included in both routes. MAC update is imported into MAC table and IP/MAC update is imported into ARP table of destination MAC VRF + into routing table
- MAC-IP routing update contains two RT: for MAC VRF (first one) and IP VRF; and 2 VNIs: the first one for switching and second one for routing
- MAC-IP also contains Router MAC (as an extended community) for routing: MAC of VLAN 2 in our example, so VTEP-1 knows what change MAC to before sendong to VTEP-2

**Configuration overview (in addition to Assymetric)**
- Add route target and RD to IP VRF
- Add L3 VNI to each VRF - Create fake VLAN+assign VNI and fake SVI for it
- Add anycast gateway to each SVI
- Add L3 VNI to NVE interface

## Multihoming/LAG for hosts

### vPC

Cisco Live BRKDCN-2012 - VXLAN vPC: Design and Best Practices  

- On NVE interfaces on both leafs we configure secondary IP as a virtual VTEP ID - Anycast VTEP - this secondary IP is configured on Loopback interface, which is used on NVE - all routes about vPC hosts are announced from this Anycast VTEP - both Leafs will advertise the same routes to Spines via BGP
- Orphan interfaces hosts are not announced from Anycast VTEP
- Virtual mac is generated from vpc number, this virtual MAC is used for hosts and as Router MAC in EVPN routes
- Hosts which are connected to vPC are announced via BGP with Next hop - Anycast VTEP - shared VTEP
- At that Spine will get 2 same updates from both Leafs with the same next hop and different RD and different router mac in extended communities
- If 2 hosts are in the same subnet - no problems - DMAC is a host MAC which is behind vPC VTEP
- If 2 hosts are in different subnets, then DMAC of VxLAN packet is Router MAC of paricular VTEP in vPC
- For Underlay these 2 leafs - are 2 different boxes
- It is possible to configure peer link via Fabric - еi will save High Speed links
- If peerlink is down, Secondary node will shut down nve interface!

**VPC consistency check in VXLAN requires:**
- The same VLAN-to-VNI mapping on both VPC peers
- SVI present for VLANs mapped to VNI on both vPC peers
- The same VNI needs to use the same BUM traffic transport mechanism on both VTEPs
- When a VNI uses multicast replication, both VTEPs need to use the same multicast group for this VNI
- When PC VTEP consistency check failed: The NVE loopback interface will be admin shutdown on the VPC secondary VTEP

### MC-LAG EVPN Active/Active Multihoming

- RFC 7432
- N switches can be used, it is better then vPC with only 2
- No need in peer link
- Sophisticated convergence via Type 1/2 routes, in vPC it is easy
- Load balancing (ECMP) is done in Overlay, for vPC it is done in Underlay (VTEPs are seen as one logical VTEP by other VTEPs)
- Many problems if uplink from Leaf to SPine is down - because there is no Peer Link
- It allows to configure LAG to 2 leafs without vPC
- Ethernet Segment ID - ESI - describes ports on Leafs which are connected to the same Host - 10 bytes - 1 byte for type - 9 bytes for value - 5 types in total - type does not matter
- ESI is transfered in Route Type 2 - Path Attribute NLRI - it is always present int type 2 routes - in single-home case it is 00:00:00:00:00:00:00:00:00:00
- If there is ESI value in an update - it means that this host is behind 2 switches
- On Leafs we configure 
    - Port Channel interface with trunk and allowed VLANs
    - For Port Channel interface we configure ESI: 0000:1111:1111:1111:0000
    - For Port Channel interface we configure route target import 11:11:11:11:11:11
    - For Port Channel we configure LACP system ID 1111.1111.1111 - the same on both leafs so host can see them as one switch
    - Then we add physical interface to Port Channel with LACP active mode
- Problems which EVPN will face with building MLAG:
    - Load balancing
    - Loops for broadcast traffic - it is solved with route types 4
    - Convergence - changing routes if something fails

## Distributed fabric

- Geo distributed or in different campuses or rooms
- Merge 2 Data Centres
- It allows to stretch L2 between cities!
- Three options available:
  - Multi-fabric - not popular, L2 is required, between fabrics no VxLAN, only L2, many VLANs, this L2 is usually implemented via difficult L3 (VPLS). Fabrics are absolutely disconnected, they dont know anything about each over.
  - Multi-pod - just another hierarchy level, one big fabric, shared underlay and overlay, hierarchy is only in underlay. VxLAN encapsulation between sites. This is approach to scale fabric, not to connect 2 different ones. Fate sharing.
  - Multi-site - The most popular. VxLAN encapsulation between sites

### Multi-pod physical connection types

Via transit Leaf nodes

<img width="1421" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/12330cae-4aea-462d-ae06-81b7b690f371">

Via Super Spines

<img width="563" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/04907972-06c8-4309-bc13-e4e7937c0f4c">

Via Transit Leafs 2

<img width="703" alt="image" src="https://github.com/philipp-ov/foundation/assets/116812447/99938ada-d979-4ab0-a609-17e6b3f27f25">

### Multi-pod Underlay routing considerations

- All Pods are in 1 routing domain - fate sharing - any failure will affect the entire network
- Different routing protocols between pods: OSPF - BGP - OSPF: double redistribution, issue with loops possible
- Divide single routing domain: Areas in OSPF
- MTU between PODs should be increased on 54 bytes

## Multi-site

<img width="738" alt="image" src="https://github.com/philipp-ov/Foundation/assets/116812447/01bfb083-2f65-4c8c-a20e-bb5077a9f485">

- Several fabrics are connected via separate DCI fabric
- Under, Overlay are isolated, u can still span L2
- BUM traffic runs between sites
- Border Gateways - BGW - Key Functional Components - connected to Spines above them - 2 gateways per fabric
- BGW is VTEP for both fabrics: local and connecting fabrics
- VTEPs in different fabrics do not communicate directly, all communications via BGW
- 2 BGW always used for redundancy: vPC or Anycast - 4 devices can be used
- BGW fully decapsulates VxLAN and then encapsulates it again - high load
- 2 BGW have multisite VIP - virtual IP - Loopback interface, besides it each BGW has its own IP - loopback as well
- Multisite VIP is seen as NVE peer on local VTEPs + remote BGW
- We can use any Underlay between BGWs of different fabrics
- Site internal fabric - local fabric itself
- Site external DCI - fabric between sites - L3 connectivity between BGWs + increased MTU
- Multi-site also supports integration an migration of legacy networks: you connect to BGW usual network and it sees VxLAN hosts and VxLAN hosts see usual hosts
- 10 sites max, 4 BGWs per site max, 256 VTEP per site max: BGWs of all sites should see each other + oversized (MTU) packets should travel between them
- For BUM traffic between sites Ingress Replication is used
- Sites with different BUM traffic replication(Ingress and Multicast) can be combined
- Between sites only eBGP, no iBGP
- BGWs of one site should have eBGP MP EVPN peering with all BGWs of another site: full mesh or route server
- One NVE interface is used on BGW: for internal fabric and DCI fabric
- When we configure peering with external fabric on BGW we mark this peering as external connection

### Multi site configuration

NX-OS 9.2.4

```
#Enable BGW on a box
evpn multisite border-gateway 1
#1 - Site number

#Confugure muulti site VIP for NVE interface
interface nve1
  multisite border-gateway interface loopback100

#Configure interface, which is connected to Inside
interface Ethernet1/1
  mtu 9216
  evpn multisite fabric-tracking

#Configure interface, which is connected to Outside for connection with other site
interface Ethernet1/2
  mtu 9216
  evpn multisite dci-tracking

```

## Configuration

### Static peers on Nexus - flood and learn, no EVPN

Configuration overview

- We create special Loopback for overlay, announce it to BGP Underlay    
- For every VLAN where clients are connected we configure VNI  
- Next we configure nve interface, where we configure peers for every VNI
- Only L2 for VxLAN traffic, no L3 and no BGP

```
feature vn-segment-vlan-based

#Enables VTEP (only required on Leaf or Border)
feature nv overlay

vlan 100
  name PROD
  vn-segment 100

#Interface for clients  
interface Ethernet1/3
  switchport access vlan 100

interface nve1
  no shutdown
  source-interface loopback1
  member vni 100
  # Method of processing BUM traffic for this VLAN and how to learn where rewuired MACs are.
    ingress-replication protocol static
      peer-ip 10.10.2.4
      peer-ip 10.10.2.5
  member vni 200
    ingress-replication protocol static
      peer-ip 10.10.2.4
      peer-ip 10.10.2.5
```

### L2/L3 BGP EVPN on Nexus - VLAN based service - Symmetric L3

**Leaf**

```
#Enables EVPN Control-Plane in BGP
nv overlay evpn

feature bgp

feature vn-segment-vlan-based

#For enabling ARP suppression
hardware access-list tcam region racl 512
hardware access-list tcam region arp-ether 256 double-wide

#Enables VTEP (only required on Leaf or Border)
feature nv overlay

#Enable SVI interfaces
feature interface-vlan

#Enable virtual MAC - the same for all interfaces and VTEPs
fabric forwarding anycast-gateway-mac 0001.0002.0003

#Assign VNIs to each VLAN
vlan 100
  vn-segment 100
vlan 200
  vn-segment 200

#Fake VLAN for L3 SVI
vlan 300
vn-segment 300

#Create VRF for L3, to isolate VxLAN traffic from Underlay
##For L3 symmetric add RD, RT and L3 VNI
vrf context OTUS
 vni 300
 rd 10.10.2.3:300
 address-family ipv4 unicast
  route-target both 300:300
  route-target both 300:300 evpn

  
#Create SVI interfaces for L3 and make them anycast gateway and insert them into required VRF
interface Vlan100
  no shutdown
  vrf member OTUS
  ip address 192.168.1.1/24
  fabric forwarding mode anycast-gateway - without this command VTEP will not send MAC-IP type routes, only MACs

interface Vlan200
  no shutdown
  vrf member OTUS
  ip address 192.168.2.1/24
  fabric forwarding mode anycast-gateway
  
#Fake SVI for L3 VNI
interface vlan 300
no shutdown
vrf member OTUS
ip forward

#Configure BGP EVPN in addition to underlay BGP
router bgp 64701
  address-family l2vpn evpn
    retain route-target all
  neighbor 10.10.2.1
    remote-as 64600
    update-source loopback1 - it is best practive to use different loopbacks for EVPN and nve interfaces
    ebgp-multihop 2 - required because we establish peeering from loopback
    address-family l2vpn evpn
      send-community
      send-community extended

# Enable MAC VRF for every VNI and for Type 2-3 routes
evpn
  vni 100 l2
    rd 10.10.2.4:100 - it is better to use EVPN loopback here to better understand from where route arrived
# Route targets for import and export are the same here
    route-target import 100:100
    route-target export 100:100
    
interface nve1
  no shutdown
  member vni 300 associate-vrf - add all needed L3 VNIs
  host-reachability protocol bgp - we find out MACs via BGP
  source-interface loopback1
  member vni 100
    ingress-replication protocol bgp - we process BUM traffic via BGP - Route Types 3
    suppress-arp
    
 ```

**Spine**  
Here we configure only BGP EVPN, no VTEP, VNI, NVE... One configuration is the same for L2 and L3. It just transits routes and traffic.

```
#Enable all required features
nv overlay evpn
feature bgp
feature vn-segment-vlan-based
feature nv overlay

#Route map - not to change next ho address for routes which are sent to leafs
route-map SET_NEXT_HOP_UNCHANGED permit 10
  set ip next-hop unchanged
  
router bgp 64600
address-family l2vpn evpn
# Required for BGP EVPN. Allows the spine to retain and advertise all EVPN routes when there are no local VNI configured with matching import route targets
    retain route-target all
    
neighbor 10.10.2.3
    remote-as 64701
    update-source loopback1
    ebgp-multihop 2
    address-family l2vpn evpn
      send-community
      send-community extended
      route-map SET_NEXT_HOP_UNCHANGED out
  neighbor 10.10.2.4
    remote-as 64702
    update-source loopback1
    ebgp-multihop 2
    address-family l2vpn evpn
      send-community
      send-community extended
      route-map SET_NEXT_HOP_UNCHANGED out
```

**Advertise Primary IP Address in case of vPC**

```
router bgp 65536
address-family 12vp evpn advertise-pip
Interface nve 1
advertise virtual-rmac
```

**vPC configuration on Leafs**

```
Interface 1
switchport
switchport access vlan 893 
channel-group 101 mode active
no shutdown

interface port-channe1101
switchport
switchport access vlan 893
spanning-tree port type edge
vpc 101

feature vpc
vpc domain 8 - influence virtual MAC
 peer-switch
 role priority 10 - the less the better
 peer-keepalive destination 172.16.5.17 source 172.16.5.13
 delay restore 10
 peer-gateway
 layer3 peer-router - recomended config for VxLAN
 ip arp synchronize
 
interface port-channel1
 vpc peer-link
 
Secondary IP on loopback
```

## Verification

**Show all NVE neighboors**  
not very reliable data, because connections are connectionless :)  
Peer is up just because it exists in routing table. It even may not accept VxLAN packets.

```
show nve peers  

Interface Peer-IP                                 State LearnType Uptime   Router-Mac
--------- --------------------------------------  ----- --------- -------- -----------------
nve1      10.10.2.4                               Up    DP        01:08:14 n/a
nve1      10.10.2.5                               Down  DP        0.000000 n/a
```

**Show info about nve interface**

```
leaf-1(config)# show int nve1  

nve1 is up
admin state is up,  Hardware: NVE
  MTU 9216 bytes
  Encapsulation VXLAN
  Auto-mdix is turned off
  RX
    ucast: 71 pkts, 6890 bytes - mcast: 15 pkts, 960 bytes
  TX
    ucast: 92 pkts, 12834 bytes - mcast: 0 pkts, 0 bytes
 ```
 
**Show l2vpn routing table**  
Shows type 3 routes, type 2 routes (both MAC and MAC-IP), shows route type, next hop, route distinguisher  
Here we can see all MAC routes and 1 Type 3 route which were exported from partucular MAC vrf with particular RD

```
leaf-2(config-if-nve)# show bgp l2vpn evpn  

BGP routing table information for VRF default, address family L2VPN EVPN
BGP table version is 58, Local Router ID is 10.10.1.4
Status: s-suppressed, x-deleted, S-stale, d-dampened, h-history, *-valid, >-best
Path type: i-internal, e-external, c-confed, l-local, a-aggregate, r-redist, I-injected
Origin codes: i - IGP, e - EGP, ? - incomplete, | - multipath, & - backup, 2 - best2

   Network            Next Hop            Metric     LocPrf     Weight Path
Route Distinguisher: 100:100    (L2VNI 100)
*>l[2]:[0]:[0]:[48]:[0050.7966.682d]:[0]:[0.0.0.0]/216
                      10.10.2.4                         100      32768 i
*>e[2]:[0]:[0]:[48]:[0050.7966.683f]:[0]:[0.0.0.0]/216
                      10.10.2.3                                      0 64600 64701 i
*>e[3]:[0]:[32]:[10.10.2.3]/88
                      10.10.2.3                                      0 64600 64701 i
*>l[3]:[0]:[32]:[10.10.2.4]/88
                      10.10.2.4                         100      32768 i
 ```
 
 **Show EVPN neighboors**

 ```
 spine-1# show bgp l2vpn evpn summary
BGP summary information for VRF default, address family L2VPN EVPN
BGP router identifier 10.10.1.1, local AS number 64600
BGP table version is 18, L2VPN EVPN config peers 2, capable peers 2
2 network entries and 2 paths using 440 bytes of memory
BGP attribute entries [2/328], BGP AS path entries [2/12]
BGP community entries [0/0], BGP clusterlist entries [0/0]

Neighbor        V    AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
10.10.2.3       4 64701      81      89       18    0    0 00:39:28 1
10.10.2.4       4 64702      82      85       18    0    0 01:16:27 1
 ```
 
 **Show details about particular route type**

 ```
 leaf-2(config-evpn-evi)# show bgp l2vpn evpn route-type 2
 ```
We can also filter based on different parametres, for example RD  

**Show MAC addresses: both local and from remote VTEP**

```
leaf-1(config-evpn-evi)# show mac address-table
Legend:
        * - primary entry, G - Gateway MAC, (R) - Routed MAC, O - Overlay MAC
        age - seconds since last seen,+ - primary entry using vPC Peer-Link,
        (T) - True, (F) - False, C - ControlPlane MAC, ~ - vsan
   VLAN     MAC Address      Type      age     Secure NTFY Ports
---------+-----------------+--------+---------+------+----+------------------
C  100     0050.7966.682d   dynamic  0         F      F    nve1(10.10.2.4)
*  100     0050.7966.683f   dynamic  0         F      F    Eth1/3
G    -     5000.3e00.1b08   static   -         F      F    sup-eth1(R)
```

**Show all routes for particular IP**

```
show bgp l2vpn evpn 192.168.2.3
```

**Show all MAC-IP records**

```
show l2route evpn mac-ip evi 40
```

**Show info about arp-suppression**

```
show ip arp suppression-cache detail
```

**Show all next hops for all MACs**

```
switch# show l2route mac all

Flags -(Rmac):Router MAC (Stt):Static (L):Local (R):Remote (V):vPC link
(Dup):Duplicate (Spl):Split (Rcv):Recv (AD):Auto-Delete (D):Del Pending
(S):Stale (C):Clear, (Ps):Peer Sync (O):Re-Originated (Nho):NH-Override
(Pf):Permanently-Frozen, (Orp): Orphan

Topology    Mac Address    Prod   Flags         Seq No     Next-Hops
----------- -------------- ------ ------------- ---------- ---------------------------------------
100         5009.0000.1b08 BGP    SplRcv        0          10.10.2.6 (Label: 100)
100         aabb.cc00.6000 Local  L,            0          Eth1/2
200         aabb.cc00.4000 BGP    SplRcv        0          10.10.2.6 (Label: 200)
200         aabb.cc00.7000 Local  L,            0          Eth1/3
300         5002.0000.1b08 VXLAN  Rmac          0          10.10.2.6
```

**Show ip routes with installed VxLAn routes in symmetric mode**

```
leaf-1(config-if)# show ip route vrf OTUS
IP Route Table for VRF "OTUS"
'*' denotes best ucast next-hop
'**' denotes best mcast next-hop
'[x/y]' denotes [preference/metric]
'%<string>' in via output denotes VRF <string>

192.168.1.0/24, ubest/mbest: 1/0, attached
    *via 192.168.1.1, Vlan100, [0/0], 4d01h, direct
192.168.1.1/32, ubest/mbest: 1/0, attached
    *via 192.168.1.1, Vlan100, [0/0], 4d01h, local
192.168.1.2/32, ubest/mbest: 1/0, attached
    *via 192.168.1.2, Vlan100, [190/0], 00:41:38, hmm
192.168.1.3/32, ubest/mbest: 1/0
    *via 10.10.2.4%default, [20/0], 00:41:38, bgp-64701, external, tag 64600, segid: 300 tunnelid: 0xa0a0204 encap: VXLAN

192.168.2.0/24, ubest/mbest: 1/0, attached
    *via 192.168.2.1, Vlan200, [0/0], 3d01h, direct
192.168.2.1/32, ubest/mbest: 1/0, attached
    *via 192.168.2.1, Vlan200, [0/0], 3d01h, local
192.168.2.2/32, ubest/mbest: 1/0, attached
    *via 192.168.2.2, Vlan200, [190/0], 00:41:31, hmm
192.168.2.3/32, ubest/mbest: 1/0
    *via 10.10.2.4%default, [20/0], 00:41:31, bgp-64701, external, tag 64600, segid: 300 tunnelid: 0xa0a0204 encap: VXLAN
```

## Additional materials

### Cisco Live

- BRKDCN-2450 - VXLAN EVPN Day-2 operation  
- BRKDCT-3378 - Building Data Center Networks with VXLAN BGP-EVPN - done
- BRKDCT-2404 - VXLAN Deployment Models - A practical perspective  
- BRKDCN-2304 - L4-L7 Service Integration in Multi-Tenant VXLAN EVPN Data Center Fabrics
- LTRDCN-2223 - Implementing VXLAN In a Data Center
- DGTL-BRKDCN-1645 - Introduction to VXLAN - The future path of your datacenter  
- BRKDCN-2012 - VXLAN vPC: Design and Best Practices
  
### Juniper books

- Data Center EVPN-VXLAN Fabric Architecture Guide
- DAY ONE: DAtA CENtEr FUNDAMENtALS
- DAY ONE: ROUTING IN FAT TREES (RIFT)
- THIS WEEK: DATA CENTER DEPLOYMENT WITH EVPN/VXLAN
- IP Fabric EVPN-VXLAN Reference Architecture
- Juniper Networks EVPN Implementation for Next-Generation Data Center Architectures
- EVPN-VXLAN User Guide
 
### Cisco books

- Building Data Centers with VXLAN BGP EVPN - A Cisco NX-OS Perspective
- Cisco Nexus 9000 Series NX-OS VXLAN Configuration Guide
