# WebSocket

- Works over TCP
-  RFC 6455
- Ports 443 and 80
- Interaction between a web browser (or other client application) and a web server with lower overhead than half-duplex alternatives such as HTTP polling
- Server to send content to the client without being first requested by the client, and allowing messages to be passed back and forth while keeping the connection open
- Most browsers support the protocol
- Full-duplex communication
- Once the connection is established, communication switches to a bidirectional binary protocol which does not conform to the HTTP protocol

## Example of request

```
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==
Sec-WebSocket-Protocol: chat, superchat
Sec-WebSocket-Version: 13
Origin: http://example.com
```

## Example of response

```
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: HSmrc0sMlYUkAGmm5OPpG2HaGWk=
Sec-WebSocket-Protocol: chat
```

