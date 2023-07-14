# QOS

- QoS = Quality of Service. This is a general term of classifying / prioritizing traffic in the network (for example, prioritize VoIP over FTP traffic)
- ToS = Type of Service. This is a byte in the IPv4 header which is used for Precedence, or in other words categorizing traffic classes (eg. precedence 0 = routine traffic, 5 = critical). In the more modern form, the ToS is used for DSCP. This is one of the tools available for QoS implementation
- CoS = Class of Service. This is a field in the ethernet header, also for categorizing traffic (0-7), however this works at layer 2

## DSCP

DiffServ uses a 6-bit differentiated services code point (DSCP) in the 8-bit differentiated services field (DS field) in the IP header for packet classification purposes. The DS field replaces the outdated IPv4 TOS field.
