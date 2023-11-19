Mass add interfaces and routes
Be careful, it may not proceed last csv string and it may generate errors so first turn on Putty logging to check for errors

```
#! /bin/bash
#set -x

while read line
do
        ip=`echo $line | cut -d ";" -f 2`
        VLAN=`echo $line | cut -d ";" -f 1`
        comment=`echo $line | cut -d ";" -f 3`
        comment2="echo \"$comment\""

        echo "edit bond2.${VLAN}" >> GW1
        echo "set vdom External" >> GW1
        echo "set ip ${ip}" >> GW1
        echo "set interface bond2" >> GW1
        echo "set vlanid ${VLAN}" >> GW1
        echo "set allowaccess ping" >> GW1
#       echo set description \"$comment\" >> GW1
        echo "next" >> GW1

done < interfaces.csv
```

---
Routes via 1 gateway

```
#! /bin/bash
#set -x

while read line
do
        echo "edit 0" >> routes.txt
        echo "set dst $line" >> routes.txt
        echo "set gateway 10.127.255.44" >> routes.txt
        echo "set device bond2.148" >> routes.txt
        echo "next" >> routes.txt
done < routes.csv
```


---
Add ICMP services


```
#! /bin/bash
#set -x

rm icmp.conf

while read line

do
        name=`echo $line | cut -d ";" -f 1`
        type=`echo $line | cut -d ";" -f 2`
        code=`echo $line | cut -d ";" -f 3`

        echo "edit '$name'" >> icmp.conf
        echo "set protocol ICMP" >> icmp.conf
        echo "set icmptype $type" >> icmp.conf
        echo $code >> codes
        if [ ! -z "$code" ]; then
        echo "set icmpcode $code" >> icmp.conf
        fi

        echo "next" >> icmp.conf

done < ICMP.csv

cat icmp.conf
```

---
Add IP services


```
#! /bin/bash
#set -x

rm ip.conf

while read line

do
        name=`echo $line | cut -d ";" -f 1`
        number=`echo $line | cut -d ";" -f 2`

        echo "edit '$name'" >> ip.conf
        echo "set protocol IP" >> ip.conf
        echo "set protocol-number $number" >> ip.conf
        echo "next" >> ip.conf

done < IP.csv

cat ip.conf
```

---
Add TCP services

```
#! /bin/bash
#set -x

rm tcp.conf

while read line

do
        name=`echo $line | cut -d ";" -f 1`
        port1=`echo $line | cut -d ";" -f 2`
        port2=`echo $line | cut -d ";" -f 3`

        echo "edit '$name'" >> tcp.conf
        echo "set protocol TCP/UDP/SCTP" >> tcp.conf
        if [ ! -z "$port2" ]; then
        echo "set tcp-portrange $port1-$port2" >> tcp.conf
        else
        echo "set tcp-portrange $port1" >> tcp.conf
        fi
        echo "next" >> tcp.conf

done < TCP.csv

cat tcp.conf
```

---
Add UDP services

```
#! /bin/bash
#set -x

rm udp.conf

while read line

do
        name=`echo $line | cut -d ";" -f 1`
        port1=`echo $line | cut -d ";" -f 2`
        port2=`echo $line | cut -d ";" -f 3`

        echo "edit '$name'" >> udp.conf
        echo "set protocol TCP/UDP/SCTP" >> udp.conf
        if [ ! -z "$port2" ]; then
        echo "set udp-portrange $port1-$port2" >> udp.conf
        else
        echo "set udp-portrange $port1" >> udp.conf
        fi
        echo "next" >> udp.conf

done < UDP.csv

cat udp.conf
```