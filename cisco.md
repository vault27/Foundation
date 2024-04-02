# Cisco

## Portfolio

- Management platforms
    - Meraki Dashboard
    - DNA center
- Switches
    - Catalyst 9410 - big chassis for access
    - Catalyst 9500 - Core switches
    - Meraki MS switches
    - Catalyst 1000 Series
    - Catalyst PON Series
- Routers
    - Catalyst 8000 series
    - Catalyst 8000V
    - ISR
    - ASR
    - NCS
    - 88 platform
    - CSR 1000v
    - Meraki MX
- Umbrella
- Webex
- SD-WAN - Viptella
    - Catalyst SD-WAN
 

## Catalyst

- Brand for a variety of network switches, wireless controllers, and wireless access points
- Series: The 1700, 1900, 2800 -  Grand Junction Networks, 3000 -  Kalpana, 5000 and 6000 - Crescendo Communications, 9000
- CatOS first,  layer 2 functions are configured using CatOS, and the layer 3 elements are configured using IOS, pure IOS
- GUI via HTTP
- Cisco Catalyst products run IOS or a Linux-derived version called Cisco IOS XE
- The newer Catalyst 9000 family uses the Cisco IOS XE operating system
- 9400, 9600 - chassis: field-replaceable supervisor, line cards, power supplies and fans
- Chassis provides power and a high-speed backplane, the line cards provide interfaces to the network, and the supervisor engine moves packets, participates in routing protocols, etc
- StackWise and Stackwise Virtual are technologies offered by Cisco Systems that allows some models of Catalyst switches to operate as though they were one switch
- One switch is master, if master fails - another is a master
- Stackwise physically connects the switch stack using special stack interconnect cables

**Upgrade**

Backup 

```
copy run start
ter len 0
sh log 
sh run
```

Pre checks

```
term len 0
show logging
show environment all
show ver
show mac add dynamic
show spanning-tree summary
show spanning-tree root
show cdp nei
show interfaces status err-disabled
show interfaces status | i connected
show power inline
show int trunk
show inventory
show module
show switch
```

Upgrade

```
install add file flash:cat9k_iosxe.17.09.04a.SPA.bin activate commit prompt-level none
```

## Documentation

- Configuration guides in Support >  Cisco IOS and NX-OS Software > Version
- Technology support page Support > Technology: https://www.cisco.com/c/en/us/tech/index.html


## Portfolio

## IOS

- Monolithic operating system running directly on the hardware
- Replaced with Cisco IOS XE

How to choose IOS

- Hardware Support
- Feature Support
- Cisco IOS Software Release Version

Image types:

- Original IOS for hardware - used with Dynamips
- IOL (IOS on Linux also known as IOU)
- QEMU images
- IOSv - used in VIRL - can be downloaded with Cisco account, there are also available:
    - IOSXRv 9000
    - IOSvL2
    - CSR1000v
    - ASAv
    - NX-OSv
    - IOS XRv
    - IOSv
- vIOS can be qcow2 image and vmdk image
- qcow2 - is almost ready to be used in EVE
- vmdk - need to be converted

Image naming scheme:

- Different platforms ultimately run different Cisco IOS versions
- K9 - crypto support
- Image: platform + services + IOS version

IOS version naming

- Different platforms ultimately run different Cisco IOS versions 
- There are three sets of numbers that give us information about any version of Cisco IOS
- Train, throttle, rebuild
- Train - major version number
- Train examples: 12.2M, 12.4T, 15.0M, 15.1T
- Different trains for different platforms
    - ISR Routers G1/G2 (1800, 2800, 3800, 1900, 2900, 3900, etc) - 12.2M, 12.4M, 12.4T, 15.0M, 15.1T
    - Catalyst 6500 - Supervisor 32, Supervisor 720, Supervisor VS-720 - 12.2(18)SX, 12.2(33)SX
    -  7600 Router 12.2(33)SR, 15.0S
