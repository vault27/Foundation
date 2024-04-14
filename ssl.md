# TLS/SSL

## RFC

- TLS 1.2 - RFC 5246 - https://datatracker.ietf.org/doc/html/rfc5246
  
## SSL/TLS Protocols 

- In a nutshell TLS is all about different records. Different records serve different purposes. Records have Content-Type field and Message fields (Some other fields too)
- Depending upon the Content-Type field's value, you know what is the purpose of a particular record. For eg: Content-Type=21 means that this is an Alert protocol and Content-Type=22 means that this is a Handshake protocol
- Message field will contain the actual message related to a particular Record Protocol type
- The Alert protocol further has a field called Description. This field contains the actual error information
- The 21 shown in the wireshark capture is not a code but it is value in the Content-Type field of the TLS record. In plain words, the wireshark is telling us that this is a TLS Alert protocol
- The 21 shown in the wireshark capture is not a code but it is value in the Content-Type field of the TLS record. In plain words, the wireshark is telling us that this is a TLS Alert protocol

Alert example

![image](https://github.com/phph9/Foundation/assets/116812447/84324f16-9698-41df-a068-f0c4f2597b33)

**Alerts**

close_notify(0)
unexpected_message(10),
bad_record_mac(20),
decryption_failed_RESERVED(21),
record_overflow(22),
decompression_failure(30),
          handshake_failure(40),
          no_certificate_RESERVED(41),
          bad_certificate(42),
          unsupported_certificate(43),
          certificate_revoked(44),
          certificate_expired(45),
          certificate_unknown(46),
          illegal_parameter(47),
          unknown_ca(48),
          access_denied(49),
          decode_error(50),
          decrypt_error(51)
Handshake protocol
- Authentication
- Cryptographic modes negotiation
- Shared keying material establishement

Record protocol
- Traffic protection between peers
- Division of traffic into a series of records, each of which is independently protected using the traffic keys

In TLS, integrity validation is part of the encryption process; it’s handled either explicitly at the protocol level or implicitly by the negotiated cipher.
- SSLv1(out of date, vulnerable)
- SSLv2(do not use)
- SSLv3(do not use)
- TLS 1.0(deprecated, many attacks, PCI DSS prohibited) - RFC 2246
- TLS 1.1 - RFC 4346
- TLS 1.2 - is the best option for now - RFC 5246
- TLS 1.3 - RFC 8446

### History

- SSL v3 - 1996 - Netscape
- Netscape handed it over to IETF
- IETF renemaed it to TLS in 1999
 
### Handshake

- Client sends Hello: cipher suite, protocol version
- Server sends hello with chosen cipher suite + server certificate(public key + certificate info)
- Server sends Hello Done
- Client checks certificate
- Client generates pre-master key, encrypt it with server public key and sends it to server if RSA is used, Diffie-Hellman may be also used
- Client sends client finished
- Client and server generate symmetric key based on pre master key
- Both send change cypher spec - changing to symmetric encryption
- If Diffie-Hellman is used, than private key on the server side is used for Auth only, not for encryption

### Cipher suite

https://ciphersuite.info  

Attributes:
- Authentication method
- Key exchange method
- Encryption algorithm
- Encryption key size
- Cipher mode (when applicable)
- MAC algorithm (when applicable)
- PRF (TLS 1.2 only—depends on the protocol otherwise)
- Hash function used for the Finished message (TLS 1.2)
- Length of the verify_data structure (TLS 1.2)

TLS suites use the TLS_ prefix, SSL 3 suites use the SSL_ prefix, and SSL 2 suites use the SSL_CK_ prefix. In all cases, the approach to naming is roughly the same. However, not all vendors use the standard suite names. OpenSSL and GnuTLS use different names. Microsoft largely uses the standard names but sometimes extends them with suffixes that are used to indicate the strength of the ECDHE key exchange.  

**TLS1.2 cipher suite - 4 parametres**
```
TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
```

**TLS 1.3 cipher suite - 2 parametres**
```
TLS_AES_128_GCM_SHA256
```

- In TLS 1.3 there are fewer parametres to avoid many variants of suites.  
- Signature algorithm is sent as extension in CLient hello
- Key exchange is ECDHE always

TLS 1.3 Cipher Suites:
- TLS_AES_128_GCM_SHA256
- TLS_AES_256_GCM_SHA384
- TLS_CHACHA20_POLY1305_SHA256
- TLS_AES_128_CCM_SHA256
- TLS_AES_128_CCM_8_SHA256  

LS 1.3 cipher suites are defined differently, only specifying the symmetric ciphers, and cannot be used for TLS 1.2. Similarly, cipher suites for TLS 1.2 and lower cannot be used with TLS 1.3.

### TLS 1.2

Handshake  
- TLS communicates via records, can be several records in one packet TCP packet (one or many IP packets) 
- Every record has its own Handshake Type (number), we can use it to filter in Wireshark.    
- Plus there is a Content type number - for handshake it is 22, Application data - 23, Alert - 21 - it is for whole TCP packet 
  
Handshake process, records, 10 in total:  
1. Client hello - Type 1 - TLS version, Cipher Suites, Server Name Indication  
2. Server Hello - Type 2 - chosen cipher suite,TLS version  
3. Certificate (Type 11) - both certs - server and intermediate  
4. Server Key Exchange (Type 12) - Difie Hellman Data  
5. Server Hello Done(Type 14)  
6. Client key Exchange(Type 16) - Difie Hellman data from client
7. Client Change Cipher Spec (Type - 20, This message notifies the server that all the future messages will be encrypted using the algorithm and keys that were just negotiated.)
8. Client Encrypted Handshake Message
9. Change Cipher Spec from server
10. Encrypted handshake message from server

### TLS 1.3

https://tls13.xargs.org  
https://blog.cloudflare.com/rfc-8446-aka-tls-1-3/  
 
 High level:
 - Increased speed
 - More Secure

 Main features:
 - Only strong ciphers and algorithms
 - Faster handshake - increased performance
 - The server now signs the entire handshake, including the cipher negotiation, so it is impossible to forge handshake process
 - No user-defined DH parameters, no RSA. This means that every connection will use a DH-based key agreement and the parameters supported by the server are likely easy to guess (ECDHE with X25519 or P-256). Because of this limited set of choices, the client can simply choose to send DH key shares in the first message instead of waiting until the server has confirmed which key shares it is willing to support. That way, the server can learn the shared secret and send encrypted data one round trip earlier. SO CLIENT sends KEY IMMEDIATELY.
 - Everything after Server Hello is encrypted, Certificate is encrypted - in order to understand where client goes, we need full interception
 - Passive decryption, when you have TLS server private key, will not work - perfect forward secrecy
 - Short notation of cipher suite: authentication algotithm is sent as an extension, key exchange algorithm is always Ephemeral Diffie-Hellman, cipher suite became too long too complex, there were too many variants of suites, for every suite IANA created a code
 - Version negotiation removed
 - SNI is still opened, but there is new RFC where it is encrypted
 - 0-RTT Resumption: if the client has connected to the server before, TLS 1.3 permits a zero-round trip handshake. This is accomplished by storing secret information (typically, Session ID or Session Tickets) of previous sessions and using them when both parties connect with each other in future. But it leads to the absense of Forward Secrecy. The second security concern when it comes to TLS 1.3 0-RTT is that it doesn’t provide a guarantee of non-replay between connections. If an attacker somehow manages to get hold of your 0-RTT encrypted data, it can fool the server into believing that the request came from the client.

#### Handshake
- Client Hello: Supported Cipher Suites, Guesses Key Agreement Protocol, Key Share
- Server Hello, Key Agreement Protocol, Key Share, Server Finished


#### Strong ciphers and algorithms

Symmetric encryption - only AEAD ciphers:
- AES-GCM(most common)
- AES-EAX
- ChaCha20 with Poly1305(as MAC)

Perfect forward secrecy is mandatory, no RSA, only Diffie Hellman, TLS v1.3 supports only three key exchange methods:
- Ephemeral Diffie-Hellman (combined with digital signatures for authentication);
- PSK with ephemeral Diffie-Hellman;
- PSK without ephemeral Diffie-Hellman.

### Client Hello

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
- For TLS1.3 notaion is shorter, for example most popular - TLS13-AES128-GCM-SHA256 - No data about Key Exchange and Auth, because AEAD ciphers are used
- There is hexadecimal representation for every possible cipher suite
- Different protocols support different cipher suites

#### Auth

- RSA - good to use    
- ECDSA (Ecliptic curve digital signature algorithm) - slow  
- DSA
- Auth is checked by verifying  server certificate signature by CA + that server indeed has the private key: server sends something encrypted with private key, and client decrypts it with public key
- Auth is always a public key cryptography. Most commonly RSA, but sometimes ECDSA
- Auth is dependent on which key exchange algorithm is used
- During the RSA key exchange, the client generates a random value as the premaster secret  and sends it encrypted with the server’s public key. The server, which is in possession of the corresponding private key, decrypts the message to obtain the premaster secret. The authentication is implicit: it is assumed that only the server in possession of the corresponding private key can retrieve the premaster secret, construct the correct session keys, and producethe correct Finished message
- During the DHE and ECDHE exchanges, the server contributes to the key exchange with its parameters. The parameters are signed with its private key. The client, which is in possession of the corresponding public key (obtained from the validated certificate), can verify that the parameters genuinely arrived from the intended server


## Alerts


## SNI

ServerName encryption    
Server Name (the domain part of the URL) is presented in the ClientHello packet, in plain text.  
From RFC:  
3.1. Server Name Indication
[TLS] does not provide a mechanism for a client to tell a server the name of the server it is contacting. It may be desirable for clients to provide this information to facilitate secure connections to servers that host multiple 'virtual' servers at a single underlying network address.
In order to provide the server name, clients MAY include an extension of type "server_name" in the (extended) client hello.  
- The payload in the SNI extension can now be encrypted in TLS1.3
- **SNI can be changed by client to bypass security policies, so it is very important to check server certificate not only SNI**
- All policies on NGWF and SSL decryptors are based on SNI or Server certificate, Server certificate is more accurate source. In TLS 1.3 it is encrypted. So it is more difficult to understand what to decrypt and what not
- Also, reverse DNS lookup may help 
- Correct application identification is only possible with decryption: gmail site is signed by Google cert and you will not be able to understand what it is exactly without decryption
- SNI Routing can be uased on load balancers to forward traffic without SSL termination to particular pool

## HSTS



## Wireshark

SNI filtering
```
tls.handshake.extensions_server_name contains "dlp"
```

Show only Handshake protocol, no application data
```
tls.record.content_type == 22
```

Show only client hellos
```
tls.handshake.type == 1
```

Show only server hellos
```
tls.handshake.type == 2
```

## Client authentication

- When a server indicates a requirement for the client to submit its certificate, the client must send both its certificate, and a digitally-signed hash value. This hash value is signed (i.e. encrypted) with the client's private key
- Server has to have the same CA, which was used to create client's cert
- Server checks the validity of CA + that client indeed has private key
- If someones decide to decrypt an re-encrypt - it will not possible, because interceptor does not have client's private key
- Such connections usually compltetely bypassed

## Decryption

Why decryption fails:

- Untrusted server certificate
- Expired certificate
- Pinned certificate to client
- Client authentication
- Unsupported ciphers
- Custom app

## OpenSSL

```
openssl s_client -connect meetup.sberbank.ru:443
```
This command will show certificates, protocol and ciphers
If F5 does not know this certificate, there will be a error: 

```
verify error:num=20:unable to get local issuer certificate
verify error:num=21:unable to verify the first certificate
```
