# Cisco

## IOS
- Monolithic operating system running directly on the hardware
- Replaced with Cisco IOS XE

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
Show all MAC addresses on a port
```
cisco9300#sh mac address-table interface gigabitEthernet1/0/22
          Mac Address Table
-------------------------------------------

Vlan    Mac Address       Type        Ports
----    -----------       --------    -----
 423    0892.04b5.fb46    DYNAMIC     Gi1/0/22
Total Mac Addresses for this criterion: 1
```

Show all ARPs
```
cisco9300#show ip arp            
Protocol  Address          Age (min)  Hardware Addr   Type   Interface
Internet  10.0.3.1              211   6c41.0ead.2bc4  ARPA   Vlan19
Internet  10.0.3.165              -   4ce1.75e8.31c4  ARPA   Vlan19
```

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





## IOS VS ASA
