# Wireshark

Search text in whole frame

```text
frame contains text
```

Search HTTP replies on certain request

```text
http.response_for.uri == "http://secure.eicar.org/eicar.com.txt"
```

## Tshark

Show only dst IP addressess for request from particular IP to https sites

```
tshark -T fields -e ip.dst -f "tcp and dst port 443 and src 10.10.10.1"
```