# Cryptography

- In mathematics, computer science and physics, a deterministic system is a system in which no randomness is involved in the development of future states of the system. A deterministic model will thus always produce the same output from a given starting condition or initial state

## Encoding

- Encoding data is a process involving changing data into a new format using a scheme. - Encoding is a reversible process and data can be encoded to a new format and decoded to its original format. 
- Encoding typically involves a publicly available scheme that is easily reversed. 
- Encoding data is typically used to ensure the integrity and usability of data and is commonly used when data cannot be transferred in its current format between systems or applications
- Encoding is not used to protect or secure data because it is easy to reverse
An example of encoding is: Base64

## Encryption

Encryption is the process of securely encoding data in such a way that only authorized users with a key or password can decrypt the data to reveal the original

## Hash functions

- Digest, hash, cheksum, fingerprints, message digests, digests  
- The same input - the same output
- Regardless of input size, output is always fixed length
- Create a hash with OpenSSL: `openssl dgst -sha256 file`
- `echo -n "hello " | openssl dgst -sha256 file`
- Main practical implication: content integrity or authenticity, only when hash is securely communicated
- Written in hexademical notation - base16 - to take less space
- Hexademical (base16) and base64 are mostly used
- Wee need to trust web page which published digest, on other case hash is not enough for integrity
- It is one way
- The size of digest does matter: 256 bits minimum
- A hash function is an algorithm that converts input of arbitrary length into fixed-size output
- This is a very good way to compare two large files
- The strength of a hash function doesn’t equal the hash length

Cryptographic hash functions have to have the following properties:

- Preimage resistance - Given a hash, it’s computationally unfeasible to find or construct a message that produces it
- Second preimage resistance - Given a message and its hash, it’s computationally unfeasible to find a different message with the same hash
- Collision resistance - It’s computationally unfeasible to find two messages that have the same hash

Password hashes protection techniques:

- Salt is added to password before hashing it. It helps to avoid brute force attack, if a hacker gets all hashes
- Password hashes - Argon2 - slows down brute force, standard hash functions are very fast

### Hash function algorithms

- CRC32 - cheksum - no cryptographic hash function - only detect errors - no security properties
- MD5 - broken
- SHA1 - broken
- SHA2: SHA 224,256 (most used),384,512 - lack of resistence to length extension attacks
- SHA3 - ideal

## Message authentication codes

- Mix of hash function and secret key
- Protect integroty of data
- It takes key + message and generates authentication tag
- It can be replayed, if you intercept it you can use it later. We can add a counter to a function to remediate it, but this will limit total number of messages. This can be remediated by changing keys every period of time and starting counter from scratch
- In general 128 bit tags are used
- Best practice: use 2 different secret keys for both sides of connection
- Used in Integrity of cookies
- Used in SSL: When sending a message, SSL computes the MAC over the message contents and sequence number, using a hash function and a shared secret key (derived during the SSL handshake). The MAC is appended to the plaintext message. The combined data (Plaintext || MAC) is encrypted using a symmetric encryption algorithm (like AES or 3DES). This ensures confidentiality and integrity. The receiver decrypts the message, recomputes the MAC on the plaintext, and compares it to the MAC received
- In TLS (the modern successor to SSL), MAC usage is very similar, but in AEAD ciphers (like AES-GCM), integrity is ensured via authenticated encryption, and a separate MAC is not used 
- PRF - pseudorandom function - ?

MAC functions

- HMAC - most popular, mostly used with SHA-256
- CMAC
- GMAC
- Poly1305
- UMAC/VMAC
- CBC-MAC
- PMAC1

## Key Exchange

Concepts

- Each side generates private and public keys
- Public keys are sent to each other
- Each side uses its private key and peeer's public key to generate shared secret
- Passive MITM will not work, active one will
- The key exchange is not authenticated by nature!
- Authenticated key exchange - when users know servers public key - you have to install to all clients public keys of all services!
- That is why digital signature helps here

Key exchange algorithms:

