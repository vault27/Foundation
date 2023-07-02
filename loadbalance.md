# Load Balance

## DSR - Direct Server Return

- Also called as nPath routing or assymetric routing
- It supports one-arm mode and inline mode
- The appliance ages out sessions based on idle timeout
- Because the appliance does not proxy TCP connections (that is it does not send SYN-ACK to the client), it does not shut out SYN attacks
- In a DSR configuration, the NetScaler appliance does not replace the load balancing virtual server’s IP address with the destination server’s IP address. Instead, it forwards packets to a service by using the server’s MAC address. The VIP must be configured on the server and ARP must be disabled for the VIP which is configured on the server. Doing so prevents the client request from bypassing the appliance when it is configured in one-arm mode. For example, a user must configure VIP in the loopback interface and disable the ARP for the same VIP
- The appliance obtains the server’s MAC address from the monitor bound to the service
- This method is common in high-volume sites where offloading the task of routing return traffic back through the load balancers allows the load balancer to be used strictly for load distribution
- The servers see a connection directly from the client IP and reply to the client through the normal default gateway bypassing the load balancer on the return path
- Server replies to client with source IP of load balancer
- The load balancer can be on the same subnet as the backend servers keeping it as simple as possible
- Only the destination MAC address of the packets are changed and traffic Server → Client scales as you add more real servers allowing multi-gigabit throughput while using only a 1G equipped load balancer
- Very cheap
- Help some applications/protocols that need to make direct new connections back to the client such as RTSP
- You won't have access to Layer 7 processing at the load balancer
- Persistence will be restricted to source IP or destination IP methods, so no cookie based persistence
- SSL offloading or WAF’s at the load balancer are not suitable because they will need to see both inbound and outbound traffic so you would need to run these if required on different hardware
- Some operating systems or closed appliances may not allow a way to successfully resolve the ARP problem or to install a loopback adapter, but most will
- Load balancing by layer 2 address: The load balancer distributes load to service points using MAC addresses
- LB and server both have VIP configured
- Server must not answer ARP for VIP
- Service must bind to VIP
- Service may also have to bind to real IP for health checking
- LB and server need to be on the same L2 network segment
- Clients' source addresses are preserved

### Traffic flow

- The client sends a query to the VIP on the load balancer.
- The load balancer selects a server from the farm and passes the packet through unmodified with the exception of the MAC address
- The server replies directly to the client through the default gateway (not back through load balancer).
- The key to make this work is that the service points must be configured with the VIP as a secondary address that doesn't ARP. This is commonly implemented on the loopback (lo) interface. With this configuration, each service point is able to respond to packets that reach it using the VIP as the destination IP address. Because load balancing is done at Layer 2, and each request has the same destination IP address, all service points can respond in this way. This configuration allows reply traffic to return to the clients as if it originated from the load balancer’s public VIP

### L3 DSR, it is alternative to regular (L2) DSR:

- With IP over IP configuration, the NetScaler appliance and the servers do not need to be on the same Layer 2 subnet. Instead, the NetScaler appliance encapsulates the packets before sending them to the destination server. After the destination server receives the packets, it decapsulates the packets, and then sends its responses directly to the client. This is often referred to as L3DSR

### L3DSR without tunnel

- LB and servers need to agree on DSCP <=> VIP mapping
- LB sets DSCP bit according to known mapping
- LB changes destination address to the server's (real) IP, keeps client's source address
- Server checks DSCP bit
- Server rewrites destination address according to known mapping to
appropriate VIP
- VIP configured on loopback alias as with L2DSR
- Server responds to client's source address from VIP

Healthchecking is complicated in this case:

- Need to be able to check to see if the iptables plugin/kernel module is in place and working correctly – otherwise traffic may get blackholed
- LB sends:
    - Source IP: <LB IP> Dest IP: <Server IP>
    - Healthcheck URL "GET /index.html"
    - DSCP: 7
- Server replies:
    - Source IP: <VIP IP> Dest IP: <LB IP>
    - Status code "200 OK"
- Due to destination address rewriting, source/destination on the LB do not match
