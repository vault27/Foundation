# VxLAN & EVPN
Everything I need to know about VxLAN/EVPN in an extremely structured, brief language, that I understand the most

## Cisco Live useful presentations regarding this topic
- BRKDCN-2450 - VXLAN EVPN Day-2 operation  
- BRKDCT-3378 - Building Data Center Networks with VXLAN BGP-EVPN - done
- BRKDCT-2404 - VXLAN Deployment Models - A practical perspective  
- BRKDCN-2304 - L4-L7 Service Integration in Multi-Tenant VXLAN EVPN Data Center Fabrics
- LTRDCN-2223 - Implementing VXLAN In a Data Center
- DGTL-BRKDCN-1645 - Introduction to VXLAN - The future path of your datacenter  
  
Juniper:
- Data Center EVPN-VXLAN Fabric Architecture Guide
- DAY ONE: DAtA CENtEr FUNDAMENtALS
- DAY ONE: ROUTING IN FAT TREES (RIFT)
- THIS WEEK: DATA CENTER DEPLOYMENT WITH EVPN/VXLAN
 
## Concepts   
- RFC 7348
- VXLAN (Virtual eXtensible Local Area Network) is a Layer 2 overlay technology over a Layer 3 underlay infrastructure. It provides a means to stretch the Layer 2 network by pro- viding a tunneling encapsulation using MAC addresses in UDP (MAC in UDP) over an IP underlay. It is used to carry the MAC traffic from the individual VMs in an encapsulated for- mat over a logical “tunnel”
- UDP encapsulation, port 4789, 50 bytes overhead
- MTU should be large
- Only transport requirement is unicast IP
- VLAN numbers can be different on all switches, but VNI number should be the same 
- Default gateway can be any device in a fabric
- VxLAN does not encapsulate CDP, STP....

## Components
- VNID - Vxlan Network Identifier - defines broadcast segment - transfered in VxLAN header - 3 bytes
- NVE - Network Virtualization Edge - interface where VXLAN ends - only 1 NVE interface is allowed on the switch.
- VTEP - VXLAN Tunnel Endpoint - Nexus - Leaf

## Pros
- Addresses the limitation of 4094 VLANs, allows 16M networks via VNI
- All paths are used via ECMP, UDP source port entropy ensures efficient load balancing
- Semaless moving VMs across DC

## How they handle BUM traffic and MAC learning
Can be processed in 2 ways:
- Multicast replication for BUM/Flood and learn for MAC - multicast is enabled on Underlay - BUM is not packed inside VxlAN - it is sent via Underlay - replication point is on rendezvous point - spine - it is difficult to configure multicast on Underlay - not used today
- Ingress replication for BUM/Flood and learn for MAC - packed to VxLAN - and sent to all in VNI - configured statically: for every VNI we configure VTEPs IPs which have the same VNI
- OVSDB for MAC learning and BUM
- EVPN for both BUM and MAC learning

## Operations
### Without BGP, ingress replication of BUM traffic
Host A in VLAN 1 SVI 1 sends ARP request for Host B in VLAN 2 svi 1. VTEP 1 encapsulates this ARP request to VXLAN and sends it to peer VTEPs for this SVI. VTEP 2 replies, and then all other traffic goes between these 2 VTEPs

### With BGP, ingress replication traffic
- Host A is online, Leaf-1 sees its MAC and forwards Route Type 2 to all other VTEPS, and now all VTEPs know that Host A is behind Leaf-1
- Host A in VLAN 1 SVI 1 sends ARP request for Host B in VLAN 2 svi 1
- Leaf 1 sends this ARP request in VXLAN to all VTEPs from which it got Route Type 3 - Inclusive Multicast Ethernet Tag with SNI 1
- All VTEPs which got ARP, forward it to all physical ports in this SVI
- Host B replies and Leaf 2 sends reply in VXLAN to Leaf 1

### BUM traffic via Multicast
- Host sends broadcast
- Leaf forwards it without VXLAN as a multicast to 225.2.2.1
- We configure a match between VNI and multicast address - only one multicast packet - Spines will propogate it to all subscribers - load is much less then ingress replication

