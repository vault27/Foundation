# Nexus

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
