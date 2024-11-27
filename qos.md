# QOS

- QoS = Quality of Service. This is a general term of classifying / prioritizing traffic in the network (for example, prioritize VoIP over FTP traffic)
- ToS = Type of Service. This is a byte in the IPv4 header which is used for Precedence, or in other words categorizing traffic classes (eg. precedence 0 = routine traffic, 5 = critical). In the more modern form, the ToS is used for DSCP. This is one of the tools available for QoS implementation
- CoS - Class of Service. This is a field in the ethernet header, also for categorizing traffic (0-7), however this works at layer 2

## DSCP/TOS

- TOS field - 8 bits - Type of Service
- Differentiated Services (DS) field - new name
- Divided into:
        - DSCP (6 bits): For QoS traffic classification - differentiated services code point
        - ECN (2 bits): For congestion notification - Explicit Congestion Notification
- ECN deals with network congestion management. It provides feedback to endpoints about congestion without dropping packets, enabling them to adjust their transmission rates - router marks packets with ECN, when it sees congestion
- IPv6 Header: The equivalent field is called the Traffic Class field, serving the same purpose as the DS field in IPv4 
- Example:
        - Voice packets are marked with a DSCP value of 46 (Expedited Forwarding, EF).
        - Default data traffic is left unmarked or assigned a lower DSCP value like 0 (Best Effort)
        - When router receives packet it processes it quicker

Router config to check DSCP and prioritize it

```
class-map match-any VOICE
 match dscp ef
!
policy-map PRIORITIZE-VOICE
 class VOICE
  priority percent 30
 class class-default
  fair-queue
!
interface GigabitEthernet0/1
 service-policy output PRIORITIZE-VOICE
```

Explanation:
- Class-map: Matches traffic with DSCP ef (Expedited Forwarding)
- Policy-map: Assigns priority to the matched traffic and limits it to 30% of the bandwidth
- Interface Configuration: Applies the QoS policy to an outgoing interface

Router config to mark voice traffic

```
Define an ACL to Match Voice Traffic: Identify traffic based on ports commonly used by VoIP protocols like SIP (5060/5061) and RTP (16384-32767)
access-list 100 permit udp any any range 16384 32767
access-list 100 permit tcp any any eq 5060
access-list 100 permit tcp any any eq 5061

Create a Class Map to Match the ACL: Group the identified voice traffic
class-map match-any VOICE-TRAFFIC
 match access-group 100

Define a Policy Map to Mark the Traffic: Assign DSCP values to the matched traffic. For voice, DSCP 46 (Expedited Forwarding - EF) is typically used
policy-map MARK-VOICE
 class VOICE-TRAFFIC
  set dscp ef
 class class-default
  set dscp default

Apply the Policy Map to an Interface: The policy can be applied on either ingress or egress interfaces. Here, it’s applied on the ingress (incoming) traffic of an interface
interface GigabitEthernet0/1
 service-policy input MARK-VOIC
```