## Host mobility
- VM moves from one VTEP to another and continue
- VTEP-2 creates route type 2 with higher Sequence Number
- All other VTEPs get a new route
- Route with higher sequence number wins
- Problems may appear if MAC is configured staticly on port

## Service models
- VLAN based service: one VLAN - one MAC VRF (RT, RD) - one bridge table, Ethernet Tag = 0 - one VNI - forwarding based on VNI - most popular - good for multi vendor
- VLAN bundle service - one bridge table, MAC VRF with RT RD for all VLANs - frames are sent with 802.1Q - Ethernet Tag = 0, MACs in different VLANs should not match
- VLAN aware bundle service - not supported by all vendors - all VLANs have one VRF(RT, RD) - every VLAN has its own bridge table with VNI and Ethernet tag = VNI

## Load balancing
The Layer 3 routes that form VXLAN tunnels use per-packet load balancing by default, which means that load balancing is implemented if there are ECMP paths to the remote VTEP. This is different from normal routing behavior in which per-packet load balancing is not used by default. (Normal routing uses per-prefix load balancing by default.)  
  
The source port field in the UDP header is used to enable ECMP load balancing of the VXLAN traffic in the Layer 3 network. This field is set to a hash of the inner packet fields, which results in a variable that ECMP can use to distinguish between tunnels (flows).  
  
None of the other fields that flow-based ECMP normally uses are suitable for use with VXLANs. All tunnels between the same two VTEPs have the same outer source and destination IP addresses, and the UDP destination port is set to port 4789 by definition. Therefore, none of these fields provide a sufficient way for ECMP to differentiate flows.    
That is why UDP is used, not IP for example.  
All VxLAN packets from one Leaf to another have different UDP source ports for load balancing purposes.

## Static configuration - Flood and learn
It is called flood and learn. No control plane is used. First packet (ARP) and broadcast are sent to all peers, configured for this VNI. All next packets are sent only to particular VTEP. VxLAN packets between leafs are load balanced between spines

## Firewall injection
- Connected to border leaf via TRUNK interface
- All required subinterfaces are configured on firewall
- On all required clients we configure firewall as a default gateway
- All traffic between VLANs goes via firewall
- Bottle neck for the entire network
- High load on border leaf
- ePBR can be also used

## MAC VRF
- RD:MAC-PREFIX:ETI
- RD:IP-PREFIX:ETI
- MAC-PREFIX = MAC/48
- Ethernet Tag ID = 0 - in most cases - defines bridge table inside VRF - several bridge tables can be in one vrf - in most cases we add 1 vlan to one MAC VRF, this is required only when several VLANs are in 1 MAC VRF
- We add VLAN to MAC VRF instead of interface in IP VRF

## Configuration

### Static peers on Nexus
Configuration overview  
We create special Loopback for overlay, announce it to BGP Underlay    
For every VLAN where clients are connected we configure VNI  
Next we configure nve interface, where we configure peers for every VNI

```
#
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

### BGP EVPN on Nexus - VLAN based service
Configuration overview  
- MAC VRF for every VLAN, 
- Special loopback for Overlay is created. From this overlay address we build l2vpn adjacency with Spines and send then only l2vpn route updates   
- For overlay neighbor we configure sending all communities, do not change next hop and multihop 
- On  leafs we configure BGP as host reachability protocol and as ingress replication protocol 
- Also we configure for each VNI RD, RT in evpn section. RD can be any, it is better to use loopbackIP:VNI for it, for better understanding when we see it in routing table. RT can be any as well, but it should be correlated what we import and export on all VTEPS, so it is better to do it the same on all VTEPS for one VNI
- This type of configuration will require configuration for every VLAN, if we have 1000 VLANs
- Route Type 2 dissapears, when host does not send any traffic for some time and disspears from switch MAC table, after this withdrawl is sent

**Leaf**
```
#Enables EVPN Control-Plane in BGP
nv overlay evpn

