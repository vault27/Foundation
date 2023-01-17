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

##CSR
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


## IOS VS ASA
