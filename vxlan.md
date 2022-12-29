# VxLAN
- RFC 7348
- Virtual Extensible LAN, MAC in UDP encapsulation, port 4789

## Components
- Identifier - VN Identifier - VNID - defines broadcast segment
- NVE - Network Virtualization Edge - interface where VXLAN ends
- VTEP - VXLAN Tunnel Endpoint - Nexus - Leaf

## Load balancing
The Layer 3 routes that form VXLAN tunnels use per-packet load balancing by default, which means that load balancing is implemented if there are ECMP paths to the remote VTEP. This is different from normal routing behavior in which per-packet load balancing is not used by default. (Normal routing uses per-prefix load balancing by default.)  
  
The source port field in the UDP header is used to enable ECMP load balancing of the VXLAN traffic in the Layer 3 network. This field is set to a hash of the inner packet fields, which results in a variable that ECMP can use to distinguish between tunnels (flows).  
  
None of the other fields that flow-based ECMP normally uses are suitable for use with VXLANs. All tunnels between the same two VTEPs have the same outer source and destination IP addresses, and the UDP destination port is set to port 4789 by definition. Therefore, none of these fields provide a sufficient way for ECMP to differentiate flows.  
  
That is why UDP is used, not IP for example.
