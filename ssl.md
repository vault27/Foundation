# SSL

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
