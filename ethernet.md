# Ethernet

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
- Physical layer: media specifications + Physical signalling sublayer
- Data link layer: Media Access Control sublayer (MAC) + Logical Link Control sublayer (LLC)
- LLC is not covered by Ethernet standard, it is covered in 802.2, it describes how multiple Layer 3 protocols can interact with multiple Layer 2 technologies, not only Ethernet

## CSMA/CD
- Simplex - only one side speaks
- Half-Duplex - one talks, other keeps silence
- Full-Duplex - both talks
CS - Carrier Sense  
Carrier - it's a signal  
Perform Carrier Sense - listening for signal on the wire, if it is free, wait for a time - inter frame gap - 9 microseconds(the faster the Ethernet the smaller this time) - then send bits on the wire  
MA - Multiple Access -  we can send many frames one by one - not all old technologies could afford it  
CD - Collision Detect - when I speak, I also listen - if I get something during sending it is a collision


## Frame

## Cabling