- Cisco IOS Throttle is roughly a minor version number where some new features and bug fixes can have been added
- Throttle consists of train + number in parenthesis: 12.4(20)T
- Cisco IOS Rebuilds typically consist of bug fixes. The addition of new features to a rebuild is generally avoided but it does happen sometimes. With rebuilds it can be confidently stated that one version of Cisco IOS is more recent than another. For example, 12.4(24)T7 is newer than 12.4(24)T5
- 15.0(1)M8 has been rebuilt 8 times
- M - mainline - recomended
- T - technology line - new features, not very stable
- 15X (special or early deployment), 15S (7600), 15Y (Sup-2T-10GE – Catalyst 6500), 15SG (Sup-CS-S2T – Catalyst 6500), and 15SE (2960, 3560, 3650, and 3750 platforms)


## IOS XR

- Focuses on the needs of service providers
- Modular, Linux based, memory protection between processes
- Has a completely different code base and whose developers implemented a different CLI command set
- IOS XR is based on QNX (since version 5.0 it's also based on linux), where the IOSd application has been separated into many different applications

## IOS XE

- Supports next-generation platforms
- Combination of a Linux kernel and a monolithic application (IOSd) that runs on top of this kernel
- Separates the data plane and control plane
- Introduced for ASR 1000 routers, also used in Catalyst 3850, Catalyst 9000, CSR1000v, ISR
- Running Wireshark on a switch

## NX-OS

## Nexus

vPC / Fabric Path / OTV / LISP / FEX  

The Nexus platform is modular. Each feature has its own processes, independent of other features.  

CAM - Content-addressable memory 

- Compares input search data against a table of stored data, and returns the address of matching data
- Also known as associative memory or associative storage
- Frequently used in networking devices where it speeds up forwarding information base and routing table operations
- In random-access memory (RAM) the user supplies a memory address and the RAM returns the data word stored at that address
- CAM is designed such that the user supplies a data word and the CAM searches its entire memory to see if that data word is stored anywhere in it. If the data word is found, the CAM returns a list of one or more storage addresses where the word was found. Thus, a CAM is the hardware embodiment of what in software terms would be called an associative array
- CAM is much faster than RAM in data search applications
- The additional circuitry increases the physical size and manufacturing cost of the CAM chip
- Binary CAM is the simplest type of CAM and uses data search words consisting entirely of 1s and 0s
- Ternary CAM (TCAM) allows a third matching state of X or don't care for one or more bits in the stored word, thus adding flexibility to the search
- For example, a stored word of "10XX0" in a ternary CAM will match any of the four search words "10000", "10010", "10100", or "10110"
- This additional state is typically implemented by adding a mask bit ("care" or "don't care" bit) to every memory cell
- Binary CAM is ususally used in switches, to look up MAC table
- Ternary CAMs are often used in network routers, where each address has two parts: the network prefix, which can vary in size depending on the subnet configuration, and the host address, which occupies the remaining bits
- The addresses are stored using don't care for the host part of the address, so looking up the destination address in the CAM immediately retrieves the correct routing entry; both the masking and comparison are done by the CAM hardware

TCAM in Nexus

- To use a non-default feature for Nexus 9000 Series switches, one must manually carve out TCAM space for the features. By default, all TCAM space is allocated

## CSR

Cloud Services Router 1000V Series
Contains features of Cisco IOS ® XE and IOS XE SD-WAN Software and can run on Cisco Unified Computing System ™ (Cisco UCS ®) servers or servers from leading vendors that support VMware ESXi, Citrix XenServer, Suse KVM, Red Hat KVM, or Microsoft Hyper-V. It is also available on Amazon Web Services and Microsoft Azure cloud marketplace. The CSR 1000V IOS XE Software is also available for Google Cloud Platform.
- IPsec VPNs
- Dynamic Multipoint VPN [DMVPN], Easy VPN, and FlexVPN
- Cisco IOS Zone-Based Firewall (ZBFW)
- Multiprotocol Label Switching (MPLS) endpoint
- Network Address Translation (NAT), Locator/ID Separation Protocol (LISP), Overlay Transport Virtualization (OTV) and Virtual Private LAN Service (VPLS)
- VxLAN

## ASR

## ISR

## IOSv

IOSv is an implementation of Cisco IOS that runs as a full virtual machine. The IOSv images are built from the Cisco IOS M/T train and support up to 16 GigabitEthernet interfaces. IOSv provides full layer-3 control-plane and data-plane functionality. Layer-2 switching is not supported, but layer-2 encapsulations, such as EoMPLS and L2TPv3, are supported.  
IOSv is performance limited when forwarding traffic. Achieved throughputs are ~2.8 Mb/s when passing traffic through one IOSv router, and ~2.4 Mb/s when chained over two routers. Baseline throughput bypassing the router was ~720 Mb/s.

## IOU

## Switch commands

**Show all MAC addresses on the switch**

```
switch#show mac address-table 
          Mac Address Table
-------------------------------------------
 
Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
All    0100.0ccc.cccc    STATIC      CPU
All    0100.0ccc.cccd    STATIC      CPU
All    0180.c200.0000    STATIC      CPU
All    0180.c200.0001    STATIC      CPU
All    0180.c200.0002    STATIC      CPU
All    0180.c200.0003    STATIC      CPU
All    0180.c200.0004    STATIC      CPU
All    0180.c200.0005    STATIC      CPU
All    0180.c200.0006    STATIC      CPU
All    0180.c200.0007    STATIC      CPU
All    0180.c200.0008    STATIC      CPU
All    0180.c200.0009    STATIC      CPU
All    0180.c200.000a    STATIC      CPU
All    0180.c200.000b    STATIC      CPU
All    0180.c200.000c    STATIC      CPU
All    0180.c200.000d    STATIC      CPU
All    0180.c200.000e    STATIC      CPU
All    0180.c200.000f    STATIC      CPU
All    0180.c200.0010    STATIC      CPU
All    0180.c200.0021    STATIC      CPU
All    ffff.ffff.ffff    STATIC      CPU
  20    0000.0c07.ac14    DYNAMIC     Te1/1/8
  20    34f8.e769.f756    STATIC      Vl20 
  20    4488.165b.db3f    DYNAMIC     Te1/1/8
  20    4488.165b.e21f    DYNAMIC     Te1/1/8
  20    cc90.70a1.0399    DYNAMIC     Te1/1/8
111    0000.0c07.ac6f    DYNAMIC     Te1/1/8
111    083a.8858.80f3    DYNAMIC     Te1/1/8
111    34bd.c8c7.c7f8    DYNAMIC     Te1/1/8
111    4488.165b.db3f    DYNAMIC     Te1/1/8
111    4488.165b.e21f    DYNAMIC     Te1/1/8
111    5405.db73.dc08    STATIC      Tw1/0/17 
111    5405.dbce.279b    STATIC      Tw1/0/1 
111    8c8c.aa3d.38ea    DYNAMIC     Te1/1/8
111    a029.1992.b989    DYNAMIC     Te1/1/8
111    a0ce.c8ef.49ba    DYNAMIC     Drop
has context menu
```
**Show all MAC addresses on a port**

```
cisco9300#sh mac address-table interface gigabitEthernet1/0/22
          Mac Address Table
-------------------------------------------

Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
 423    0892.04b5.fb46    DYNAMIC     Gi1/0/22
Total Mac Addresses for this criterion: 1
```

Possible types of MAC

- Dynamic
- Static

Possible Ports values

- CPU - mac-address is assigned by CPU and is an internal allocation for some internal process. Every switch has a pool of mac-addreses for internal allocation for its processes.For example, for STP process, VTP process, switch assings the internal mac-addresses
- Port number
- Drop - port drops traffic due to security violations, for example if port security is configured, or 802.1X

**Show 802.1X port status**

```
Device# show dot1x interface fastethernet7/1 details

Dot1x Info for FastEthernet7/1
-----------------------------------
PAE                       = AUTHENTICATOR
PortControl               = AUTO
ControlDirection          = Both 
HostMode                  = SINGLE_HOST
ReAuthentication          = Disabled
QuietPeriod               = 60
ServerTimeout             = 30
SuppTimeout               = 30
ReAuthPeriod              = 3600 (Locally configured)
ReAuthMax                 = 2
MaxReq                    = 2
TxPeriod                  = 30
RateLimitPeriod           = 0
Dot1x Authenticator Client List
-------------------------------
Supplicant                = 1000.0000.2e00
        Auth SM State     = AUTHENTICATED
        Auth BEND SM Stat = IDLE
Port Status               = AUTHORIZED
          
Authentication Method     = Dot1x
Authorized By             = Authentication Server
Vlan Policy               = N/A
```
**Show all ARPs**

```
cisco9300#show ip arp            
Protocol  Address          Age (min)  Hardware Addr   Type   Interface
Internet  10.0.3.1              211   6c41.0ead.2bc4  ARPA   Vlan19
Internet  10.0.3.165              -   4ce1.75e8.31c4  ARPA   Vlan19
```
## Interfaces

Show all ports status
```
cisco9300#show ip int br
Interface              IP-Address      OK? Method Status                Protocol
Vlan836                10.2.136.110    YES manual up                    up      
GigabitEthernet0/0     unassigned      YES NVRAM  down                  down
```

Show brief status of the interface
```
cisco9300#show int gi1/0/22 status

Port         Name               Status       Vlan       Duplex  Speed Type
Gi1/0/22     d.bandaletov_NAC   connected    423        a-full a-1000 10/100/1000BaseTX
```

Show description of all interfaces to understand what goes where

```
show int description
```



## IOS VS ASA

## Wildcard masks

- Wildcard - uknown or unpredictable factor - a symbol which represents one or more unspecified characters
- It is a 32 bit binary number
- Inverted subnet mask
- A wild card mask is a matching rule
- Wildcard masks are used in situations where subnet masks may not apply. For example, when two affected hosts fall in different subnets, the use of a wildcard mask will group them together
- For example in access list we can use access-list 1 permit 10.168.1.0 255.0.0.255 - it will match address from different networks: 192.168.1.3 and 10.168.1.4!
- Subnet Masks can only identify sequential IP addresses. Wildcard Masks, however, can identify IP addresses which are not sequential
- Directs the router’s logic bit by bit
- Bit of 0 means the comparison should be done as normal
- Binary 1 means that the bit is a wildcard and can be ignored when comparing the numbers
- All bits which are zero in WC should match in bith comparing numbers!
- To match a range of addresses
- Shows wich octets and bits to consider and which to ignore
- Used in access lists, OSPF network command, EIGRP network command
- Decimal 0: The router must compare this octet as normal.
- Decimal 255: The router ignores this octet, considering it to already match
- 0.0.0.255 - ignore last octet - 10.1.2.0 matches 10.1.2.1
- 0.0.255.255 - ignore last two octets
- 0.255.255.255 - ignore last three octets
- access-list 1 permit 10.1.1.1 - match exactly one address
- access-list 1 deny 10.1.1.0 0.0.0.255 - match everything starting with 10.1.1.
- access-list 1 permit 10.0.0.0 0.255.255.255 - match everything starting from 10
- Convert subnet mask to WC: 255.255.255.255 - 255.255.252.0 = 0. 0. 3.255 - wildcard mask!

## IPSec

Debug

```
Debug crypto condition peer ipv4 140.238.149.242
Debug crypto ikev2
Debug crypto ipsec
```

## Service commands

```
service nagle
```

The Nagle congestion-control algorithm to improve the performance of their Telnet sessions to and from the router. When using a standard TCP implementation to send keystrokes between machines, TCP tends to send one packet for each keystroke typed. John Nagle's algorithm (RFC 896) helps alleviate the small-packet problem in TCP. In general, it works this way: The first character typed after connection establishment is sent in a single packet, but TCP holds any additional characters typed until the receiver acknowledges the previous packet. The second, larger packet is sent, and additional typed characters are saved until the acknowledgment comes back. The effect is to accumulate characters into larger chunks and pace them out to the network at a rate matching the round-trip time of the given connection. This method is usually good for all TCP-based traffic and helps when connectivity to the router is poor or congested or the router itself is busier than normal. Without service nagle on a Cisco router, each character in a Telnet session is a separate CPU interrupt. Hence, a command such as show tech will force a large number of CPU interrupts, impacting the performance of the router. From a Cisco point of view, the Nagle service not only helps to optimize the Telnet session but also lessens the load on the router

```
Router1(config)# service tcp-keepalives-in
Router1(config)# service tcp-keepalives-out
```

This enables TCP keep-alives for inbound and outbound traffic. This helps to drop the session if one peer is rebooted for example.
