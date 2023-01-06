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

## Cipher suite
- Most used: TLS13-AES128-GCM-SHA256
- To establish SSL session client an server must negotiate how they will exchange keys,  how client will authenticate server, how they will make bulk encryption.
- Auth is checked by verifying  server certificate signature by CA + that server indeed has the private key: server sends something encrypted with private key, and client decrypts it with public key.
- Auth is always a public key cryptography. Most commonly RSA, but sometimes ECDSA.
- Auth is dependent on which key exchange algorithm is used.
- During the RSA key exchange, the client generates a random value as the premaster secret  and sends it encrypted with the server’s public key. The server, which is in possession of the corresponding private key, decrypts the message to obtain the premaster secret. The authentication is implicit: it is assumed that only the server in possession of the corresponding private key can retrieve the premaster secret, construct the correct session keys, and producethe correct Finished message.
- During the DHE and ECDHE exchanges, the server contributes to the key exchange with its parameters. The parameters are signed with its private key. The client, which is in possession of the corresponding public key (obtained from the validated certificate), can verify that the parameters genuinely arrived from the intended server.