- Diffie Hellman
  - Diffie Hellman - Modular arithmetic, original algorithm
  - DHE(ethemeral, short lived) - secret numbers generated on server and client are generated again for every session - Modular arithmetic 
  - ECDH(ecliptic curve) - variant of the Diffie–Hellman protocol using elliptic-curve cryptography. The main advantage of ECDHE is that it is significantly faster than DHE - Elliptic curve point multiplication
  - ECDHE(becoming the primary) - best - Elliptic curve point multiplication
- RSA(used from 1970s) - deprecated, large key size, no PFS, slow
- PSK

### DH algorithm

- 1976 - first key exchange algorithm invented
- RFC 3526: Predefined Groups (Modular Arithmetic) - old
- Finite-Field Diffie-Hellman (FFDHE) is essentially a modular-based Diffie-Hellman method, but with a slight difference in terminology to emphasize that the arithmetic is performed within a finite field
- DH provides forward secrecy and perfect(DHE) forward secrecy, which are required for TLS 1.3  
- DH is based on group theory
- DH works in a mulpiplicative group
- DF uses the following group: positive integers: 1,2,3,4...p-1 - p is prime number - 1: identity element
- Prime number - can be devided by itself and 1 - this is a group
- Prime numbers used in cryptography are super puper large in real world
- Also DH is based on modular multiplication
- The security of DH relies on discrete logarithm problem - it is hard to solve

Order of operations:

- Both parties must have the same values for the prime number p and the base (generator) g
- p and g are defined in a standard, RFC 7919, RFC 3526, which defines a set of known safe primes and corresponding generators that are recommended for use in TLS 1.3 (and earlier versions of TLS as well)
- On network devices it is configured with groups for IPSec
- The larger prime, the better, more secure, more load
- Generate Private Keys - random numbers between 1 and p-2, each side keeps it secret
- Compute Public Keys - A=g to the power of a mod p - where a is private key
- Exchnage public keys
- Compute shared secret
- The same order for ECDH, but different math

### Ecliptic Curve DH algorithm

- ECDH is a variant of Diffie-Hellman where elliptic curve mathematics is used instead of the modular arithmetic used in traditional DH. This allows for smaller key sizes while still providing strong security
- Instead of using modular arithmetic with prime numbers and exponents, ECDH uses elliptic curve cryptography (ECC), which relies on elliptic curve point multiplication
- Instead of using a 2048-bit prime number as in traditional Diffie-Hellman (DH), Elliptic Curve Diffie-Hellman (ECDH) uses 256-bit keys for the same level of security
- Ephemeral ECDH with RSA Certs - is used everywhere  
- Ecliptic Curve allows much smaller keys
- ECDHE by itself is worthless against an active attacker - there's no way to tie the received ECDH key to the site you're trying to visit, so an attacker could just send their own ECDH key
- This is because ECDHE is ephemeral, meaning that the server's ECDH key isn't in its certificate. So, the server signs its ECDH key using RSA, with the RSA public key being the thing in the server's certificate
- X25519 is a specific implementation of ECDH, where the elliptic curve Curve25519 is used to perform the key exchange
- RFC 7919: Customizable Groups (FFDHE) - new

### Diffie-Hellman Groups

- Defines exact prime value and generator value for modular based DH
- Elliptic Curve Diffie-Hellman (ECDH) groups define the mathematical properties of the elliptic curve, including the curve equation, base point (also called the generator point), and the field over which the elliptic curve is defined
- Possible Groups are builtin into TLS standards
- Groups are advertised and selected during the handshake without needing explicit negotiation or custom parameters
- In IPSec connections we specify them manually
- Different groups for IPSec and TLS
- Different groups for Elliptic Curve and Finite-Field Diffie-Hellman (FFDHE) - modular

Elliptic Curve TLS groups

- P-256
- P-384
- P-521
- x25519
- x448

Elliptic Curve IPSec groups

- Group 19 - P-256
- Group 20 - P-384
- Group 21 - P-521
- Group 31 - x25519
- Group 32 - x448

## Symmetric Encryption

