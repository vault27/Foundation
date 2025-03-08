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

- MTU - maximum frame size ethernet card can send to the wire
- `Ethernet MTU = IP header + TCP/UDP/ICMP header + Payload`
- `MSS = TCP Payload = TCP Segment Size - TCP Header - TCP Otions` 
- TCP stack gets stream of of data - for example 10K, then it needs to chop it to segements, accorsing to MTU
- MSS - TCP payload - maximum it can be is 1460 because 1500 MTU limit
- MSS is sent in SYN, never repeated again
- TCP does not like fragmentation, throughput goes down, end point needs to think about reassambly
- It is not negotiable
- It means how much you can exept
- Ethernet was quite effective because it could carry 1500 bytes of data with only 18 bytes of overhead
- 20 bytes IP headers
- 20 bytes TCP headers
- 1460 bytes max TCP data
- MTU is hop to hop
- You need search for MTU issues in a PCAP file, search for ICMP message type 3 - destination unreachable, Code 4 - Fragmentation Needed, and MTU of nect hop is specified in this ICMP message
- After this TCP client starts reducing MSS size to pass through bittle neck
- Some routers do not send such messages, just drop oversized packsets
- Pings work ok in this situation, ping is only 64 bytes long
- To test you need to use big ping
- If you use `ping -s 1500` the client will fragment it from beginning, because it will be larger then NIC MTU, it will not cause an error, it will just fragment it
- And if we enable do not fragment it will show an error: `ping -s 1500 -D 1.1.1.1`
- Maximum we can do is: `ping -s 1472 -D 1.1.1.1`
- 1472 - the size of ICMP packet + ICMP header, no IP header - remember! The actual packet will be +20 bytes in case of IPv4
- ICMP messages should not be dropped by firewall
- We also can use a range for MTU in ping command with step - 1 byte: `ping -g 1470 -G 1480 -h 1 -D 1.1.1.1`
- And client needds to react on it
- Path MTU discovery is enabled by default in Windows
- Router can change MSS in a SYN packets

## MSS

- The MSS is not negotiated
- It’s a TCP option set in SYN segments
- The MSS is derived from the IP MTU
- It indicates how large segments you are willing to receive
- It’s not bidirectional
- It can be different in each direction
- It can be modified by an intermediate device - MSS clamping 

## Workflow

1. 
