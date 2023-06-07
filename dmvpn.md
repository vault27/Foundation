# DMVPN

- DMVPN uses a combination of...
    - Multipoint GRE Tunnels (GRE)
    - Next Hop Resolution Protocol (NHRP)
    - IPsec Crypto Profiles
    - Routing
- Requires two IGPs: Underlying and Overlay
Two main components
+ DMVPN Hub / NHRP Server (NHS)
+ DMVPN Spokes / NHRP Clients (NHC)
+ Spokes/Clients register with Hub/Server + Spokes manually specify Hub's address
+ Sent via NHRP Registration Request
Hub dynamically learns Spokes' VPN address & NBMA address
+ Spokes establish tunnels to Hub
+ Exchange IP Routing information over the tunnel
- EIGRP is a protocol of choice for DMVPN
- Spoke1 knows Spoke's routes via IGP
+ Learned via tunnel to Hub
+ Next-hop is Spoke2's VPN IP for DMVPN Phase2
+ Next-hop is Hub's VPN IP for DMVPN Phase3
+ Spoke1 asks for Spoke's real address
+ Maps next-hop (VPN) IP to tunnel source (NBMA) IP
+ Sent via NHRP Resolution Request
+ Spoke to Spoke tunnel is formed
+ Hub only used for control plane exchange
+ Spoke-to-spoke data plane may flow through hub initially

## NHRP Important Messages

NHRP Registration Request
+ Spokes register their NMBA and VPN IP to NHS
+ Required to build the spoke-to-hub tunnels
+
NHRP Resolution Request
+ Spoke queries for the NBMA-to-VPN mappings of other spokes
+ Required to build spoke-to-spoke tunnels
+
NHRP Redirect
+ NHS answer to a spoke-to-spoke data-plane packet through it
+
Similar to IP redirects, when packet in/out interface is the same + Used only in DMVPN Phase3 to build spoke-to-spoke tunnels

## DMVPN Phases

DMVPN can be deployed in three "phases"
+ DMVPN Phase 1
+ DMVPN Phase 2
+ DMVPN Phase 3
+ DMVPN phase affects
+ Spoke to spoke traffic patterns
+
Supported routing designs
+
Scalability

### DMVPN Phase 1 (Now obsolete)

mGRE on hub and p-pGRE on spokes
+ NHRP still required for spoke registration to hub
+ No spoke-to-spoke tunnels
+ Routing
+ Summarization/default routing at hub is allowed + Next-hop on spokes is always changed by the hub

### DMVPN Phase 2 (Now obsolete)

mGRE on hub and spokes
+ NHRP required for spoke registration to hub + NHRP required for spoke-to-spoke resolution + Spoke-to-spoke tunnel triggered by spoke
+ Routing
+ Summarization/default routing at hub is NOT allowed + Next-hop on spokes is always preserved by the hub + Multi-level hierarchy requires hub daisy-chaining

+ Routing protocols over DMVPN Phase 2
† RIP
† EIGRP
† OSPE
† BGP

### DMVPN Phase 3

+ mGRE on hub and spokes
+ NHRP required for spoke registration to hub + NHRP required for spoke-to-spoke resolution
When a hub receives and forwards packet out of same interface...
+ Send NHRP redirect message back to packet source
+ Forward original packet down to spoke via RIB

+ Routing
+ Summarization/default routing at hub is allowed
+ Results in NHRP routes for spoke-to-spoke tunnel
+ With no-summary, NHO is performed for spoke-to-spoke tunnel
+ Next-hop is changed from hub IP to spoke IP
+ Next-hop on spokes is always changed by the hub
+ Because of this, NHRP resolution is triggered by hub
+ Multi-level hierarchy works without daisy-chaining