- Ciphers can be divided into 3 groups: stream, block and AEAD
- They also can be authenticated with integrity checking or non authenticated
- Stream Ciphers - you feed one byte of plaintext to the encryption algorithm, and out comes one byte of ciphertext. The reverse happens at the other end. They XOR ciphertext with key stream. No need for padding or mode of operations. Ciphertext is the same length as plaintext. Key stream is generated from the key.
- Block Ciphers - encrypt entire blocks of data at a time; modern block ciphers tend to use a block size of 128 bits (16 bytes)
  - They are deterministic; they always produce the same output for the same input. On their own, block ciphers are not very useful because of several limitations
  - You can only use them to encrypt data lengths equal to the size of the encryption block. To use a block cipher in practice, you need a scheme to handle data of arbitrary length  
  - In practice, block ciphers are used via encryption schemes called block cipher modes, which smooth over the limitations and sometimes add authentication to the mix.
- AEAD
  - Authenticated encryption assosiated data
  - Provides encryption + integrity, earlier they did MAC-then-encrypt or encrypt-then-MAC, and now everything is combined
  - TLS supports GCM and CCM authenticated ciphers, but only the former are currently used in practice
- Limitations:
  - They are deterministic; they always produce the same output for the same input
  - You can only use them to encrypt data lengths equal to the size of the encryption block
- To use a block cipher in practice, you need a scheme to handle data of arbitrary length  
- In practice, block ciphers are used via encryption schemes called block cipher modes, which smooth over the limitations and sometimes add authentication to the mix
- They do not provide integrity by default
- Encrypt-then-MAC - HMAC+SHA256 - we apply MAC after padding the plaintext and encrypting it - it is called AES-CBC-HMAC - was one of the most widely used before AEAD
- MAC-then encrypt - can sometimes lead to clever attacks - avoided in practice
- Authentication tag is transmitted with plaintext
- It is best practise to use different keys for AES-CBC and HMAC

### AEAD

- Authenticated encryption assosiated data
- Provides encryption + integrity, earlier they did MAC-then-encrypt or encrypt-then-MAC, and now everything is combined
- TLS supports GCM and CCM authenticated ciphers, but only the former are currently used in practice
- Most popular: AES-GCM and ChaCha20-Poly1305
- Almost the same as AES-CBC-HMAC
- ChaCha20-Poly1305 - ChaCha20 stream cipher and Poly1305 MAC - for use in software - contrary to AES which is slow when hardware support is not available
- ChaCha20 takes  symmetric key and unique nonce - using them generates a key stream the same size as plaintext - XOR it with plaintext - produce ciphertext - ciphertext and plaintext are the same length
- AEAD cannot be used in disk encryption and database encrytption

### Block ciphers

**Block Cipher Modes**  

- Block cipher modes are cryptographic schemes designed to extend block ciphers to encrypt data of arbitrary length
- All block cipher modes support confidentiality
- Some combine confidetiality with authentication
- Some modes transform block ciphers to produce stream ciphers
- ECB, CBC, CFB, OFB, CTR, GCM, and so forth
- CBC - main mode for TLS/SSL
- GCM - best mode available

**Algorithms**

- AES - 128, 192, 256 bits
  - AES GCM - best one - very fast mode of block cipher - used everywhere - AEAD
  - AES CCM - AEAD
  - AES CBC - ok, possible not good, is not AEAD cipher, which is required in TLS 1.3
- Camellia
- DES - not good - Block
- 3DES - not good - Block
- RC4 - not good - stream
- RC2 - not good

**Padding**

- Is used to handle encryption of data lengths smaller than the encryption block size
- 128-bit AES requires 16 bytes of input data and produces the same amount as output, what if data is 4 bytes?
- Padding - to append some extra data to the end of your plaintext
- Format of padding must be the same on sender and receiver
- Receiver should know exactly how many bytes to discard
- In TLS, the last byte of an encryption block contains padding length, which indicates how many bytes of padding (excluding the padding length byte) there are. All padding bytes are set to the same value as the padding length byte. This approach enables the receiver to check that the padding is correct
<img width="502" alt="image" src="https://user-images.githubusercontent.com/116812447/225607064-bff68c8f-069f-4921-a521-4ee8a0c8b193.png">
- To discard the padding after decryption, the receiver examines the last byte in the data block and removes it. After that, he removes the indicated number of bytes while checking that they all have the same value

