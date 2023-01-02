# VxLAN
- RFC 7348
- Virtual Extensible LAN, MAC in UDP encapsulation, port 4789, 50 bytes overhead
- MTU should be large
- Only transport requirement is unicast IP
- VLAN numbers can be different on all switches, but VNI number should be the same 

## Components
- VNID - Vxlan Network Identifier - defines broadcast segment - transfered in VxLAN header - 3 bytes
- NVE - Network Virtualization Edge - interface where VXLAN ends - only 1 NVE interface is allowed on the switch.
- VTEP - VXLAN Tunnel Endpoint - Nexus - Leaf

## Load balancing
The Layer 3 routes that form VXLAN tunnels use per-packet load balancing by default, which means that load balancing is implemented if there are ECMP paths to the remote VTEP. This is different from normal routing behavior in which per-packet load balancing is not used by default. (Normal routing uses per-prefix load balancing by default.)  
  
The source port field in the UDP header is used to enable ECMP load balancing of the VXLAN traffic in the Layer 3 network. This field is set to a hash of the inner packet fields, which results in a variable that ECMP can use to distinguish between tunnels (flows).  
  
None of the other fields that flow-based ECMP normally uses are suitable for use with VXLANs. All tunnels between the same two VTEPs have the same outer source and destination IP addresses, and the UDP destination port is set to port 4789 by definition. Therefore, none of these fields provide a sufficient way for ECMP to differentiate flows.  
  
That is why UDP is used, not IP for example.

## BUM traffic

Can be processed in 2 ways:
- Multicast replication - multicast is enabled on Underlay - BUM is not packed inside VxlAN - it is sent via Underlay - replication point is on rendezvous point - spine - it si difficult to configure multicast on Underlay - not used today
- Ingress repliaction - packed to VxLAN - and sent to all in VNI - configured statically or with BGP EVPN

## Static configuration
First packet and broadcast are sent to all peers, configured for this VNI. 

## Configuration on Nexus 9000
We create special Loopback for overlay, announce it to BGP.  
For every VLAN where clients are connected we configure VNI.  
Firewall is a default gateway for clients. Firewall is connected to the borderleaf with TRUNK port, subinterfaces are configured on firewall.  
Next we configure nve interface, where we configure peers for every VNI.

```
feature vn-segment-vlan-based
feature nv overlay

vlan 100
  name PROD
  vn-segment 100
  
interface Ethernet1/3
  switchport access vlan 100

interface nve1
  no shutdown
  source-interface loopback1
  member vni 100
    ingress-replication protocol static
      peer-ip 10.10.2.4
      peer-ip 10.10.2.5
  member vni 200
    ingress-replication protocol static
      peer-ip 10.10.2.4
      peer-ip 10.10.2.5
      
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
Show info about nve interface
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
