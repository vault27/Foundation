## MTU

In Ideal World:

```
                              +-----------------------------+-------------------------------------------------+
                              | ICMP Header                 |                                                 |
                              | 8 bytes - min               |             Payload - 1472 max - Ping           |
                              |                             |                                                 |
+-----------------------------+-----------------------------+-------------------------------------------------+
| IP Header                   | TCP Header                  |                                                 |
| 20 Bytes - min - no options | 20 Bytes - min - no options |            Payload - 1460 bytes - max MSS       |
| 60 Bytes - max - options    | 60 Bytes - max - options    |                                                 |
|-----------------------------+-----------------------------+-------------------------------------------------|
|                                                                                                             |
|                                             MTU - 1500 bytes                                                |
|                                                                                                             |
<------------------------------------------------------------------------------------------------------------->
```

## MTU

- MTU - maximum frame size ethernet card can send to the wire
- `Ethernet MTU = IP header + TCP/UDP/ICMP header + Payload`
- Ethernet was quite effective because it could carry 1500 bytes of data with only 18 bytes of overhead
- 20 bytes IP headers
- 20 bytes TCP headers
- 1460 bytes max TCP data
- MTU is hop to hop
- After this TCP client starts reducing MSS size to pass through bittle neck
- Some routers do not send such messages, just drop oversized packsets
- Path MTU discovery is enabled by default in Windows

## MSS

- The MSS is not negotiated
- TCP stack gets stream of of data - for example 10K, then it needs to chop it to segements, accorsing to MTU
- MSS - TCP payload - maximum it can be is 1460 because 1500 MTU limit
- MSS is sent in SYN, never repeated again
- TCP does not like fragmentation, throughput goes down, end point needs to think about reassambly
- It is not negotiable
- It means how much you can accept
- Usually it is 1460 bytes
- `MSS = TCP Payload = TCP Segment Size - TCP Header - TCP Otions` 
- It’s a TCP option set in SYN segments
- The MSS is derived from the IP MTU
- It indicates how large segments you are willing to receive
- It does not include TCP header
- It’s not bidirectional
- It can be different in each direction
- It can be modified by an intermediate device - MSS clamping 
- Router can change MSS in a SYN packets

## Troubleshooting

- You need search for MTU issues in a PCAP file, search for ICMP message type 3 - destination unreachable, Code 4 - Fragmentation Needed, and MTU of next hop is specified in this ICMP message
- Pings work ok in this situation, ping is only 64 bytes long
- To test you need to use big ping
- If you use `ping -s 1500` the client will fragment it from beginning, because it will be larger then NIC MTU, it will not cause an error, it will just fragment it
- And if we enable do not fragment it will show an error: `ping -s 1500 -D 1.1.1.1`
- Maximum we can do is: `ping -s 1472 -D 1.1.1.1`
- 1472 - the size of ICMP packet + ICMP header, no IP header - remember! The actual packet will be +20 bytes in case of IPv4
- ICMP messages should not be dropped by firewall
- We also can use a range for MTU in ping command with step - 1 byte: `ping -g 1470 -G 1480 -h 1 -D 1.1.1.1`
- And client needs to react on it
- Packet capture is  required from both sides: server and client
- In packet capture you will see that large packets were sent from server and did not reach client
- MSS blackhole - no ICMP message with error and no ACK from client
- Server keeps trying to send in timeout intervals
- Nothing happens and then server tries to send 536 bytes - the minimum every IP station should transfer
- That is why we have a long pause - server tries to send but packets are blocked due to MTU
- And after this packet went through server uses only 536 packets - small ones during all session
- These things depend on particular TCP implementation, maybe it will try big packets again
- Thus, one of the signs of MTU issues - all packets in a session have a small size

## Path MTU Discovery

- (PMTUD)
- IP end-hosts detect the end-to-end MTU size with Path MTU discovery, defined in RFC 1191
- The sending host can indicate that its IP datagrams shall not be fragmented by setting the Don’t Fragment (DF) bit in each outgoing datagram
- The intermediate routers that have to drop oversized IP datagrams they cannot fragment (due to DF bit or protocol version) inform the sending host that the datagram has been dropped with an ICMP Destination Unreachable message with the status code Fragmentation needed and DF set
- An extra field in the ICMP response indicates the maximum MTU the sending router could support on the outgoing link
- The MTU size reported by an intermediate router is cached as the new MTU for the destination host and all future outgoing datagrams will not exceed that MTU
- The TCP stack in the originating host or a PMTUD-aware UDP application has to retransmit the data in smaller datagrams
- The hosts eventually age out the computed end-to-end MTU values (the timeout recommended in the RFC 1191 is ten minutes), resulting in renewed PMTUD process
- UDP does not have MSS and relies only on PMTUD
- Path MTU discovery does not work for IP multicast - routers do not generate ICMP messages in response to dropped IP multicast packets

These are things that can break PMTUD.
- A router drops a packet and does not send an ICMP message. (Uncommon)
- A router generates and sends an ICMP message, but the ICMP message gets blocked by a router or firewall between this router and the sender. (Common)
- A router generates and sends an ICMP message, but the sender ignores the message. (Uncommon)
