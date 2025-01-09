# Curl

## Check redirected websites with only Headers

`curl.exe -kIL https://www.sportchek.com`
 - I - fetches only headers
 - L - Follows HTTP redirects (3xx responses) automatically
 - k - ignores self-signed certs

 ## Check cert expiry date

- `curl -vk https://example.com 2>&1 | grep expire`
- 2>&1 - Redirects standard error (where verbose output goes) to standard output so it can be processed
- v - verbose
- k - ignores self-signed certs