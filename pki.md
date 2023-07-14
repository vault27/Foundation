# PKI

## Certificate

## Certificate signature process

## Self-signed certificate
In self-signed certificate all data in Subject Name is identical to all data in Issuer Name section.

## OCSP

## SCEP

## CRL

## CA
- CA stays offline
- CA signs subordinate CA: encrypts its hash with CA private key
- Subordinate CA signs server certificate.
- Server sends to client its cert + subordinate CA or many subordinates
- Enroll means to send public key and identity information to CA, so CA can issue an identity certificate
