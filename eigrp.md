# EIGRP

## History

## RFC

## Concepts

- Enhanced Interior Gateway Routing Protocol 
- Advanced distance vector protocol
- DUAL algorithm - diffusing update algorithm
- Named and classic configuration modes
- Autonomous systems numbers are used
- Wild card is used in network command
- Precalculated loop-free backup paths
- A router can run multiple EIGRP processes. Each process operates under the context of an autonomous system, which represents a common routing domain. Routers within the same domain use the same metric calculation formula and exchange routes only with members of the same autonomous system. Do not confuse an EIGRP autonomous system with a Border Gateway Protocol (BGP) autonomous system
- Each EIGRP process correlates to a specific autonomous system and maintains an independent EIGRP topology table
- EIGRP uses Split Horizon rules on most interfaces by default, which impacts exactly which topology data EIGRP sends during both full and partial updates
- Forming neighbor relationships > neighbor table > EIGRP topology table > routing table
- Unequal-cost load balancing
- Support for networks 255 hops away
- EIGRP uses much simpler topology data than does OSPF, does not need to run the complex Shortest Path First (SPF) algorithm
- To send the Updates, EIGRP uses the Reliable Transport Protocol (RTP)
- On point to point links acknowledging each Update with an ACK
- On multiaccess data links, EIGRP typically sends Update messages to multicast address 224.0.0.10 and expects a unicast EIGRP ACK message from each neighbor in reply
- Transport: IP protocol type 88
- Hello interval - sends HELLO on all enabled inetrfaces
- Hold timer - router receives none from neighbor
- Updates: 224.0.0.10 multicast, or unicast
- Full updates during first connection, then partial
- Authentication: only MD5
- VLSM/classless
- Route tags support
- Different next hop field is possible
- Manual route summarization at any point
- Automatic summarization on classfull network boundries
- Multiprotocol: IPX, Apple Talk, IPv4, IPv6
- However, with auto-summary enabled, EIGRP acts like classful routing protocols in one specific way: They do not support discontiguous networks. To support discontiguous networks with EIGRP, simply disable auto-summary

## Metric

- Metric: constrained bandwidth + cumulative delay, optionally: load + reliability
- The less the metric the better
- Feasible distance - metric based on neighbor's data + local parametres: bandwidth, delay - metric value for the lowest-metric path to reach a destination - best path!
- Reported distance - metric based on data, received from neighboor: bandwidth+delay
- FD is always bigger then RD
- RD is always equal to neighbor's FD
- Feasibility condition: For a route to be considered a backup route, the RD received for that route must be less than the FD(best route) calculated locally. This logic guarantees a loop-free path

FD example:  

```
R1 ---256----R3----256-----R4-----2816----Host(10.4.4.0/24)
```

The FD calculated by R1 for the 10.4.4.0/24 network is 3328  
RD in this case: R3 advertises the 10.4.4.0/24 prefix with an RD of 3072. R4 advertises the 10.4.4.0/24 to R3 with an RD of 2816  

Convergence can be optimized via 3 methods:

- Using feasible successors
- Stub routers
- Summary routes

Successor/Feasible successor: or each prefix/prefix length, when multiple possible routes exist, the router chooses the route with the smallest integer metric (smallest FD). EIGRP defines each such route as the
successor route for that prefix, and EIGRP defines the next-hop router in such a route as the successor. EIGRP then creates an IP route for this prefix, with the successor as the
next-hop router, and places that route into the IP routing table. If more than one possible route exists for a given prefix/prefix length, the router examines these other (nonsuccessor) routes and asks this question: Can any of these routes be used immediately if the currently best route fails, without causing a routing loop? EIGRP   runs a simple algorithm to identify which routes could be used without causing a routing loop, and EIGRP keeps these loop-free backup routes in its topology table. Then, if the successor route (the best route) fails, EIGRP immediately uses the best of these alternate
loop-free routes for that prefix. EIGRP calls these alternative, immediately usable, loop-free routes feasible successor routes, because they can feasibly be used as a new successor route when the current successor route fails. The next-hop router of such a route is called the feasible successor.

## Stub router

- To reduce amount of queries we can configure branch routers as stub routers
- Then other EIGRP routers will not send queries to them
- Stub routers still form neighborships, even in receive-only mode
-

Configuration

```
router eigrp 1
    eigrp stub connected | summary | static | leak-map | redistributed | receive only
```

To show that your peer router is stub command is used:

```
WAN1# show ip eigrp neighbors detail
```

## Summary routes

- In addition to EIGRP stub routers, route summarization also limits EIGRP Query scope and therefore improves convergence time. 
- The reduction in Query scope occurs because of the following rule:
- If a router receives an EIGRP Query for a prefix/prefix length, does not have an  exactly matching (both prefix and prefix length) route, but does have a summary route that includes the prefix/prefix length, that router immediately sends an EIGRP Reply and does not flood the Query to its own neighbors

