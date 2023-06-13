# Cryptography

- In mathematics, computer science and physics, a deterministic system is a system in which no randomness is involved in the development of future states of the system.[1] A deterministic model will thus always produce the same output from a given starting condition or initial state

## Encoding

Encoding data is a process involving changing data into a new format using a scheme. Encoding is a reversible process and data can be encoded to a new format and decoded to its original format. Encoding typically involves a publicly available scheme that is easily reversed. Encoding data is typically used to ensure the integrity and usability of data and is commonly used when data cannot be transferred in its current format between systems or applications. Encoding is not used to protect or secure data because it is easy to reverse.  
An example of encoding is: Base64

## Encryption

Encryption is the process of securely encoding data in such a way that only authorized users with a key or password can decrypt the data to reveal the original.

## Hash functions

=fingerprints=message digests=digests  
  
A hash function is an algorithm that converts input of arbitrary length into fixed-size out- put.  
This is a very good way to compare two large files.  
The strength of a hash function doesn’t equal the hash length.

Cryptographic hash functions have to have the following properties:

- Preimage resistance - Given a hash, it’s computationally unfeasible to find or construct a message that produces it
- Second preimage resistance - Given a message and its hash, it’s computationally unfeasible to find a different message with the same hash
- Collision resistance - It’s computationally unfeasible to find two messages that have the same hash

## Symmetric Encryption

Ciphers can be divided into 3 groups: stream, block and AEAD

- Stream Ciphers - ou feed one byte of plaintext to the encryption algorithm, and out comes one byte of ciphertext. The reverse happens at the other end
- Block Ciphers - encrypt entire blocks of data at a time; modern block ciphers tend to use a block size of 128 bits (16 bytes)

Limitations:
        - They are deterministic; they always produce the same output for the same input. On their own, block ciphers are not very useful because of several limitations
        - You can only use them to encrypt data lengths equal to the size of the encryption block. To use a block cipher in practice, you need a scheme to handle data of arbitrary length  
In practice, block ciphers are used via encryption schemes called block cipher modes, which smooth over the limitations and sometimes add authentication to the mix.
- AEAD
  - Authenticated encryption assosiated data
  - Provides encryption + integrity, earlier they did MAC-then-encrypt or encrypt-then-MAC, and now everything is combined
  - TLS supports GCM and CCM authenticated ciphers, but only the former are currently used in practice

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

- AES
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
- First is used for encryption
- Second is used for digital signature
- Rather slow and unsuitable for use with large quantities of data
- It’s usually deployed for authentication and negotiation of shared secrets, which are then used for fast symmetric encryption
- RSA (named from the initials of Ron Rivest, Adi Shamir, and Leonard Adleman) - most popular
- The recommended strength for RSA today is 2,048 bits, which is equivalent to about 112 symmetric bits
- Not all digital signature algorithms function in the same way as RSA. In fact, RSA is an exception, because it can be used for both encryption and digital signing. Other popular public key algorithms, such as DSA and ECDSA, can’t be used for encryption and rely on different approaches for signing

## Digital signature

- Digital signature - this is encrypted (with private key) hash of a data - non repudiation
- Person 1 encrypts hash of the message with its private key

Algorithms

- RSA - first digital signature, de facto standard
- Elgamal - it differs from Elgamal encryption scheme. Native Elgamal signature algorithm is rarely used. DSA is much more popular
- DSA - extension of Elgamal, better than Elgamal. Can be used only for signing, not encryption
- Elliptic curve digital signature algorithm (ECDSA) - extension of Elgamal

- Calculate a hash of the document you wish to sign; no matter the size of the input doc- ument, the output will always be fixed, for example, 256 bits for SHA256
- Encode the resulting hash and some additional metadata. For example, the receiver will need to know the hashing algorithm you used before she can process the signa- ture
- Encrypt the encoded hash using the private key; the result will be the signature, which you can append to the document as proof of authenticity
- To verify the signature, the receiver takes the document and calculates the hash indepen- dently using the same algorithm. Then, she uses your public key to decrypt the message and recover the hash, confirm that the correct algorithms were used, and compare with the de- crypted hash with the one she calculated. The strength of this signature scheme depends on the individual strengths of the encryption, hashing, and encoding components
- Algorithms: RSA, DSA, ECDSA

## Random Number Generation

It is a problem for computer to generate a true random numbers, which are requires for keys generating in Cryptography.  
Three types

- True random number generator (TRNG)- based on reliable external events - mouse movements, keystrokes.. - is hard to use directly - if data is not enough - system will stall
- Pseudorandom number generators (PRNGs) - used in programming - not suitable for cryptography - use small amounts of true random data to get them going. This process is known as seeding. From the seed, PRNGs produce unlimited amounts of pseudorandom data on demand
- Cryptographic pseudo- random number generators (CPRNGs) - PRNGs that are also unpredictable

## Elliptic curve cryptography

- This public key system. The same as RSA.
- ECC key 256 bits is the same as 3072 RSA key. So ECC can use smaller keys.
- ECC key 384 bits - US government top secret

### (Perfect) Forward Secrecy

- Forward because it avoids: if attacker captures encrypted traffic and then later he gets private key and can decrypt everything
- If SSL RSA is used for key exchange, however if you have server’s private key you can decrypt session keys and then decrypt all traffic.
- Instead of RSA DiffieHelman can be used, then even if you have access to private key, you cannot get session keys - this feature is called forward secrecy
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

### Key Exchange

- Diffie Hellman(more and more used today)
  - Diffie Hellman
  - DHE(ethemeral, short lived) - secret numbers generated on server and client are generated again for every session
  - ECDH(ecliptic curve) - variant of the Diffie–Hellman protocol using elliptic-curve cryptography. The main advantage of ECDHE is that it is significantly faster than DHE
  - ECDHE(becoming the primary)  - best
- RSA(used from 1970s) - deprecated, large key size, no PFS, slow
- PSK

Ephemeral ECDH w/ RSA Certs - is used everywhere  
Ecliptic Curve allows much smaller keys  
DH provides forward secrecy and perfect(DHE) forward secrecy, which are required for TLS 1.3  
ECDHE by itself is worthless against an active attacker -- there's no way to tie the received ECDH key to the site you're trying to visit, so an attacker could just send their own ECDH key. This is because ECDHE is ephemeral, meaning that the server's ECDH key isn't in its certificate. So, the server signs its ECDH key using RSA, with the RSA public key being the thing in the server's certificate
