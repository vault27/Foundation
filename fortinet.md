# Fortinet

## Hardware

- General name for additional processors: SPU - security processor unit
- CP - content processor - AV, attack detection, encryption, decryption,  - CP4,5,6,8,9
- SP - Security processor - IPS - syn proxy,  Attack signature matching, flow based web filtering
- NP - network processor - traffic
- Because the NP6 processors are not connected, care must be taken with network design to make sure that all traffic to be offloaded enters and exits the FortiGate through interfaces connected to the same NP6 processor

Show info about CP and NP processors

```
get hardware status
```

Show which port serves which port

```
get hardware npu np6 port-list
```

You can view the status of SSL acceleration using the following command:

```
get vpn status ssl hw-acceleration-status
```
Acceleration hardware detected: kxp=on cipher=on  
Where kxp means key exchange acceleration.

You can display information about installed SP modules using the CLI command

```
diagnose npu spm
```

## 2 factor auth via email

- System > Messaging > SMTP servers
- Import Google Intermediate and root certs
- https://kb.fortinet.com/kb/documentLink.do?externalID=FD40548
- Allow third party apps in Google Account
- SMTP servers config:
    - name: gmail
    - Server name: smtp.gmail.com
    - port: 587
    - sender email address: user@gmail.com
    - STARTTLS
    - Account username: user@gmail.com
    - Password
- Authentication > User Management > Local users > Create user, allow tokens, choose email and add email address
- Authentication >  Radius service > Clients, Policies

## Routing

- Distance - fortigate defines distance for different types of routes, static has one distance, BGP another.... - applies both to dynamic and static routes, it is nedded when the same route arrives from different routing protocols. The less the better
- Metric - each routing protocol makes it own metric, for example RIP based on amount of hops - applies only to dynamic routes, the lower the better
- Priority - can be configured only for static routes

**Diagnose**

```
get router info routing-table all - only active routes
get router info routing-table database - both active and inactive routes
get router info ospf neighbor
get router info bgp neighbor
get router info bgp summary
```

**Show all routes even secondary ones with priorities:**

```
diagnose ip route list
```

If two routes have the same administrative distance and the same priority, then they are equal-cost multi-path (ECMP) routes.  
Load balancing can be set to weighted, higher weights are more likely to be selected.

**RPF**

- Protects against IP spoofing attacks.
- The source IP address is checked against the routing table for a return path.
- RPF is only carried out on:
- The first packet in the session, not on a reply.
- The next packet in the original direction after a route change, not on a reply.
- Two methods:
    - Loose
    - Strict

```
config system setting
set strict-src-check [ disable | enable ]
end
```

- strict-src-check disable – Loose RPF (default)
- Checks only for the existence of at least one active route back to the source using the incoming interface
- strict-src-check enable – Strict RPF
- Checks that the best route back to the source uses the incoming interface
- Two ways to disable RPF checking
- Enable asymmetric routing, which disables RPF checking system wide
- Disable RPF checking at the interface level
- Reduces security! Not recommended!
- `Disable RPF = IPS and Antivirus will not work`

```
config system interface
edit <interface>
set src-check [ enable | disable ]
end
```

## Kerberos

Working config

- Users go to explixit proxy proxy.test.ru
- Domain name test.ru
- All users have UPN user@test.ru

