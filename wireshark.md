# Wireshark

## Troubleshooting

Troubleshooting tools

- Time metrics
- Expert mode
- TCP graphs
- Conversations and endpoints
- Flow graphs
- IO graph
- Statistics > HTTP > Request sequences

### Performance metrics

- Latency
- Throughput
- Packet loss

### Congestion control

Indication of congestion

- Keeps alives
- Duplicate ACKs
- Retransmissions

### Retransmission

- Server does not receive ACK in time from client, and server retransmits the data
- Follow TCP stream
- Launch Expert mode - left bottom corner
- Limit to display filter
- Choose the retransmission message and Prepare as a filter + AND

### Using time

- Follow TCP stream
- Show packets only from source
- Search for the gaps
- View > Time display format > Seconds since previous displayed packet, not captured
- Statistics > TCP stream graphs > Stevens

## Features

- Select any fields and Apply as a column
- On the right intellifent bar - to find trouble spots
- Lower window - hex dump - we can display it as bits as well
- Layout can be changed in Preferences
- Right click on the field and select Statistics > Flow Graph
- Upper menu - Analyze > Display Filter expression
- Statistics > Protocol Hierarchy
- Statistics > Conversations
- Statistics > Endpoints
- Expert info console - circle left lower corner
- Analyze latency - Stevens graph - Statiscics > TCP Streams
- Use time values to identify gaps and latency
- Export objects-pictures from HTTP flow
- Coloring rules in View menu
- Separate telephony analysis - we can play dialogues via SIP streams

## Display filters

**Search text in whole frame**  
`frame contains text`  

**Search HTTP replies on certain request**  
`http.response_for.uri == "http://secure.eicar.org/eicar.com.txt"`  

**Show SYN packets only**  
`tcp.flags.syn==1 && tcp.flags.ack==0` 

**Show retransmission packets for TCP stream**
`(tcp.stream eq 68) && (tcp.analysis.retransmission)`

## Tshark

**Show only dst IP addressess for request from particular IP to https sites**

```
tshark -T fields -e ip.dst -f "tcp and dst port 443 and src 10.10.10.1"
```

## TCP

- Stream Index - Wireshark field for tracking streams
- Relative sequence numbers are used
- TCP checksum is not verified - it is disabled by default, because if we enable it, checksum will be incorrect
