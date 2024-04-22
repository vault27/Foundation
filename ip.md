# IP

The king of networks

## Packet

## IP Design

- Four billion (232) IP addresses in IPv4 - keep track of them is incredibly complex, and require a lot of resources, that's why we use prefixes.
- Sticking to prefixes reduces that number down to about one million instead.
- Contiguous ranges of IP addresses are expressed as IP prefixes  
- IP prefixes: An IP prefix is a range of IP addresses, bundled together in powers of two: In the IPv4 space, two addresses form a /31 prefix, four form a /30, and so on, all the way up to /0, which is shorthand for “all IPv4 prefixes''. The same applies for IPv6  but instead of aggregating 32 bits at most, you can aggregate up to 128 bits. The figure below shows this relationship between IP prefixes, in reverse -- a /24 contains two /25s that contains two /26s, and so on

## IP address

- The number of addresses inside a network or subnet may be calculated as 2 power (address length − prefix length), where address length is 128 for IPv6 and 32 for IPv4. For example, in IPv4, the prefix length /29 gives: 2(32−29) = 2(3) = 8 addresses

## CIDR/VLSM

- Classless Inter-Domain Routing (CIDR) is an IP address allocation method and IP routing
- CIDR notation is a compact representation of an IP address and its associated network mask. The notation was invented by Phil Karn in the 1980s.[9][10] CIDR notation specifies an IP address, a slash ('/') character, and a decimal number. The decimal number is the count of consecutive leading 1-bits (from left to right) in the network mask. The number can also be thought of as the width (in bits) of the network prefix. The IP address in CIDR notation is always represented according to the standards for IPv4 or IPv6
- The address may denote a specific interface address (including a host identifier, such as 10.0.0.1/8), or it may be the beginning address of an entire network (using a host identifier of 0, as in 10.0.0.0/8 or its equivalent 10/8). CIDR notation can even be used with no IP address at all, e.g. when referring to a /24 as a generic description of an IPv4 network that has a 24-bit prefix and 8-bit host numbers
- Before CIDR notation invention even in CIDR used old notation: 192.24.12.0/255.255.252.0 
- Introduced by IETF in 1993 to replace the previous classful network addressing architecture 
- Goals: slow growth of routing tables and exhaustion of IPv4 addresses
- Until the early 1990s, IP addresses were allocated using the classful addressing system. The total length of the address was fixed, and the number of bits allocated to the network and host portions were also fixed
- Classless or Classless Inter-Domain Routing (CIDR) addresses use variable length subnet masking (VLSM) to alter the ratio between the network and host address bits in an IP address
- Supernetting is the direct opposite of subnetting, in which multiple networks are combined into a single large network known as supernets
- FLSM (Fixed Length Subnet Masks) Subnetting
- CIDR notation 0.0.0.0/0  - all possible IP addresses
- 0.0.0.0 address in destination is prohibited according to RFC 1122
- 0.0.0.0 address in source can be used, if host yet does not have an address

## Bogon prefixes

These prefixes are not globally unique prefixes. IETF didn’t intend for these to be routed on the public Internet  
https://bgpfilterguide.nlnog.net/guides/bogon_prefixes

- 0.0.0.0/8+    # RFC 1122 'this' network
- 10.0.0.0/8+      # RFC 1918 private space
- 100.64.0.0/10+     # RFC 6598 Carrier grade nat space
- 127.0.0.0/8+     # RFC 1122 localhost
- 169.254.0.0/16+   # RFC 3927 link local
- 172.16.0.0/12+    # RFC 1918 private space
- 192.0.2.0/24+    # RFC 5737 TEST-NET-1
- 192.88.99.0/24+   # RFC 7526 6to4 anycast relay
- 192.168.0.0/16+   # RFC 1918 private space
- 198.18.0.0/15+    # RFC 2544 benchmarking
- 198.51.100.0/24+  # RFC 5737 TEST-NET-2
- 203.0.113.0/24+    # RFC 5737 TEST-NET-3
- 224.0.0.0/4+      # multicast
- 240.0.0.0/4+      # reserved

## IP services

### NAT

### DHCP

### FHRP

### ARP

## MTU + Do not fragment bit

- Some applications put DF bit and packet cannot be fragmented - for such apps MTU should be proper configured along all path
- Most encrypted traffic has this bit
- Application puts this bit and we cannot control it
- When router gets packet with this bit and packet is bigger then MTU to next hop, router sends ICMP Unreachable Error Messages
- These messages tell the source to reduce the packet size
- These messages can be rate limited
- If they do not reach source - connection will not work




