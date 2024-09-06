# SAML

- Provides SSO - you login once and then have access to all applications
- Everything is transmitted via HTTPS
- IdP - Identity Provider
- SP - service providers - applications themselfs
- IdP sends asserion (XML + Base64) to SP that user good to go
- SAML resolves issue with Cross Domain SSO - cookies cannot do it, cookie for abc.com cannot be sent to acb.com.....

## Flow

- User tries to access a protected resource
- Service Provider (SP) redirects the user to an Identity Provider (IdP) with an authentication request
```
HTTP/1.1 302 Found
Location: https://idp.example.com/sso?SAMLRequest=<Base64EncodedSAMLRequest>
```

- IdP authenticates the user and generates a SAML assertion
- IdP sends the SAML assertion back to the SP through the user's browser: via Redirect message to user browser, or via POST html form, sent ti user, this form points to SP
- User connects back to SP and gets the cookie
- SP or IdP sends a Single Logout Request to log the user out of all sessions