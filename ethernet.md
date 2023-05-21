# Ethernet

www.EthernetAlliance.org

- Family of LAN standards, which describe physical and data-link layers
- Standards are defined by Institute of Electrical and Electronics Engineers (IEEE) and start with 802.3
- Physical layer: media specifications + Physical signalling sublayer
- Data link layer: Media Access Control sublayer (MAC) + Logical Link Control sublayer (LLC)
- LLC is not covered by Ethernet standard, it is covered in 802.2, it describes how multiple Layer 3 protocols can interact with multiple Layer 2 technologies, not only Ethernet

## History and overview

- Invented by Xerox in 1973
- First standard - 1985 - IEEE 802.3
- 802.3 Ethernet and initial Ethernet are different
- Alohanet - developed in University of Hawaii - in 1971 - radio - Ethernet is based on it
- Cable was coaxial - one very long cable - all computers and printers on PaloAlto Xerox research center were connected to it
- Initially was half-duplex
- 2.94 Mb/s, version 2 - 10 Mb/s
- 1995 - FastEthernet - 802.3u - 100 Mbit/s
- Robert Methalf - creator of 3Com
- 1998 - Gigabit Ethernet
- 2002 - 10 Gb/s - Fiber only
- 2010 - 802.3ba - 40 Gb/s and 100 Gb/s

## CSMA/CD

- No need any more
- Simplex - only one side speaks
- Half-Duplex - one talks, other keeps silence
- Full-Duplex - both talks
- CS - Carrier Sense  
- Carrier - it's a signal  
- Perform Carrier Sense - listening for signal on the wire, if it is free, wait for a time - inter frame gap - 9 microseconds(the faster the Ethernet the smaller this time) - then send bits on the wire  
- MA - Multiple Access -  we can send many frames one by one - not all old technologies could afford it  
- CD - Collision Detect - when I speak, I also listen - if I get something during sending it is a collision  
- Collision transforms signals to meaningless garbage  
- If a host detects a collision - it stops everything and  sends a JAM sequence - everybody on the cable recognises it as a sign of a collision  
- After JAM hosts have to wait for a random backoff timer  

## Physical layer standards

Each standard has formal(starts with 802) name and informal name(100BASE-T) and Common name (Fast Ethernet)  
T - UTP - Unshielded twisted pair  
X - fiber  
100 - Speed  
BASE - Baseband - means that entire cable is used  
At the end there also maybe a number in old standards - it means maximum cable length  
Pair is twisted because it reduces EMI - Electromagnetic Influence  
RJ-45 - it is a connector, mostly used, SFP connector can also be used

- 10 Mbps - Ethernet - 10BASE-T - 802.3 - Copper - 100 m
- 100 Mbps - Fast Ethernet - 100BASE-T - 802.3u - Copper - 100 m
- 1000 Mbps - Gigabit Ethernet - 1000BASE-LX - 802.3z - Fiber - 5000 m
- 1000 Mbps - Gigabit Ethernet - 1000BASE-T - 802.3ab - Cooper - 100 m
- 10 Gbps - 10 Gig Ethernet - 10GBASE-T - 802.3an - Cooper - 100 m

If we connect two devices on one level of OSI model then we use crossover cable: switch-switch hub-hub router-router  
If we connect two devices on different levels of OSI model, then we use straight-through cable: router-switch, hub-PC, switch-hub  
Crossover acble: 1 goes to 3, 2 goes to 6  
Auto MDI-X technology on adapters switch automatically to correct cable type  
The UTP cables differ in the following parameters:
- Twists per centimeter - the more the better protection against EMI
- Sheath thickness

## UTP Categories

- Cat 5 - 100 Mbs
- Cat 5e - 1 Gbps
- Cat 6 - 10 Gbps - 55 meters
- Cat 6a - 10 Gbps
- Cat 7/7a - 10 Gbps
- Cat 8 - 40 Gbits - 30 meters  

STP - Shielded Twisted Pair - covered with foil

## Auto-Negotiation

- 802.3u - clause 28
- Before auto negotiation after inserting a cable network interface sent an electric pulse and interface on other end had a green light
- Then they encoded supported speeds in this pulse - auto-negotiation - 16 bits long - every bit for its own speed - other end replies with its options and acknowledgements
- Negotiation: speed, duplex, flow control
- Enabled everywhere by default and very stable nowdays

## Frame

- Destination MAC address
- Source MAC address
- EtherType: two-octet field in an Ethernet frame. It is used to indicate which protocol is encapsulated in the payload of the frame and is used at the receiving end by the data link layer to determine how the payload is processed. Examples:
    - IPv4
    - ARP
    - IPv6
    - MPLS
    - PPPoE 

## MAC

- 48 bits - 6 bytes - Media Access Controll address
- Consists of 6 numbers, usually written in hexademical format
- 12 digits long hexadecimal number
- Usually devided into 2 or 4 digit blocks, when presented in software
- No matter which style you use to write the MAC address, a MAC address is always processed in binary numbers only
- First 24 bits are OUI - organizationally unique identifier - provided by IEEE
- The rest 24 bits are assigned by manufacture
- Written in hexadecimal - 6 numbers - one for each byte
- Broadcast MAC: ff:ff:ff:ff:ff:ff, all 1s, used in ARP, broadcast, DHCP...
  
## FCS

A frame check sequence (FCS) is an error-detecting code added to a frame in a communications protocol. Frames are used to send payload data from a source to a destination.  
By far the most popular FCS algorithm is a cyclic redundancy check (CRC), used in Ethernet and other IEEE 802 protocols with 32 bits.  
The FCS provides error detection only. Error recovery must be performed through separate means. Ethernet, for example, specifies that a damaged frame should be discarded and does not specify any action to cause the frame to be retransmitted. Other protocols, notably the Transmission Control Protocol (TCP), can notice the data loss and initiate retransmission and error recovery.

## Jumbo frames

## Pause frames

## Flow control

## Ethernet interface

- scopeid
- txqueuelen
- errors - CRC failures on receipt of a frame: bad cable, bad interface, bad switch
- drops - IPv6, VLANs
- overrruns
- frame
- carrier
- collision

## Mac flapping

A MAC Flap is caused when a switch receives packets from two different interfaces with the same source MAC address.
It may happen, if static Etherchannel is configured, and one switch considers physical link as individual and other switch considers it as a past of Etherchannel.  
So LACP is better then static.  
Check MAC address flapping - one MAC on several ports

## Loop

To identify a loop on a switch we can see broadcast counters on an interface:

```
show interface counters
```

## Duplex mismatch

In such conditions, the full-duplex end of the connection sends its packets while receiving other packets; this is exactly the point of a full-duplex connection. Meanwhile, the half-duplex end cannot accept the incoming data while it is sending – it will sense it as a collision.

## MTU

## ARP

## DHCP

