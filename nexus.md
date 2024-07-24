# Nexus

## Show commands

### Hardware

Show BGP connections for all VRFs  
`show ip bgp summary vrf all`

Show hardware health  
`show environment`

Show all parts with serial numbers  
`show inventory`

```
show interfaces status err-disabled
show interfaces status | i connected
show module
show rendancy status
show cdp neighbors
```

`show boot mode`
Boot Mode Types: Cisco Nexus switches can boot from different sources such as a specific boot image file (bootflash:), a boot loader (loader:), or even from a remote location via TFTP (tftp:) or a network server (dhcp:).  
Native Boot: When you see "native" in the output of the "show boot mode" command, it indicates that the switch is set to boot from its default or primary boot location. This is often bootflash: by default, which refers to the onboard flash memory where the operating system image is stored.  
Other Options: Apart from "native," the output might also list other configured boot options if they have been defined. These could include specific files or directories where boot images are stored, such as bootflash:filename or bootflash:/directory/filename, depending on how the boot variables are configured.

## Upgrade

8 Steps

- Upload image
- Backup
- Pre-checks
- Implementation
- Reboot
- Verification - should match pre-checks
- Backout
- Backout verification

```
Backup
while session logging
#copy run start
#term len 0
#show run


Pre-checks
Check MD5
Check device status
show cdp neigh
show int status
show ver
Show mac add | i count
show mac add
Sh port-channel summary
show spann summary
show spann root
show module
Show feature
show env
Show boot

Check upgrade impact
show install all impact nxos bootflash:n3000-compact.9.3.12.bin

Install all nxos bootflash:n3000-compact.9.3.12.bin
If able, do a show boot to confirm boot image before reloading box

show install all status

```
