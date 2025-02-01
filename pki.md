# PKI

## Certificate

- X.509 version 3 standard is used
- Old standard, used in deffirernt areas: email, web...
- X.509 starndard uses description language Abstract Syntax Notation One - ASN.1 - to specify information contained in a certificate
- Data structure in described in ASN.1:

```
Certificate ::= SEQUENCE {
    tbsCertificate  TBSCertificate,
    signatureAlgorithm  AlgorithmIdentifier
    signatureValue  BIT STRING
}
```

- This data structure contains three fields:
    - tbsCertificate - to be signed certificate, all the information that we want to sign, for example: domain name, expiry date, public key....
    - signatureAlgorithm - algorithm used to sign - is not in the certificate itself - is  applied to the certificate as a whole and stored separately for verification purposes
    - signature Value - the signature from CA - is not in certificate itself -  applied to the certificate as a whole and stored separately for verification purposes


### Certificate formats

`ASN.1 > DER > Base64 > PEM`

- DER - bytes format
- DER is converted to base64 for comfort
- Base64 is wraped into PEM format for convenience

Convert pem to ASN.1: `openssl x509 -in google.pem -text`

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
