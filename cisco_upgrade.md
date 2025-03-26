# Cisco upgrade

## Part 1 - Reconnaissance

- What is connected to a device: clients, cameras, servers, APs, transit: CDP, port description, diagrams
- Who support connected devices?
- Maitenance window
- Validators - they have to approve before and after
- Will there be service interraption or not?
- Impact allowed: can we do interruption or not
- Find out the rack number
- Find person on site availability - console cable + wired keyboard with Break key + console passwords
- Person on site requested access

## Part 2 - Change creation

- Notify on-site people
- Notify servers people
- Notify validators: application teams, security guards - send them Bridge link
- Create MOP
- Pass TAB
- Pass SCRUM

## Part 3 - Prepare for change

- Local password + password for console
- Local access
- vPC and STP peculiarities
- Routing protocols
- Upload images + MD5 + stack
- Wireless controllers - check before upgrade
- Stack or not

## Part 4 - Change

- Disable monitoring system
- Notify about start
- Validators validate before start
- Install + Verify

## Part5 - Post Upgrade

- Pre-checks
- If Stack: check that member switches are upgraded as well
- Access-points
- Cameras
- Security locks
- Servers connections
- Servers validators
- App validators
- Notify about end
- Close change
- Unmute monitoring system
- Add change to monitoring system

## Upload image

- For Catalyst via FTP: `copy /verify ftp://ftpuser:pass@1.1.1.1/IOS/c3560cx-universalk9-mz.152-7.E9.bin flash:`
- For Nexus via SFTP: `copy sftp://user.scp@2.2.2.2/Images/nxos64-cs.10.2.6.M.bin bootflash:`
- Veriify MD5 hash `verify /md5 flash:c3750e-universalk9-mz.152-4.E10.bin`
- Verify MD5 on Nexus `show file bootflash:nxos64-cs.10.2.6.M.bin md5sum`
- Upload image to main switch in stack `copy /verify scp://sw.scp:Canyon+paint1@10.2.53.13:c2960x-universalk9-mz.152-7.E11.bin flash:`
- Upload image to second switch in stack `copy flash:c2960x-universalk9-mz.152-7.E11 flash2:`
- Verify that image is on both nodes of the stack.
    - "flash:" means the flash directory of the MASTER switch.
    - "flash1:" means the flash directory of switch 1 of the stack.
    - "flash1:" does NOT necessarily mean it's the flash memory of the master switch.
```
Show flash1:
Show flash2:
```

## Backup

- Enable SSH log to file

```
copy run start
ter len 0
sh run
```

## Hardware Pre-checks

- Enable SSH log to file

```
show environment all - fans, ps, alerts, sensors
show interfaces status err-disabled
show interfaces status | i connected
show power inline - power over ethernet ports
show inventory - slots, sfps, power supplies, fans
show module - OS versions on all slots, MAC addresses 
show switch - shows members of a stack + who is Master - only for stack
show redundancy - Chassis-based switches with dual supervisor modules (e.g., Catalyst 9400, 9500, 9600), StackWise Virtual configurations (e.g., Catalyst 9300, 9500), Routers that support redundant RPs (e.g., ASR, ISR series)
show cdp nei
```

## Software Pre-checks

```
show logging
show ver - verify version on all switches in the stack
```

## L2 Pre-checks - for switches only

```
show mac add dynamic
show int trunk
show spanning-tree summary
show spanning-tree root
```

## L3 Pre-checks

General

```
show vrf
show ip protocols
show ip arp
show ip route
show ip route summary
```

For VRFs with Interfaces

```
show ip arp vrf VRF_NAME
show ip route vrf VRF_NAME
show ip route vrf VRF_NAME summary
```

OSPF 

```
show ip ospf neighbor
show ip ospf database
show ip ospf interface
```

BGP

```
show ip bgp all summary
```

## Nexus Pre-checks

```
show install all impact nxos bootflash:nxos64-cs.10.2.6.M.bin
show feature
show install all status
```

## Install

- Check version one more time, that it is correct
- Identify if it is old Catalyst (IOS) or new one (IOS-XE): `show version | include IOS`

### Old Catalyst

- Example: Catalyst 9000 Series (9200, 9300, 9500, etc.)
- Non IOS-XE
- If `show boot` shows bin file
- Keeping the old image as a backup is a good practice

```
no boot system boot system flash:c2900-universalk9-mz.SPA.157-3.M4a.bin
boot system flash:c2900-universalk9-mz.SPA.157-3.M8.bin
boot system boot system flash:c2900-universalk9-mz.SPA.157-3.M4a.bin
exit
copy run start
reload
```

Stack: `boot system switch all flash:c3750e-universalk9-mz.152-4.E10.bin`

### New Catalyst

- IOS-XE
- Example: Catalyst 9000 Series (9200, 9300, 9500, etc.)
- They use a package-based "install mode" instead of direct .bin boot
- `install add file flash:cat9k_iosxe.17.09.04a.SPA.bin activate commit prompt-level none`
- Explanation:
- install add file → Adds the new image to the system.
- activate → Makes the new image the active one.
- commit → Removes the old image to free up space.
- prompt-level none → Prevents confirmation prompts.

### Nexus

```
Install all nxos bootflash:nxos64-cs.10.2.6.M.bin
```

### Troubleshooting

If switch does not boot with new image, we need to connect with console and load switch with previous image:

```
Enter ROMMODE - CTRl+Break
boot flash:IMAGE_NAME
if flash is not detected, then you can try flash_init
you can do "dir" to see if flash is detected
if it doesn't boot on the new code, it'll automatically go to rommon
```

