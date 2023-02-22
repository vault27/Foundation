# Data Centers
All I need to know about data centres in one place. Extremly brief and systematized  
Data Centers networks evolution in one string:
```
Three tier model > LAG > Fabric Experiments > IP Fabric/CLOS/Spine-Leaf > VxLAN + EVPN
```
## Data Center network evolution
- Three tier model - only in big companies, collapsed core - mostly, we also can connect 2 collapsed cores , if there are many collapsed cores then we should switch to 3 tier. STP + HSRP/VRRP
- LACP + VSS stack, VSS is unstable, many problems - mostly in campuses, Cisco 6500
- After 2005 - Nexus: VDC( Virtual Device Context - several virtual switches on one physical), MCLAG (vPC in Cisco terms), FEX - fabric extender - many small switches are connected to a big main one and they send all traffic to it, they have no brains or control plane
- MLAG in Core - may be not very good to much control plane
- Trill, FabricPath, 
- VxLAN flood to everyone
- VXLAN + EVPN

## Era 0 - legacy - non virtualized
- Difficult to configure VLANs on all devices
- VLAN-ID field is 12 bits yielding a maximum of 4094 VLANs
- MAC scalability is affected due to limits on the number of MAC addresses that can be learned per device. Unpredictable amounts of BUM traffic when the MAC scale limit is surpassed, further impacts resiliency
- Due to STP, many unused links, no load balancing
- It is difficult connect two DC and stretch Layer 2 detween them
- No Host mobility
- No Microsegmentation
- Bad for east-west traffic
- It is difficult to repair devices higher than access layer

Connections:
- All end devices are connected to top of rack switch (ToR)
- Tor switches are connected to end of row switches (EoR) or to other uplink switches
- Also all network switches maybe in one rack
- The next is aggregation switches, which are L3 border
- Aggregation switches > Core routers > edge routers

## Era 1 - Fabrics
- The term “fabric” describes how switch, server, and storage nodes connect to all other nodes in a mesh configuration, evoking the image of tightly woven fabric. These links provide multiple redundant communications paths and deliver higher total throughput than traditional networks
- There are both proprietary architectures and open, standards-based fabrics, such as EVPN-VXLAN
- It is a network architechture, it is used instead of traditional multitier architectures
- It effectively flattens the network architecture, thereby reducing the distance between endpoints within the data center
- Overlay rides on top of the fabric
- The fabric itself, when paired with an overlay, is called the underlay

### Fabric types
- Ethernet fabric. Examples: QFabric, Virtual Chassis Fabric (VCF), and Junos Fusion. No STP. Multipath. Load balancing. Not OPen Standard. Not scalable.
- MPLS fabric. MPLS as a transport for Underlay. FRR(fast rerouting). Traffic engineering. MPLS signaling protocols like LDP, RSVP, or BGP-LU can be used to provide MPLS underlay. Devices should support MPLS.
- IP fabric. Underlay IP transport. Open standard, flat forwarding, horizontally scalable, and non-blocking spine/leaf architecture

Fabric path - Cisco's version of TRILL - eliminates STP

## Era 2 - IP fabric - Clos - Underlay - Spine/Leaf
- Equidistant endpoints
- Non-blocking core
- Low latency and high bandwidth for both East-West and North-South traffic
- Multipath - load balancing - all links are used
- No STP
- Horizontal scalable: you can add spines and leafs without redesigns
- No central mgmt
- Easy to add ports: just add a Leaf
- Easy to repair: replace one Spine

### Alternatives to Clos network
- JellyFish
- Torus
- Dring
- DragonFly
- HyperCube
- HyperX

## Era 3 - VxLAN - EVPN
- Multi tenancy - several customers use one something(Data center, firewall, software) and they are called tenants.  
- In DC tenants share Compute, Storage and Network. All these are orchestarted by service orchestration.  
- Segmentation is done via VRF, VLAN, VNI...  
- Microsegmentation: Private VLAN, ACI
- People switched from legacy tiered architechture to Clos Fabrics

## Methods to stretch L2
- Extend VLANs - Trunk
- VPLS
- VxLAN

## Data Center Fabric / Underlay 
- Overlay rides on top of the fabric
- The fabric itself, when paired with an overlay, is called the underlay
- Leaf: Rack switch (for example, Top of Rack or TOR) to which physical or virtual endpoints can connect to (for example, compute, storage or networking resources)
- Spine: Connect rows of racks providing reachability between leaf switches
- 3 stage Clos: (1) Leaf > (2) Spine > (3) Leaf
- 5 stage Clos: (1) Leaf > (2) Spine > (3) Super Spine > (4) Spine > (5) Leaf
- Underlay may be based on IP or MPLS

