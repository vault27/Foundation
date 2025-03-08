# DNS

- Invented in 1983.
- No security inside.
- 253 symbols max in Domain.
- Dot on the end is not mandatory - depends on parser

## Attacks

- Zero-day
- Cache poisoning
- Distributed Denial of Service (DDoS)
- DNS amplification
- Fast-flux DNS
- DNS tunneling

## Protection for channel between clients and resolvers

- DNS curve - authentication on DNS servers, traffic is encrypted - not used
- DNSsec - very difficult to support
- DNScrypt - technology is dead
- DNS over HTTPS Google API - send request and get JSON reply
- DNS Over TLS - TLS over port 853, regular DNS inside
- DNS over DTLS
- DNS over HTTP/2
- DNS over Quic

Protection between resolvers and authorative servers does not exist