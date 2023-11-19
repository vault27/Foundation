# Fortinet

## NAT

- Firewall policy NAT - for small amount of IP addreses
    - SNAT and DNAT are configured inside policy
    - SNAT uses outgoing interface IP
    - DNAT uses VIP as destination address
- Central NAT
    - SNAT and DNAT per VDOM
    - SNAT in central SNAT policy

### Firewall Policy SNAT

- Two options: outgoing interface address or IP pool
- IP pools should be the same subnet as External IP of Fortigate, unless proper routing is configured
- IP pools type:
    - Overload
    - One to one
    - Fixed port range - good for CGN
    - Port block allocation - good for CGN
- IP Pool type - Fixed port range - 200 internal addresses are assigned to 10 external addresses - used in CGN environments - Carrier Grade NAT - you configure external IPs and Internal IPs
- Then using this pool you can identify which external address and which ports range on it is attched to particular internal address, and you do not need to log all traffic that then understand which particluar clientgenerated a traffic, you can just know it based on external IP and port. For example: 10 external IPs are shared by 253 internal hosts
- If static pool NAT is used and all addresses are occupied, then traffic is droped
- IP pool Type - Port Block Allocation - you define external IPs and block size - how many ports

Show block size and number of blocks for IP pool + find out which Internal IP is behind particular external IP + Port

```
# diagnose firewall ippool list
list ippool info: (v£=root)
Check block size and number of blocks for IP pool
ippool cgnat-pba-pooll: id=1, block-sz=2323, num-block=1,
fixed-port=no, use=2
natip-range=70.70.70.71-70.70.70.80 start-port=5117, num-pba-per-ip=26
source ip-range=10.0.1.1-10.0.1.253 deterministic NAT
clients=0, inuse-NAT-IPs=0
total-PBAs=260, inuse-PBAs=0, expiring-PBAs=0, free-PBAs=100.00%
allocate-PBA-times=0, reuse-PBA-times=0

# diagnose firewall ippool-fixed-range list natip 70.70.70.71
ippool name=cgnat-pba-pool1, ip shared num=26, port num=2323
internal ip=10.0.1.1, nat ip=70.70.70.71, range=5117~7439 
internal ip=10.0.1.2, nat ip=70.70.70.71, range=7440~9762
internal ip=10.0.1.26, nat ip=70.70.70.71, range= 63192~65514

# diagnose firewall ippool-fixed-range list natip 70.70.70.71 5900
ippool name=cgnat-pba-pool1, ip shared num=26, port num=2323
internal ip=10.0.1.1, nat ip=70.70.70.71, range=5117~7439
```

## VIPs

- Static DNAT by default - all protocols
- If Internal host goes outside - SNAT is used from VIP - if no port forwarding and if VIP has a rule and enabled
- Port forwarding is available
- VIP provides ARP replies
- Special rules for it in policy - firewall objects do not match VIPs - to override it we can add option "set match-vip enable" in the policy which we want to influence the VIPs

## Central NAT

- Disabled by default
- Enabled in GUI or CLI
- Central SNAT + DNAT and virtual IPs 
- VIPs should be removed from policy before enabling
- Central SNAT is mandatory NGFW policy-based mode
- All SNATs are in separeate section - possible options: incoming interface, outgoing interface, source address, destination address, protocol, explicit port mapping
- Rules are evaluated from top to bottom, once match, stop processing
- VIPs in separate section as well, appropriate firewall rule should be configured
- DNAT takes place before firewall policy, so in a firewall rule you use internal IP
- Options for DNAT: interface, external IP, internal IP, Port Forwarding

## Application control

- Database for Application Control signatures is separate from the IPS database
- Access to the database no longer requires a FortiGuard IPS subscription
- Updates for the Application Control signature database requer a valid FortiCare support contract

## Inspection modes

If a FortiGate or VDOM is configured for proxy-based inspection, then a mixture of flow-based and proxy-based inspection occurs. Traffic initially encounters the IPS engine, which applies single-pass IPS, Application Control, and CASI, if configured in the firewall policy accepting the traffic. The traffic is then sent for proxy-based inspection. Proxy-based inspection extracts and caches content, such as files and web pages, from a content session and inspects the cached content for threats.  
Inspection mode is configured per rule.