## Underlay best practices
- Do not use LAG between leaf and Spine. If one LAG link fails, it will reduce IGP cost and disable the whole LAG. Use Spines and Super Spines instead
- Maximum simple config for Spine, do not connect external devices to it, use Border Leafs for it

## Overlay
- General structure: Transport headers (Underlay) | Tunnel Encapsulation (Overlay) | Tenant Data
- The overlay network virtualizes the underlying physical infrastructure by creating logical networks over the physical underlay network
- It is a logical/virtual tunnel
- It can be based on Service Label (MPLS) or VNI (VxLAN)
- It provies network virtualization, segmentation, stretched Ethernet segments, workload mobility, and other services
- Network based: high requirements for MAC table on ToR switches
- Host based: high load on host, open source, host has to support technology
- Overlay control planes: EVPN, OVSDB

### MPLS types of Overlay
- MPLSoMPLS: This data plane encapsulation employs an MPLS aware underlay. The label stack is comprosed of the inner service MPLS label and outer transport MPLS label
- MPLSoGRE: Useful when the transit devices are not MPLS aware. Inner service MPLS label is encapsulated in GRE and transported over a physical IP infrastructure. Load balancing capabilities are limited since network device implementations need to understand GRE key field being used in a load-balancing context
- MPLSoUDP: Similar to MPLSoGRE, this is an IP based encapsulation for MPLS packets that uses a UDP header instead. Most existing routers in IP networks are already capable of distributing IP traffic over ECMP and/or LAG, based on the hash of the five-tuple of UDP and TCP packets (therefore, source IP address, destination IP address, source port, destination port, and protocol). By encapsulating the MPLS packets into an UDP tunnel and using the source port of the UDP header as an entropy field (hash of the payload), the existing load-balancing capability can be leveraged to provide fine-grained ECMP load balancing of MPLS traffic over IP underlay networks

## Naming devices
Type(Leaf/Spine) - Number - Rack number - Pod number - DC number

## ASN numbering
- 4200000000 - 4294967294 - private 32 bit AS
- 42
- xx - DC number
- xx - pod number
- xxx - rack number
- x - level: host-0 leaf-1 spine-2 superspine-3 fw-4

## IP addresses

- p2p: /30 or /31 or unnumbered
- loopback /32
- Separate loopback for overlay MP-BGP connections
- 
### Example for whole DC
- Net 10.0.0.0/10
- 1x/12 - virtual DC
  - 1x/13 - clouds
  - 1x/14 - management
  - 1x/22 - anycast
- 3x/12 - DCs
- 8x/15 - PODs
  - 1x/16 - Kuber
  - 1x/17 - reserve
  - 1x/17 - racks
  - 31x/22 - for every rack, 31 because there are 32 ports on Leaf
  - 1x/22 -reserve 

### Example for switches only
- IP=10.Dn.Sn.X/31
  - Dn - DC number:
    - 0 - loopback 1
    - 1 - loopback 2
    - 2 - p2p links
    - 3 - reserved
    - 4-7 - services 
  - Sn - SPine number
  - X - value in order

## Fabrics

- IP Fabric - L3/routed access - no L2 at all, easy, no STP, no VXLAN, vendor not specific - no anycast gateway - difficult to segment - not popular in DC
- VXLAN fabric

- Came to change legacy 3 tier architechture
- 3 stage and 5 stage
- No STP, no Active/standby: only active/active and ECMP - load balancing
- All links are loaded and all routers are loaded
- Open standard
- RFC 8365: super spine - spine - leaf
- RFC 7938: spine - leaf - tor
- BGP UNNUMBERED - RFC5549
- BGP on server instead of LACP
- L3 every where, L3 goes down from distribution level to access level
- Fabric = Overlay, L3 Routed Access - is not a fabric, generally speaking

## Connecting servers
- Multichassis LAG (vPC, MLAG, Stack...)
- L3 on servers
- FHRP on leafs
- Do not reserve TOR switches

## Oversubscription

![image](https://user-images.githubusercontent.com/116812447/207340403-0efe260d-26ce-4894-a720-0633a4840026.png)
![image](https://user-images.githubusercontent.com/116812447/207340702-35686763-a6b1-4cb7-abbd-b4b037bdb372.png)
![image](https://user-images.githubusercontent.com/116812447/207341833-e4fac06a-ec29-48ed-abce-486f246c473b.png)