## Assymetric encryption

- If you encrypt data using someone’s public key, only their corresponding private key can decrypt it. On the other hand, if data is encrypted with the private key anyone can use the public key to unlock the message
- Hybrid encryption - mix of symmetric encryption and assymetric
- First is used for encryption
- Second is used for digital signature
- Third it is used for symmetric key exchange - usually with RSA - now it is changed to ECDH - Key Encapsulation Mechanism (KEM), seond symme tric part - data encapsulation mechanism - DEM
- Rather slow and unsuitable for use with large quantities of data
- Restricted length of messages it can encrypt
- It’s usually deployed for authentication and negotiation of shared secrets, which are then used for fast symmetric encryption
- RSA (named from the initials of Ron Rivest, Adi Shamir, and Leonard Adleman) - most popular
- The recommended strength for RSA today is 2,048 bits, which is equivalent to about 112 symmetric bits
- Not all digital signature algorithms function in the same way as RSA. In fact, RSA is an exception, because it can be used for both encryption and digital signing. Other popular public key algorithms, such as DSA and ECDSA, can’t be used for encryption and rely on different approaches for signing
- You have to generate public and private key using particular algorithm
- RSA-OAEP - the main standard for assymetric encryption with RSA
- ECIES - The main standard for hybrid encryption with ECDH - symmtetric key is generated based on Diffie Hellman - most used
- PKCS - public key cryptography standard
- Textbook RSA standard - not secure
- RSA PKCS 1.5 - not secure
- PKCS 2.0 - 2.2 - RSA-OAEP

## Digital signature

Consist of three algorithms

- Key pair generation algorithm
- Signing algorithm - takes private key and message and creates a signature'
- Verifying algorithm - takes public key, message and signature and returns success or error

Purposes

- Origin authentication
- Message integrity

- Digital signature - this is encrypted (with private key) hash of a data - non repudiation
- Person 1 encrypts hash of the message with its private key
- It is different from MAC: participant can verify a message without knowing a secret key
- Authenticated key excahnge - user signs the public key part (in Diffue Hellman) of key exchange with his signing key
- Mutually authenticated key exchange - when both users sign their public keys of key exchange
- There are: RSA assymetric encription, RSA signature, RSA company

Algorithms

- RSA PKCS 1.5 - first digital signature - many issues - PKCS v2(RSA-OAEP) - PKCS v2.1(RSA-PSS) 
  - Signing with RSA is opposite to encrypting with RSA - to sign you encreypt a message with private key - to verify signature you use public key to decrypt
  - In reality message is usually hashed before encryption
  - Calculate a hash of the document you wish to sign; no matter the size of the input doc- ument, the output will always be fixed, for example, 256 bits for SHA256
  - Encode the resulting hash and some additional metadata. For example, the receiver will need to know the hashing algorithm you used before she can process the signature
  - Encrypt the encoded hash using the private key; the result will be the signature, which you can append to the document as proof of authenticity
  - To verify the signature, the receiver takes the document and calculates the hash indepen-dently using the same algorithm. Then, she uses your public key to decrypt the message and recover the hash, confirm that the correct algorithms were used, and compare with the de-crypted hash with the one she calculated. The strength of this signature scheme depends on the individual strengths of the encryption, hashing, and encoding components
- DSA
- ECDSA - EllipticCurve Digital Signature Algorithm
- EdDSA - Edwards-Curve Digital Signature Algorithm

## Random Number Generation

It is a problem for computer to generate a true random numbers, which are requires for keys generating in Cryptography.  
Three types

- True random number generator (TRNG)- based on reliable external events - mouse movements, keystrokes.. - is hard to use directly - if data is not enough - system will stall
- Pseudorandom number generators (PRNGs) - used in programming - not suitable for cryptography - use small amounts of true random data to get them going. This process is known as seeding. From the seed, PRNGs produce unlimited amounts of pseudorandom data on demand
- Cryptographic pseudo- random number generators (CPRNGs) - PRNGs that are also unpredictable

