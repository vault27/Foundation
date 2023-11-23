# Troubleshooting

- You have diagram from client to server
- Wi-Fi or Cable - ask user
- Traceroute from client to server
- Three datagrams are sent, each with a Time-To-Live (TTL) field value set to one. The TTL value of 1 causes the datagram to "timeout" as soon as it hits the first router in the path; this router then responds with an ICMP Time Exceeded Message (TEM) that indicates that the datagram has expired
- This process continues until the packets actually reach the other destination. Since these datagrams try to access an invalid port at the destination host, ICMP Port Unreachable Messages are returned, and indicates an unreachable port; this event signals the Traceroute program that it is finished
- If there is a firewall on the way, after it there will be permanent Request timed out
- Reply from routers arrives from interface IP, where UDP arrived
- Several traceroutes can be launched to understand if there is a ECMP involved, or load balancing
- After traceroute connect to devices to get its name and config
- Hostname in CLI
- Show all interfaces in all VRFs: **show ip int br vrf all**
- Identify VRF and VLAN
- Draw
- Identify MAC of the client: **show ip arp vrf User | inc 10.90.23.103**
- Find the port: **show mac address-table vlan 300 | inc 8038.fb82.b482**
- Find physical port based on Port Channel: **show interface PO13**
- Find CDP neighbors on port: **show cdp neighbors interface ethernet 1/2**
- 

