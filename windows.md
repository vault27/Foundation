# Windows

## CLI

**Add static route**

```
route -p add 192.168.35.0 MASK 255.255.255.0 192.168.0.2
```

**Finding All Hosts On the LAN**

```
for /L %I in (1,1,254) DO ping -w 30 -n1 192.168.1.%I | find "Reply"
```

**Identify DN of a username on AD**

```
dsquery user -name administrator
```

**Identify DN of a group name**

```
dsquery group -samid "L-MSK-KLTN-ACC-Internet-Audio"
```

**Show all users in a group**

```
dsget group "CN=GroupName,DC=domain,DC=name,DC=com" -members

net group /domain DP_APP_Access
```

**Show list of domain controllers**

```
dsquery -server x5.ru
```

**Show proxy configuration**

```
netsh winhttp show proxy
```

**Show everything about current user**

```
whoami /all
```

**Show group info**

```
net user joe.doe /domain | findstr /i "juniper"
```
