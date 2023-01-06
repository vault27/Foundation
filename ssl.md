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
