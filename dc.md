# Data Centers

Multi tenancy - several customers use one something(Data center, firewall, software) and they are called tenants.  
In DC tenants share Compute, Storage and Network. All these are orchestarted by service orchestration.  
Segmentation is done via VRF, VLAN, VNI...  
Microsegmentation: Private VLAN, ACI

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