## (Perfect) Forward Secrecy

- Forward because it avoids: if attacker captures encrypted traffic and then later he gets private key and can decrypt everything
- If SSL RSA is used for key exchange, however if you have server’s private key you can decrypt session keys and then decrypt all traffic
- Instead of RSA Diffie Helman can be used, then even if you have access to private key, you cannot get session keys - this feature is called forward secrecy
- And if you choose Ethemeral Diffie-Hellman then you achieve Perfect Forward Secrecy

### MAC

- Does MAC function provide always the same amount of bits like hash?
- RFC 2104: HMAC: Keyed-Hashing for Message Authentication (Krawczyk et al., February 1997)
- It is a cryptographic primitive
- MACs Provide Authentication & Data Integrity Checks (But Can’t Support Non-Repudiation)
- It is a mix of Hash and secret key: as Input it accepts a message + secret key and generates an Authentication Tag - this process is deterministic
- MAC is like a private hash function, which only you can produce
- Mac is prone to reply attacks. Nothing prevents malicious actor from replying captured message with MAC. To remediate it counters are used: they add to the function the sequence number: MAC (k1, 1, how are you). And if such message is replied later, it will be droopped because it does not match the sequence
- Symmetric key version of digital signatures, but digital signature provide non-repudiation, MAC does not
- You need a way to verify that a message came from an authentic sender (not an imposter) and that the data hasn’t been modified (i.e., it arrived as intended)
- MAC authenticates the sender using private key
- Used also in SSH
- It’s also sometimes referred to as a keyed hash function 
- A pure hash function could be used to verify data integrity, but only if the hash of the data is transported separately from the data itself. Otherwise, an attacker could modify both the message and the hash, easily avoiding detection
- MAC is a type of digital signature; it can be used to verify authenticity provided that the secret hashing key is securely exchanged ahead of time
- It’s limited because it still relies on a private secret key
- Message authentication code (MAC) or a keyed-hash is a cryptographic function that extends hashing with authentication
- Only those in possession of the hashing key can produce a valid MAC
- If there is no MAC, encrypted message can be altered
- Any hash function can be used as the basis for a MAC using a construction known as HMAC (short for hash-based message authentication code)
- MACs are resistant against forgery
- Minimum length of authentication tag is 128 bits - to be strong
- HMAC works by interleaving the hashing key with the message in a secure way
- A MAC is created by combining a symmetric (secret) key with the message and then hashing it using a hashing function
- MAC from the record sequence number, header, and plaintext is calculated, MAC is added to plaintext, then al this is encrypted and sent together with header, SO MAC IS SENT IN ENCRYPTED FORM TOGETHER WITH PLAIN TEXT - This process is known as MAC-then-encrypt - has many problems
- Encrypt-then-MAC - plaintext and padding are first encrypted and then fed to the MAC algorithm. This ensures that the active network attacker can’t manipulate any of the encrypted data

Types:

- CMAC
- HMAC
- KMAC  

MACs in TLS/SSL:

- SHA 256 - good - 256 bits
- SHA384 - good - 384 bits
- SHA1 - not good - 160 bits
- MD5  - not good
- SHA1 and SHA256 are used everywhere

## End-to-end encryption

- Prevents any server in the middle to observe clear text
- Main issue is protecting public key from tampering, so a trust question
- GPG/PGP - message includes encrypted symmetric key + encrypted message + signature + Public key identifier - encryption is not authenticated - does not provide forward secrecy - web of trust for trusting public keys
- S/MIME
- Both S/MIME and PGP use old standards
- Email still has issues with encryption
- OTR protocol
- Signal protocol - central server - Whatsapp - Facebook Messenger - Skype - much more secure then email encryption

## Authentication

- Message/payload authentication - message is genuine and hasn't been modified
- Origin/entity/identiry authentication - ypu are really who you are - I actually communicate to google
- User authentication
- User-aided authentication

