# TLS/SSL

TLS/SSL for network engineer. All you need to know in 1 place. Short and clear.

- Secure transport protocol
- SSL v3 - 1996 - Netscape
- Netscape handed it over to IETF
- IETF renamed it to TLS in 1999

## Versions

- SSLv1(out of date, vulnerable)
- SSLv2(do not use)
- SSLv3(do not use)
- TLS 1.0(deprecated, many attacks, PCI DSS prohibited) - RFC 2246
- TLS 1.1 - RFC 4346
- TLS 1.2 - is the best option for now - RFC 5246 - secure
- TLS 1.3 - RFC 8446 - secure

## Concepts

- TLS communicates via records, can be several records in one packet TCP packet (one or many IP packets) 
- In a nutshell TLS is all about different records. Different records serve different purposes. Records have Content-Type field and Message fields
- Message field will contain the actual message related to a particular Record Protocol type

## SSL Records

- Handshake - Content-Type Code 22
- Application Data - Content-Type Code 23
- Alerts - Content-Type Code 21
- Change Cipher Spec - Content-Type Code 

## Handshake

### Tasks

- Negotiation of ciphers and protocols: authenticated encryption algorithms
- Key exchange - main goal actually: algorithm itself + groups
- Authentication of key exchange - digital signature algorithm + hash algorithm - two, for different parts of the handshake - one signature algorithm is used for server certificate signature, the other one for signing key exchange parameters or messages exchanged between the client and server
- Session resumption - to avoid redoing key exchange every time user connects again

### What should be negotiated - 9 parametres

- TLS version
- Key Exchange Algorithm
- Key exchange group
- 2 Signature algorithms for authenticated key exchange: one for certificate, one for transcript
- Hash functions to use with signature alorithms: one for certificate, one for transcript
- Symmetric encryption algorithm
- Symmetric encryption key size
- Simmetric encryption mode
- Hash function - message integrity and key derivation in the TLS handshake and record layer

### 3 Handshake Stages

- Key Exchange
    - ClientHello
    - ServerHello
