# IP fabric
- Physical underlay network
- Also known as a Clos network
- Responsibility to provide unicast IP connectivity from any physical device (server, storage device, router, or switch) to any other physical device
- A typical solution uses two layers—spine and leaf—to form what is known as a three-stage IP fabric, where each leaf device is connected to each spine device
- Five-stage IP fabric: a fabric layer (or “super spine”) to provide inter-pod, or inter-data center, connectivity
- Every leaf should be connected with all Spines in POD
- A key benefit of an IP-based fabric is natural resiliency. High availability mechanisms such as MC-LAG or Juniper’s Virtual Chassis technology are not required, as the IP fabric uses multiple links at each layer and device. Resiliency and redundancy are provided by the physical network infrastructure itself. Plus all links are loaded. No STP, no HSRP, no stacking, no MLAGs.
- Mostly EBGP is used, own AS for every Spine and Leaf. Plus MP-BGP is included + VRF route leaking
- Maybe used any routing technologie: - IPv4+OSPF, IPv6+ISIS+BGP+L3VPN, L2+TRILL, L2+STP
- BorderLeaf - Servers are not connected to it, only external routers - Internet, Campus...
- LAGs are not used between leaf and spine. If spine goes down it will result loosing very fast channel. Another Spine is added instead. Or links speed are increased
- Clusters are not used because they are not reliable, especially on spines. On leaf sometimes....
- For truly cloud-native workloads that have no dependency on Ethernet broadcast, multicast, segmentation, multitenancy, or workload mobility, the best solution is typically a simple IP fabric network
-  Oversubscription - ratio of total host ports  capacity to total net ports capacity. For example: 480 Gbs to hosts and 160 Gbs to net, oversubscription - 3:1. 1:1  - non blocking network

## Firewall
- Bottle neck for network
- High load on Edge Leaf
- General decrease in network performance
- Firewall is connected to border leaf
- Firewall filters traffic between VRFs, route leaks for backups

## Servers connection
- LAG to one switch
- Two links to two leafs - ECMP on host
- MLAG to two LEAfs using proprietary algotithms
- 
