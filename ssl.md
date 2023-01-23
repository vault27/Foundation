# SSL

## Protocols  
- SSLv1(out of date, vulnerable)
- SSLv2(do not use)
- SSLv3(do not use)
- TLS 1.0(deprecated, many attacks, PCI DSS prohibited)
- TLS 1.1
- TLS 1.2 - is the best option for now
- TLS 1.3

## TLS Hello
583 bytes  
A lot of extensions and fields:
```
Handshake Protocol: Client Hello
    Handshake Type: Client Hello (1)
    Length: 508
    Version: TLS 1.2 (0x0303)
    Random: c980be07b33ea29eb4f92d274d366a9bcc00fa70957336a16f050c136fc778e2
    Session ID Length: 32
    Session ID: b144d555d1ccdc1453a3950601fe1b165bb40c94a7522cebcbb8f480c02c5a10
    Cipher Suites Length: 42
    Cipher Suites (21 suites)
    Compression Methods Length: 1
    Compression Methods (1 method)
    Extensions Length: 393
    Extension: Reserved (GREASE) (len=0)
    Extension: server_name (len=13)
    Extension: extended_master_secret (len=0)
    Extension: renegotiation_info (len=1)
    Extension: supported_groups (len=12)
    Extension: ec_point_formats (len=2)
    Extension: application_layer_protocol_negotiation (len=14)
    Extension: status_request (len=5)
    Extension: signature_algorithms (len=24)
    Extension: signed_certificate_timestamp (len=0)
    Extension: key_share (len=43)
    Extension: psk_key_exchange_modes (len=2)
    Extension: supported_versions (len=11)
    Extension: compress_certificate (len=3)
    Extension: Reserved (GREASE) (len=1)
    Extension: padding (len=198)
    [JA3 Fullstring: 771,4865-4866-4867-49196-49195-52393-49200-49199-52392-49162-49161-49172-49171-157-156-53-47-49160-49170-10,0-23-65281-10-11-16-5-13-18-51-45-43-27-21,29-23-24-25,0]
    [JA3: 773906b0efdefa24a7f2b8eb6985bf37]
```
Cipher suites are particular important, every suite has its own code
```
Cipher Suites (21 suites)
    Cipher Suite: Reserved (GREASE) (0xfafa)
    Cipher Suite: TLS_AES_128_GCM_SHA256 (0x1301)
    Cipher Suite: TLS_AES_256_GCM_SHA384 (0x1302)
    Cipher Suite: TLS_CHACHA20_POLY1305_SHA256 (0x1303)
    Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (0xc02c)
    Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (0xc02b)
    Cipher Suite: TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256 (0xcca9)
    Cipher Suite: TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (0xc030)
    Cipher Suite: TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (0xc02f)
    Cipher Suite: TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (0xcca8)
    Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA (0xc00a)
    Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA (0xc009)
    Cipher Suite: TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (0xc014)
    Cipher Suite: TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (0xc013)
    Cipher Suite: TLS_RSA_WITH_AES_256_GCM_SHA384 (0x009d)
    Cipher Suite: TLS_RSA_WITH_AES_128_GCM_SHA256 (0x009c)
    Cipher Suite: TLS_RSA_WITH_AES_256_CBC_SHA (0x0035)
    Cipher Suite: TLS_RSA_WITH_AES_128_CBC_SHA (0x002f)
    Cipher Suite: TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA (0xc008)
    Cipher Suite: TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA (0xc012)
    Cipher Suite: TLS_RSA_WITH_3DES_EDE_CBC_SHA (0x000a)

```
Server Name Indication is very important as well
```
Extension: server_name (len=13)
    Type: server_name (0)
    Length: 13
    Server Name Indication extension
        Server Name list length: 11
        Server Name Type: host_name (0)
        Server Name length: 8
        Server Name: nasa.gov
```

## Handshake
- Client sends Hello: cipher suite, protocol version
- Server sends hello with chosen cipher suite + server certificate(public key + certificate info)
- Server sends Hello Done
- Client checks certificate
- Client generates pre-master key, encrypt it with server public key and sends it to server if RSA is used, Diffie-Hellman may be also used
- Client sends client finished
- Client and server generate symmetric key based on pre master key
- Both send change cypher spec - changing to symmetric encryption
- If Diffie-Hellman is used, than private key on the server side is used for Auth only, not for encryption

## TLS 1.3

- https://tls13.xargs.org
- You have to use PFS, no RSA, only Diffie Hellman.
- TLS 1.3 handshake is shorter
- TLS 1.3 was designed to establish session as fast as possible.  
- All encryption and authentication algorithms are combined in AEAD ciphers are used: Authenticated Encryption with Associated data: MAC + some are added to the encrypted message. Examples: AES-GCM(most common), AES-EAX, ChaCha20 with Poly1305(as MAC)
- Everything after Server Hello is encrypted
- Version negotiation removed
- SNI is still opened, but there is new RFC where it is encrypted
- Hard to understand if it is required to decrypt or not, earlier it was easier based on categories
- Client sends hello: supported ciphers, key agreements, key share(more than one). Then server can choose cipher suite and it will have a key share already for it.
- Server sends Hello back: chosen cipher, key share, signed cert(encrypted already), finished message(encrypted)

## Cipher suite
- Most used: TLS13-AES128-GCM-SHA256
- To establish SSL session client an server must negotiate how they will exchange keys,  how client will authenticate server, how they will make bulk encryption.
- Auth is checked by verifying  server certificate signature by CA + that server indeed has the private key: server sends something encrypted with private key, and client decrypts it with public key.
- Auth is always a public key cryptography. Most commonly RSA, but sometimes ECDSA.
- Auth is dependent on which key exchange algorithm is used.
- During the RSA key exchange, the client generates a random value as the premaster secret  and sends it encrypted with the server’s public key. The server, which is in possession of the corresponding private key, decrypts the message to obtain the premaster secret. The authentication is implicit: it is assumed that only the server in possession of the corresponding private key can retrieve the premaster secret, construct the correct session keys, and producethe correct Finished message.
- During the DHE and ECDHE exchanges, the server contributes to the key exchange with its parameters. The parameters are signed with its private key. The client, which is in possession of the corresponding public key (obtained from the validated certificate), can verify that the parameters genuinely arrived from the intended server

## Key exchange
Auth - Bulk encryption - MAC  
ECDHE - RSA - AES128 - GCM - SHA256  

- There is hexadecimal representation for every possible cipher suite
- Different protocols support different cipher suites