### Proxy mode

Content inspection takes place in the following order: VoIP inspection, DLP, AntiSpam, Web Filtering, AntiVirus, and ICAP. If no threat is found, the proxy relays the content to its destination. If a threat is found, the proxy can block the threat and send a replacement message in its stead. The proxy can also block VoIP traffic that contains threats.  
2 TCP connections

### Flow mode

Flow-based inspection can apply IPS, Application Control, Web Filtering, DLP, and AntiVirus. Flow-based inspection is all done by the IPS engine and, as you would expect, no proxying is involved.  
All of the applicable flow-based security modules are applied simultaneously in one single pass, and pattern matching is offloaded and accelerated by CP8 or CP9 processors. IPS, Application Control, flow-based Web Filtering, and flow-based DLP filtering happen together. Flow-based AntiVirus scanning caches files during protocol decoding and submits cached files for virus scanning while the other matching is carried out.  
Flow-based inspection typically requires fewer processing resources than proxy-based inspection and does not change packets, unless a threat is found and packets are blocked. Flow-based inspection cannot apply as many features as proxy inspection. For example, flow-based inspection does not support client comforting and some aspects of replacement messages.

## NGFW modes

- Policy based - available only in Flow mode
- The NGFW mode is set per VDOM
- Policy based - no profiles except Antivirus, one SSL/SSH decryption policy for all rules
- Policy based - default-app-port-as-service option
- Policy-based - Requires the use of central SNAT
- Policy-based - in a rule you select an app, group or category
- Profile based
- System > Settings > NGFW Mode

## Grep

```
gate1 # show | grep -h
Usage: grep [-invfcABC] PATTERN
Options:
        -i      Ignore case distinctions
        -n      Print line number with output lines
        -v      Select non-matching lines
        -f      Print fortinet config context
        -c      Only print count of matching lines
        -A      Print NUM lines of trailing context
        -B      Print NUM lines of leading context
        -C      Print NUM lines of output context
```

-f flag which prints the config context which shows us where exactly in config the values are found

```
gate1 # show | grep -f ssl-token
config user local
    edit "ssl-token" <---
        set type password
        set two-factor fortitoken
        set email-to "amouawad@ingramlabs.com.au"
        set passwd ENC encodedpasswordz
    next
end
config user group
    edit "Full SSL Access"
        set member "authenticator-radius" "ssl-sms" "ssl-token" "imadmin" <---
    next
end
```

Doing the same search with the -i flag will ignore all cases 

```
gate1 # show | grep -i -f "full ssl access"
config user group
    edit "Full SSL Access" <---
        set member "authenticator-radius" "ssl-sms" "ssl-token" "imadmin"
    next
end
```

OR operator by \|

```
gate1 (global) # get | grep 'admin-lockout\|admintimeout'
admin-lockout-duration: 60
admin-lockout-threshold: 3
admintimeout        : 480
```

AND operator by a fullstop without quotation marks

```
ate1 (global) # get | grep admin.ssh
admin-ssh-grace-time: 120
admin-ssh-password  : enable
admin-ssh-port      : 22
admin-ssh-v1        : disable
```

## ICAP

```
edit "test-icap-vdlp"
set replacemsg-group ''
set request enable
set response disable
set streaming-content-bypass enable
set preview disable
set request-server "test-icap-vdlp"
set request-failure bypass
set request-path "dlpsymantec"
set methods post
config icap-headers
edit 1
set name "X-Authenticated-User"
set content "$user"
set base64-encoding enable
next
edit 2
set name "X-Authenticated-Groups"
set content "$local_grp"
set base64-encoding enable
```

## Migration

- Port based VIPS - service should be any
- Source nat rules should point to INET only
- Ping to every vip
- Plus explicit ping for all vips
- ping to source nat rules
- VIP are connected to Device and interface - disable
- Same interface names
- the same VLANs for vdoms
- VIP intersection during policy install