```
config user ldap
    edit "test.ru"
        set server "test.test.ru"
        set cnid "sAMAccountName"
        set dn "DC=test,DC=ru"
        set type regular
        set username "CN=FortiGate AD Read Service User,OU=Fortinet,OU=NOT-OFFICE,DC=test,DC=ru"
        set password ENC MTAwNKi3BPCM6MB3FrNc5OEY37C9Aaci/WtqdL7h0FxPk0X8B0EzgZbim35cGRmNg5G6lJKDRNOWTtcUFuxuS5aAM7rmrxdSZtsMpIQVhvGaJZ94fsmipMdIryhKUSKO+MYc66Y/FsS1MCTxDoadKzBD8Ibh31uSOW6KF2IZkuCHgbWLxyC3FXSQSZdJcfH/Viy1RA==
        set account-key-processing strip
        set account-key-filter "(&(sAMAccountName=%s)(!(UserAccountControl:1.2.840.113556.1.4.803:=2)))"
    next
end
config user krb-keytab
    edit "http_service"
        set pac-data disable
        set principal "HTTP/proxy.test.ru@test.RU"
        set ldap-server "test.ru"
        set keytab "ENC vpCsR8hkDI7BtdsMrHPFunsy15zRCFy5gDzTWy/cu1kwwFVLhskx+eQ967OVTgpejlvFHsy4vgnUzrLcpk73rO1ZDgZiFb1lMm7APVqWoNhHoQg5lNGnj739munEL7Mr/PMMt0ltW/27OR04yW0fViUf+NTIm5w4/8PzejWvAXq/3KabixH1HpuOqzKCjFrD1wX5F3H5XJyKEvHDQ0yNn22ruwvd9L1VLslc9I8p4qna8tI8oCpka8sbLKJiYQai+J3T9oO+e3/v23BiAR4Lm6zh2F19BBlTjVF6gwe69dyaNpNDO20Gb5gu81RcWq8mB8/GWBvrRTTFaueMXrN4xC7umTBQbhgLeHvIQUQww1+rW4XLOpah0l6Cb/AVSl0Zf3E+Dn2erMD6+hBgCTHa0nYnAFep0bb/TFUmUjXFf0pTUWF336X/t0FnHmb9QV4a18sfoLJbIH3iC1u7HyCNLn9smjZwPq89XNxZpOMy6ojB0DediVumcaTFLY1glNjeYP8HshiKXWKgRSzoB1kPm1SkEiqEElWMF9i401f8L9T7wutJsnvjPBsBRnx5OI9bKRLmngJSaCYubPmaAOBGlAsCs5cil103nha42oiZscD/jVp30RXRxgvv9/LX0pQxUAXoCu7K47k8XUuLRvL8+zmPFQNk8WS5Hl6T0irHiCEztOVILq0QXUqxypnJEAonhZZlsVdsgsoJqeU2hfSSlMLRf3DdVgpZac7PjvkgEsLhbWTSeDOeOhnznXf089te26/tyw=="
        set password ENC qmTI2Rofd1nAOQR9mxfwrn5GZVrvVSMljyCAKbct+9XrMHtGAxFGIBQlo7x7gQHgK+WPaSJMvlsWN3cluibrS0uNeD+0zy58dx5LIHl76LS4OeZGRRkfCTXmO9BkUsPZyGGdYIL9WWoh4Ycmkxq4cZ2sAfWyC7/F11q+YX4FXb04t0aGThU2U6oqBva6zAuLrANSyw==
    next


config user group
    edit "SSO_Guest_Users"
    next
    edit "HTTP Users"
        set member "test.ru"
        config match
            edit 1
                set server-name "test.ru"
                set group-name "CN=HTTP Internet Users,OU=Internet,OU=GROUP,DC=test,DC=ru"
            next
            edit 2
                set server-name "test.ru"
                set group-name "CN=HTTP users (Full Access),OU=Internet,OU=GROUP,DC=test,DC=ru"
            next
            edit 3
                set server-name "test.ru"
                set group-name "CN=Fortigate Access,OU=AccessGroups,OU=GROUP,DC=test,DC=ru"
            next
        end
    next
    edit "Ldap-Group"
        set member "test.ru"
    next
end

config firewall proxy-policy
edit 12
        set uuid 1674d708-1a58-51ea-10d1-ac3c0395f624
        set proxy explicit-web
        set dstintf "Bond3"
        set srcaddr "all"
        set dstaddr "all"
        set service "webproxy"
        set action accept
        set schedule "always"
        set logtraffic all
        set groups "Ldap-Group"
        set utm-status enable
        set ssl-ssh-profile "test-ssl"
        set av-profile "default"
        set ips-sensor "high_security"
        set application-list "default"
        set comments "Full Access for HTTP users"
    next


ktpass -princ HTTP/proxy.test.ru@TEST.RU -mapuser rnd-proxy -pass <password> -crypto all -ptype KRB5_NT_PRINCIPAL -out C:\Users\Admin_RK\Desktop\msk_fgt.keytab
```

## Sessions

You can see only sessions, which are not accelerated.

TCP default TTL

```
config system session-ttl
set default 3600
end
```

Viewing sessions

```
diagnose sys session ?
```

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
- Policy based - no profiles except Antivirus and IPS, one SSL/SSH decryption policy for all rules
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