feature bgp

feature vn-segment-vlan-based

#Enables VTEP (only required on Leaf or Border)
feature nv overlay

router bgp 64701
  address-family l2vpn evpn
    retain route-target all
  neighbor 10.10.2.1
    remote-as 64600
    update-source loopback1
    ebgp-multihop 2
    address-family l2vpn evpn
      send-community
      send-community extended

# Enable MAC VRF and Type 2 routes
evpn
  vni 100 l2
    rd 10.10.2.4:100
# Route targets for import and export are the same here
    route-target import 100:100
    route-target export 100:100
    
interface nve1
  no shutdown
  host-reachability protocol bgp - we find out MACs via BGP
  source-interface loopback1
  member vni 100
    ingress-replication protocol bgp - we process BUM traffic via BGP - Route Types 3
 ```

**Spine**  
Here we configure only BGP EVPN, no VTEP, VNI, NVE...
```
nv overlay evpn
feature bgp
feature vn-segment-vlan-based
feature nv overlay

route-map SET_NEXT_HOP_UNCHANGED permit 10
  set ip next-hop unchanged
  
router bgp 64600
address-family l2vpn evpn
# Required for eBGP. Allows the spine to retain and advertise all EVPN routes when there are no local VNI configured with matching import route targets
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

## Verification
Show all NVE neighboors, not very reliable data, because connections are connectionless :)  
Peer is up just because it exists in routing table. It even mau not accept VxLAN packets.

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
With 2 Route Type 2 routes (for host traffic) and 2 Route Type 3 routes (for BUM traffic)

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

## EVPN
- Ethernet VPN (EVPN) is a technology for carrying layer 2 Ethernet traffic as a virtual private network using wide area network protocols. EVPN technologies include Ethernet over MPLS and Ethernet over VXLAN
- AFI 25, SAFI 70
- EVPN - is an address family used in MP BGP, MP BGP is transport for it
- RFC 7432 - EVPN over MPLS
- RFC 8365 - EVPN over VXLAN
- RFC 7623 - Provider Backbone Bridges
- Dynamic discover of new VTEPs
- Dynamic learning of MAC and IP information
- Decrease amount of BUM traffic
- Providing host mobility
- Providing multi-homing for active active connections - one host to several switches without any VPC
- We establish eBGP or iBGP sessions between leafs and spines. If BGP session is used for underlay, than it will be the second session via separate Loopback interfaces. This new BGP session uses only l2vpn address family
- eBGP is better because if we have superspines we will have to configure hierarchical design for RR

## Inside EVPN packet
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

## EVPN route types
VTEP gets all BGP updates and stores them in global table, but installs them to VRF only if there is required VNI.  
In the beginning just after configuration is finished only Type routes are sent to all l2vpn neighbors, announcing that VTEP is ready to process BUM traffic. Type 2 routes will appear only after client hosts will start to generate traffic.
- L2 operations
  - Type 2 - Host Advertisment - advertising MACs - Generated when new MAC is discovered, is sento all VTEPs withis this VNI, VTEPs import it to required MAC VRF according to RT
  - Type 3 - Inclusive Multicast Ethernet Tag  - for BUM - Ingress Replication - VTEP with particular VNI and VLAN sends this update to inform everyone that it is ready to accept BUM traffic for this particular VNI. Attribute PMSI_TUNNEL_ATTRIBUTE is added to BGP update, it contains VNI and replication type: Ingress Replication (or Multicast). This route update is generated for every VNI configured.
- L3 operations
  - Type 4 - Ethernet Segment Route - one LAN connected to two VTEPs - only one of them should process BUM
  - Type 1 - Ethernet Auto Discovery Route
- External connections
  - Type 5 - IP prefix route advertisment
- Multicast
  - Type 6,7,8 - PIM, IGMP Leave/Join

### Route type 3
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

MP_REACH_NLRI:

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
PMSI_TUNNEL_ATTRIBUTE:
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
### Route type 2
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
