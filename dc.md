# Data Centers

- Multi tenancy - several customers use one something(Data center, firewall, software) and they are called tenants.  
- In DC tenants share Compute, Storage and Network. All these are orchestarted by service orchestration.  
- Segmentation is done via VRF, VLAN, VNI...  
- Microsegmentation: Private VLAN, ACI
- People switched from legacy tiered architechture to Clos Fabrics

## Alternatives to Clos fabrics
- JellyFish
- Torus
- Dring
- DragonFly
- HyperCube
- HyperX

## Non virtualized/legacy data centers
- Difficult to configure VLANs on all devices
- VLAN-ID field is 12 bits yielding a maximum of 4094 VLANs
- MAC scalability is affected due to limits on the number of MAC addresses that can be learned per device. Unpredictable amounts of BUM traffic when the MAC scale limit is surpassed, further impacts resiliency
- Due to STP, many unused links, no load balancing
- It is difficult connect two DC and stretch Layer 2 detween them
- Host mobility
- Microsegmentation

## Data Center Fabric / Underlay
- The term “fabric” describes how switch, server, and storage nodes connect to all other nodes in a mesh configuration, evoking the image of tightly woven fabric. These links provide multiple redundant communications paths and deliver higher total throughput than traditional networks
- There are both proprietary architectures and open, standards-based fabrics, such as EVPN-VXLAN
- It is a network architechture, it is used instead of traditional multitier architectures
- It effectively flattens the network architecture, thereby reducing the distance between endpoints within the data center
- It is based on Clos topology
- It provides a solid layer of connectivity in the physical network, tunnel endpoint reachability, equidistant endpoints, non-blocking core, low latency and high bandwidth for both East-West and North-South traffic, load balancing(multipath), use of all links, 
- Overlay rides on top of the fabric
- The fabric itself, when paired with an overlay, is called the underlay

## What is Fabric

## Fabric pros
- Equidistant endpoints
- Non-blocking core
- Low latency and high bandwidth for both East-West and North-South traffic

## Fabric types
- Ethernet fabric. Examples: QFabric, Virtual Chassis Fabric (VCF), and Junos Fusion. No STP. Multipath. Load balancing. Not OPen Standard. Not scalable.
- MPLS fabric. MPLS as a transport for Underlay. FRR(fast rerouting). Traffic engineering. MPLS signaling protocols like LDP, RSVP, or BGP-LU can be used to provide MPLS underlay. Devices should support MPLS.
- IP fabric. Underlay IP transport. Open standard, flat forwarding, horizontally scalable, and non-blocking spine/leaf architecture.


## Underlay best practices
- Do not use LAG between leaf and Spine. If one LAG link fails, it will reduce IGP cost and disable the whole LAG. Use Spines and Super Spines instead
- Maximum simple config for Spine, do not connect external devices to it, use Border Leafs for it


## Overlay
- The overlay network virtualizes the underlying physical infrastructure by creating logical networks over the physical underlay network
- It provies network virtualization, segmentation, stretched Ethernet segments, workload mobility, and other services
- Network based: high requirements for MAC table on ToR switches
- Host based: high load on host, open source, host has to support technology

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
