# Traffic
BUM - Broadcast + Uknown unicast + Multicast

## Unicast
Unknown unicast traffic consists of unicast packets with unknown destination MAC addresses. By default, the switch floods these unicast packets that traverse a VLAN to all interfaces that are members of that VLAN. Forwarding this type of traffic can create unnecessary traffic that leads to poor network performance or even a complete loss of network service. This flooding of packets is known as a traffic storm.
To prevent a traffic storm, you can disable the flooding of unknown unicast packets to all VLAN interfaces by configuring specific VLANs or all VLANs to forward all unknown unicast traffic traversing them to a specific interface.

## Anycast
IPv6 has built-in support for this application in the form of anycast addressing. Anycast addresses can be assigned to any number of hosts that provide the same service; when other hosts access this service, the specific server they hit is determined by the unicast routing metrics on the path to that particular group of servers. This provides geographic differentiation, enhanced availability, and load balancing for the service.  
Once an address is assigned to more than one host, it becomes an anycast address by definition.

## Bandwidth vs throughput
- Bandwidth - channel capacity - maximum amount of data that could, theoretically, travel from one point in the network to another in a given time
- Throughput - actual amount of data transmitted and processed throughout the network
