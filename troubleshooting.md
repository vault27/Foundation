# Troubleshooting

- Traceroute from client to server
- Three datagrams are sent, each with a Time-To-Live (TTL) field value set to one. The TTL value of 1 causes the datagram to "timeout" as soon as it hits the first router in the path; this router then responds with an ICMP Time Exceeded Message (TEM) that indicates that the datagram has expired
- This process continues until the packets actually reach the other destination. Since these datagrams try to access an invalid port at the destination host, ICMP Port Unreachable Messages are returned, and indicates an unreachable port; this event signals the Traceroute program that it is finished