- Server Parametres
    - The server sends a CertificateRequest message with details about the accepted certificate types, supported signature algorithms, and acceptable certificate authorities (CAs)
    - A server's X.509 certificate chain is sent, including: The server's certificate, Intermediate certificates, if required, Root certificate (often omitted, as it's known to the client)
    - The server provides a digital signature over previously exchanged handshake messages to prove it controls the private key corresponding to its certificate. CertificateVerify message
    - In TLS 1.3, much of the functionality traditionally handled in the Server Parameters stage (like key exchange) has been shifted earlier, into the ServerHello message, simplifying the handshake
- Authetication
- Post-Handshake

### Client Hello

- Universal for all TLS versions
- Content Type - Handshake - 22
- Handshake Type - Client Hello - 1
- Session ID - large number
- Random - large number - randomly generated for every new session
- All possible cipher suites for all TLS versions
- Many Extensions, some of them:
        - TLS supported versions
        - Key share extension: Group: x25519, Key Exchange - big number - client public key for Diffie-Helman exchange algorithm - TLS 1.3 only
        - SNI - server name
        - Supported Diffie-Hellman groups
        - Signature alhorithms
        - ALPN protocol

Random

- Critical role in ensuring session uniqueness, preventing replay attacks, and contributing to key generation
-It consists of:
    - First 4 bytes: A UNIX timestamp (seconds since 1970-01-01).
    - Remaining 28 bytes: A cryptographically secure random value
- The master secret is derived using the Client Random, Server Random, and the pre-master secret from key exchange (e.g., from an RSA-encrypted or DH-derived value)
- The master secret is then used to generate session keys

### Server Hello

- Contains one cipher suite, which was chosen from Client Hello
- If Server cannot find an algorithm it supports, it may drop a connection or it may ask a client for more information via Hello Retry Request, then client resends its Hello

### Key exchange

Key derivation

- TLS1.2: `Premaster secret from ECDHE > Master secret from pre-master secret, client random and server random > session keys from master`
- TLS 1.3: Directly deriving session keys from ECDHE-derived secrets using HKDF (HMAC-based Extract-and-Expand Key Derivation Function)
- Premaster is not enough: This ensures that even if the same ECDHE pre-master secret is derived again in another session, the master secret will be different because of the unique random values

Key types


- In TLS 1.3 client sends in ClientHello list of supported ECDHE groups: X25519 and X448 plus it sends X25519 public key
- If Server does not support X25519, but does support X448, it sends HelloRetryRequest, announcing that it only suoports X448
- The Client sends the same ClientHello, but with X448 public key instead

### Auth

- Authentication of key exchange is done using assymetric cryptography and hash algorithms
- Signature and hash algorithms are negotiated in Client/Server Hello
- Supported signature and hash algorithms are sent in `signature_alhorithms` extension, then Server may use these algorithms for transript signing, it also checks that client supports certificate signature algorithm used by CA, if client does not support it, handshake will not be established. Certificate signature algorithm and transcript signature algorithm maybe different. The most important that both of them are supported by client
- TLS 1.3 introduces signature_algorithms_cert (a separate extension) to list signature algorithms specifically for certificate signatures. This separates the algorithms used for certificates from those used for the handshake - `This extension is optional` - You will not see it in a capture from browser
- In TLS 1.2 certificate type is also specified in Cipher Suite, this is not used in TLS 1.3
- The certificate type (RSA or ECDSA) is automatically determined by the certificate itself when the server sends it to the client
- Unlike in TLS 1.2, signature algorithms in TLS 1.3 are not tightly coupled to hash algorithms - ?

Example of signature_algorithms in TLS 1.3:

```
Signature Hash Algorithms (11 algorithms)
    Signature Algorithm: ecdsa_secp256r1_sha256 (0x0403)
    Signature Algorithm: rsa_pss_rsae_sha256 (0x0804)
    Signature Algorithm: rsa_pkcs1_sha256 (0x0401)
    Signature Algorithm: ecdsa_secp384r1_sha384 (0x0503)
    Signature Algorithm: ecdsa_sha1 (0x0203)
    Signature Algorithm: rsa_pss_rsae_sha384 (0x0805)
    Signature Algorithm: rsa_pss_rsae_sha384 (0x0805)
    Signature Algorithm: rsa_pkcs1_sha384 (0x0501)
    Signature Algorithm: rsa_pss_rsae_sha512 (0x0806)
    Signature Algorithm: rsa_pkcs1_sha512 (0x0601)
    Signature Algorithm: rsa_pkcs1_sha1 (0x0201)

```

- The ServerHello does not explicitly confirm the signature algorithm chosen for the handshake
- The actual signature algorithm used by the server is implicitly confirmed later in the CertificateVerify message when the server signs the handshake transcript
- Server chooses Signature Algorithm from Client's list based on a compatible signature algorithm that it supports and that matches its certificate's capabilities
- For example, if the server's certificate uses an RSA key, it will choose an RSA-based signature algorithm (e.g., rsa_pss_rsae_sha256),if the server's certificate uses an ECDSA key, it will choose an ECDSA-based signature algorithm (e.g., ecdsa_secp256r1_sha256)
- Different signature algorithms and hash algorithms may be used for the server's certificate signature and the CertificateVerify message. This distinction exists because these signatures serve different purposes and are governed by different rules
- `Server hashes a handshake transcript > Server signs this hash > Server creates a CertificateVerify message`
- Server sends CertificateVerify message
- This message includes a digital signature over a handshake transcript
- The CertificateVerify message has the following components:
        - Signature Algorithm: Indicates the algorithm used for signing: RSA PKCS#1 version 1.5, RSA-PSS, ECDSA, EdDSA
        - Hash Algorithm used to create a hash for handshake transcript: SHA-256...
        - Signature: The digital signature itself, calculated over the handshake transcript hash
- Handshake transcript includes: `ClientHello, ServerHello, EncryptedExtensions, Certificate (if applicable)` - so all the records sent before
- Handshake transcript is different for TLS 1.3 and TLS 1.2
- The client validates CertificateVerify message by Verifying the server's certificate chain (ensuring the certificate is valid and trusted and Using the public key in the server's certificate to verify the signature in the CertificateVerify message
- After this client sends Finished message in TLS 1.3, in TLS 1.3 it sends ClientKeyExchange
- RSA - good to use    
- ECDSA (Ecliptic curve digital signature algorithm) - slow  
- DSA
- Auth is checked by verifying  server certificate signature by CA + that server indeed has the private key: server sends something encrypted with private key, and client decrypts it with public key
- Auth is always a public key cryptography. Most commonly RSA, but sometimes ECDSA
- Auth is dependent on which key exchange algorithm is used
- During the RSA key exchange, the client generates a random value as the premaster secret  and sends it encrypted with the server’s public key. The server, which is in possession of the corresponding private key, decrypts the message to obtain the premaster secret. The authentication is implicit: it is assumed that only the server in possession of the corresponding private key can retrieve the premaster secret, construct the correct session keys, and producethe correct Finished message
- During the DHE and ECDHE exchanges, the server contributes to the key exchange with its parameters. The parameters are signed with its private key. The client, which is in possession of the corresponding public key (obtained from the validated certificate), can verify that the parameters genuinely arrived from the intended server
- The server uses its private RSA key to sign parts of the handshake process to prove its identity to the client. This ensures that the Diffie-Hellman key exchange parameters are authentic and have not been tampered with

### Hash function

- Used with HMAC and HKDF
- The hash function is used in conjunction with the HMAC (Hash-based Message Authentication Code) algorithm to ensure the integrity of encrypted messages in the record layer
- It ensures that the messages exchanged between the client and server have not been tampered with
- The plaintext data is first encrypted using the encryption algorithm (AES-128-CBC).
- An HMAC is calculated over the encrypted data using the specified hash function (SHA-1).
- The HMAC is appended to the encrypted data to allow the recipient to verify its integrity

Key derivation

- The hash function is also used during the key derivation process to generate session keys from shared secrets


- TLS 1.3 allows SHA-256 and SHA-384

### Session resumption


## Record protocol - Application Data

`[TLS Record Header] + [Encrypted Data] + [Authentication Tag]`

- Traffic protection between peers
- Division of traffic into a series of records, each of which is independently protected using the traffic keys
- TLS ensures that all messages cannot be replayed or reordered
- Nonce is used, starts at fixed value, for incremented for each new message, if nonce is not correct, connection is dropped
- In TLS 1.3, the nonce is generated independently by both the client and server based on shared keys and a sequence number
- TLS record with application data includes:
    - Content Type - 23
    - Protoocol version TLS 1.2 or TLS 1.3
    - Length of encrypted data
    - Nonce
    - Encrypted HTTP data
    - Authentication Tag for integrity
- Authentication Tag - verifying that the data was not tampered with during transmission. The authentication tag is produced using a Message Authentication Code (MAC), combined with encryption

Example of application data - nothing interesting

```
Transport Layer Security
    TLSv1.3 Record Layer: Application Data Protocol: Hypertext Transfer Protocol
        Opaque Type: Application Data (23)
        Version: TLS 1.2 (0x0303)
        Length: 26
        Encrypted Application Data: 1b226c63c851eea9897e0e6e4d3d265d96cac4f55564e66e81d4
        [Application Data Protocol: Hypertext Transfer Protocol]
```

## Alerts

- The Alert protocol further has a field called Description. This field contains the actual error information
- Alert example

![image](https://github.com/phph9/Foundation/assets/116812447/84324f16-9698-41df-a068-f0c4f2597b33)

```
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
```

## Cipher suite - parameters used during the communication

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
- Signature algorithm is sent as extension in Client hello
- Key exchange is ECDHE always

TLS 1.3 Cipher Suites:

- TLS_AES_128_GCM_SHA256
- TLS_AES_256_GCM_SHA384
- TLS_CHACHA20_POLY1305_SHA256
- TLS_AES_128_CCM_SHA256
- TLS_AES_128_CCM_8_SHA256  

TLS 1.3 cipher suites are defined differently, only specifying the symmetric ciphers, and cannot be used for TLS 1.2. Similarly, cipher suites for TLS 1.2 and lower cannot be used with TLS 1.3.

### Symmetric encryption

### Hash function

## TLS 1.2 packet flow

- Client sends Hello: cipher suite, protocol version
- Server sends hello with chosen cipher suite + server certificate(public key + certificate info)
- Server sends Hello Done
- Client checks certificate
- Client generates pre-master key, encrypt it with server public key and sends it to server if RSA is used, Diffie-Hellman may be also used
- Client sends client finished
- Client and server generate symmetric key based on pre master key
- Both send change cypher spec - changing to symmetric encryption
- If Diffie-Hellman is used, than private key on the server side is used for Auth only, not for encryption

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

## TLS 1.3

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
 - 0-RTT Resumption (early data): if the client has connected to the server before, TLS 1.3 permits a zero-round trip handshake. This is accomplished by storing secret information (typically, Session ID or Session Tickets) of previous sessions and using them when both parties connect with each other in future. But it leads to the absense of Forward Secrecy. The second security concern when it comes to TLS 1.3 0-RTT is that it doesn’t provide a guarantee of non-replay between connections. If an attacker somehow manages to get hold of your 0-RTT encrypted data, it can fool the server into believing that the request came from the client. It is not very recomendeded to use it.

### Handshake

- Client Hello: Supported Cipher Suites, Guesses Key Agreement Protocol, Key Share
- Server Hello, Key Agreement Protocol, Key Share, Server Finished

### Strong ciphers and algorithms

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
- Browsers add SNI to every request
- Example from traffic capture
```
Extension: server_name (len=12)
Type: server_name (0)
Length: 12
Server Name Indication extension
	Server Name list length: 10
	Server Name Type: host_name (0)
	Server Name length: 7
	Server Name: mail.ru
```

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

## PSK

- PSK can be used instead of certificates
- Client sends PSK identifiers in ClientHello
- Authentication and key exchange phases are skipped
- Used for session resumption

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

Show SAN for cert: 
- `openssl s_client -connect wpcp-dc1.corp.ad.ctc:636 -showcerts </dev/null`
- Create a file called cert.pem, and paste the first certificate block contents into it
- `openssl x509 -in cert.pem -noout -text`

## Nmap

Show SSL cert

`nmap -p 443 --script ssl-cert example.com`
