<img width="732" alt="image" src="https://user-images.githubusercontent.com/116812447/206652079-dd92c5da-ee2c-43a0-ad49-a9d890cd52d5.png">

https://www.juniper.net/assets/us/en/local/pdf/books/day-one-poster-vpns.pdf

## Overlay Tunnels

- Overlay network - virtual or logical network above transport (underlay) network
- IPSec
- LISP
- VXLAN
- MPLS
- VPN - overlay network which allows private networks to commincate via untrusted network
- Overlay tunnel can be built over another overlay - MPLS over GRE over IPSec

Next generation overlay fabric technologies:

- SD-WAN
- SD-Access
- ACI
- VTS

## L2 provider VPNs
- IEEE 802.1Q Tunneling (QinQ) and L2PT
- VPLS
- VxLAN

## GRE

- GRE uses IP code 47, no TCP or UDP is used, it is injected directly above IP

```
Router(config)#interface tunnel1
Router(config-if)#ip address 192.168.0.1 255.255.255.0
Router(config-if)#tunnel source 1.1.1.1
Router(config-if)#tunnel destination 1.1.1.2
```

- Often as source and destination Loopback interface is used.
- As it is a logical interface it will never go down
- If the tunnel device has multiple uplinks the loopback interface will remain reachable, even if one of these links goes down
- Recursive routing - happens when the tunnel’s destination IP (the underlay endpoint) is reachable through the tunnel itself — creating a loop

