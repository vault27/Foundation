# IP Design
- Four billion (232) IP addresses in IPv4 - keep track of them is incredibly complex, and require a lot of resources, that's why we use prefixes.
- Sticking to prefixes reduces that number down to about one million instead.
- Contiguous ranges of IP addresses are expressed as IP prefixes  
- IP prefixes: An IP prefix is a range of IP addresses, bundled together in powers of two: In the IPv4 space, two addresses form a /31 prefix, four form a /30, and so on, all the way up to /0, which is shorthand for “all IPv4 prefixes''. The same applies for IPv6  but instead of aggregating 32 bits at most, you can aggregate up to 128 bits. The figure below shows this relationship between IP prefixes, in reverse -- a /24 contains two /25s that contains two /26s, and so on

## IP Unnumbered
- We can use IP of active interface on any other interface
- Devised for p2p and serial links
- Requires minimum one active interface
- For BGP uses dynamic AS range and link local
- Supported by OSPF/IS-IS/eBGP
- Simplifies network setup
- Saves IP address space
- Does not support iBGP, PIM, BFD
- More difficult to troubleshoot
- Does not support inband management
- In some cases SNMP requires IP

## Bogon prefixes
These prefixes are not globally unique prefixes. IETF didn’t intend for these to be routed on the public Internet  
https://bgpfilterguide.nlnog.net/guides/bogon_prefixes

- 0.0.0.0/8+,         # RFC 1122 'this' network
- 10.0.0.0/8+,        # RFC 1918 private space
- 100.64.0.0/10+,     # RFC 6598 Carrier grade nat space
- 127.0.0.0/8+,       # RFC 1122 localhost
- 169.254.0.0/16+,    # RFC 3927 link local
- 172.16.0.0/12+,     # RFC 1918 private space
- 192.0.2.0/24+,      # RFC 5737 TEST-NET-1
- 192.88.99.0/24+,    # RFC 7526 6to4 anycast relay
- 192.168.0.0/16+,    # RFC 1918 private space
- 198.18.0.0/15+,     # RFC 2544 benchmarking
- 198.51.100.0/24+,   # RFC 5737 TEST-NET-2
- 203.0.113.0/24+,    # RFC 5737 TEST-NET-3
- 224.0.0.0/4+,       # multicast
- 240.0.0.0/4+ ];     # reserved
