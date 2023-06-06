# ICAP

## Response mode

- The best way to filter RESPMOD in ICAP traffic is using Request URI field (http.response_for.uri), this field is located in HTTP replies, which sends to DLP server for checking. And DLP server repeated these replies in its Response
- For example, to see in ICAP traffic ICAP RESPMOD request regarding eicar file and ICAP response to it we use filter

```text
http.response_for.uri == "http://secure.eicar.org/eicar.com.txt"
```

### Operations overview 

- User requests PDF file and F5 sends ICAP request to DLP via Request mode with this HTTP request

```text
Internet Content Adaptation Protocol
    REQMOD icap://10.2.55.113:1344/request ICAP/1.0\r\n
    Date: Tue, 06 Jun 2023 07:17:14 GMT\r\n
    Host: 10.2.55.113:1344\r\n
    Encapsulated: req-hdr=0, null-body=786\r\n
    X-Client-IP: 192.168.1.21\r\n
    \r\n
    Hypertext Transfer Protocol
        GET /sample-data.pdf HTTP/1.1\r\n
        Host: dlptest.com\r\n
```

- DLP server replies with OK and attaches copy of the HTTP request

```text
Internet Content Adaptation Protocol
    ICAP/1.0 200 OK\r\n
    Action: Allow\r\n
    Reason: Filtred by NoBody\r\n
    ISTag: "A6hv885fz4Imo7s2GEcY0vKbbUjk92"\r\n
    Date: Mon, 05 Jun 2023 23:16:58 GMT\r\n
    Encapsulated: req-hdr=0, null-body=786\r\n
    \r\n
    Hypertext Transfer Protocol
        GET /sample-data.pdf HTTP/1.1\r\n
        host: dlptest.com\r\n
```

- Then response from web server arrives to F5, and F5 sends this response to DLP server via Respmode(we can see it in ICAP header), it attaches not only HTTP response, but also initial HTTP request. If there is a file in a response, the file is sent as well: many ICAP packets in row.

```
Internet Content Adaptation Protocol
    RESPMOD icap://10.2.55.113:1344/response ICAP/1.0\r\n
    Date: Tue, 06 Jun 2023 07:17:15 GMT\r\n
    Host: 10.2.55.113:1344\r\n
    Encapsulated: req-hdr=0, res-hdr=786, null-body=1106\r\n
    X-Client-IP: 192.168.1.21\r\n
    \r\n
    Hypertext Transfer Protocol
    Hypertext Transfer Protocol
```

- To find proper response we can use Request URI field (http.response_for.uri) in Wireshark in HTTP response header:

```
http.response_for.uri == "http://dlptest.com/sample-data.xls"
```

- After checking DLP server replies with ICAP status and copy of HTTP reply

```text
Internet Content Adaptation Protocol
    ICAP/1.0 200 OK\r\n
    Action: Allow\r\n
    Reason: Filtred by MimeType\r\n
    ISTag: "DS2E79RvooIgN9zysF3hgxGDV8lzuZ"\r\n
    Date: Tue, 06 Jun 2023 00:11:20 GMT\r\n
    Encapsulated: res-hdr=0, res-body=346\r\n
    \r\n
    Hypertext Transfer Protocol
        HTTP/1.1 200 OK\r\n
        date: Tue, 06 Jun 2023 00:11:18 GMT\r\n
        server: Apache\r\n
        last-modified: Wed, 01 Jul 2020 19:34:06 GMT\r\n
        etag: "44-5a966600698bd"\r\n
        accept-ranges: bytes\r\n
        content-length: 68\r\n
        strict-transport-security: max-age=31536000; includeSubDomains\r\n
        keep-alive: timeout=5, max=50\r\n
        connection: Keep-Alive\r\n
        content-type: text/plain; charset=utf-8\r\n
        \r\n
        [HTTP response 2/2]
        [Prev request in frame: 11]
        [Prev response in frame: 11]
        [Request URI: http://secure.eicar.org/eicar.com.txt]
        File Data: 68 bytes
    Line-based text data: text/plain (2 lines)
    Hypertext Transfer Protocol

```