## Router ID

- The EIGRP RID is a 32-bit number, represented in dotted decimal
- Use the configured value (using the eigrp router-id a.b.c.d EIGRP subcommand).
- Use the highest IPv4 address on an up/up loopback interface
- Use the highest IPv4 address on an up/up nonloopback interface

The EIGRP show commands seldom list the RID value, and unlike OSPF RIDs, engineers do not need to know each router’s EIGRP RID to interpret the EIGRP topology database. Additionally, although it is best to make EIGRP RIDs unique, duplicate RIDs do not prevent routers from becoming neighbors. The only time the value of EIGRP RIDs matters is when injecting external routes into EIGRP. In that case, the routers injecting the external routes must have unique RIDs to avoid confusion  

## Timers

- Default LAN hold timer - 15s
- The default EIGRP Hold time on interfaces/subinterfaces with a bandwidth of T1 or lower, with an encapsulation type of Frame Relay, is 180 seconds
- Default Hello - 5s
- Timers are configured per interface/subinterface, and per EIGRP process
- Bi-directional Forwarding Detection (BFD) is supported
- 3:1 ratio is a reasonable guideline

```
interface Fastethernet0/1
ip hello-interval eigrp 9 2
ip hold-time eigrp 9 6
```

9 - ASN number

## Configuration

- When an EIGRP network configuration subcommand matches an interface, EIGRP on that router does two things:
    - Attempts to find potential EIGRP neighbors by sending Hellos to the 224.0.0.10 multicast address
    - Advertises the subnet connected to that interface
- If we put "network 192.168.0.0" without mask, it will not work, because it is class C network, and it will include only 192.168.0.X
- To advertise the subnet while disallowing EIGRP neighborships on the interface — an engineer has two main configuration options to choose from:
    - Enable EIGRP on the interface using the EIGRP network command, but tell the router to not send any EIGRP messages on the interface by making the interface passive (using the passive-interface command).
    - Do not enable EIGRP on the interface, and advertise the connected route using route redistribution (and the redistribute connected configuration command)
- Classic Configuration Mode - AS number to identify process, scattered commands between router and interface commands

```
router eigrp as-number
network ip-address [mask]
```

- Named mode
    - All the EIGRP configuration occurs in one location
    - It supports multiple address families (including Virtual Routing and Forwarding [VRF] instances). EIGRP named configuration is also known as multi-address family configuration mode
    - EIGRP named mode provides a hierarchical configuration and stores settings in three subsections:
        - Address Family: This submode contains settings that are relevant to the global EIGRP AS operations, such as selection of network interfaces, EIGRP K values, logging settings, and stub settings
        - Interface: This submode contains settings that are relevant to the interface, such as hello advertisement interval, split-horizon, authentication, and summary route advertisements. In actuality, there are two methods of the EIGRP interface section’s configuration. Commands can be assigned to a specific interface or to a default interface, in which case those settings are placed on all EIGRP-enabled interfaces. If there is a conflict between the default interface and a specific interface, the specific interface takes priority over the default interface
        - Topology: This submode contains settings regarding the EIGRP topology database and how routes are presented to the router’s RIB. This section also contains route redistribution and administrative distance settings
    - EIGRP named configuration makes it possible to run multiple instances under the same EIGRP process
    - Initialize the EIGRP process by using the command router eigrp process-name. (If a number is used for process-name, the number does not correlate to the autonomous system number.)
    - Initialize the EIGRP instance for the appropriate address family with the command address-family {IPv4 | IPv6} {unicast | vrf vrf-name} autonomous-system as-number
    - Enable EIGRP on interfaces by using the command network network mask

Network statement

- Network statement does not add networks to EIGRP topologu table
- Network statement identifies the interface to enable EIGRP on
- It adds the interface’s connected network to the EIGRP topology table
- EIGRP does not add an interface’s secondary connected network to the topology table
- For secondary connected networks to be installed in the EIGRP routing table, they must be redistributed into the EIGRP process

```
#Add explicetly only one interface to EIGRP

Router eigrp 1
    network 10.0.0.10 0.0.0.0
    network 10.0.10.10 0.0.0.0
    network 192.0.0.10 0.0.0.0
    network 192.10.0.10 0.0.0.0

Router eigrp  1
    network 10.0.0.0 0.0.0.255
    network 10.0.10.0 0.0.0.255
    network 192.0.0.0 0.0.0.255
    network 192.10.0.0 0.0.0.255

router eigrp  1
    network 10.0.0.0 0.255.255.255
    network 192.0.0.0 0.255.255.255

# All interfaces
router eigrp  1
    network 0.0.0.0 255.255.255.255
```

