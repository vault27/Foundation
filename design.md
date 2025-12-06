# Design

- Network Design Techniques
- Network Design Principles
- Network Design Fundamentals

## Network Design Fundamentals

These are `foundational` elements

- Mindset
- Requirements
- Design use cases
- The business
- Constraints
- Why

### Mindset

- You need to have design mindset
- Implementation mindset will not work

### Requirements

Functional requirements

- What system will delivery to the business from technological point of view
- Find and document functional requirements - designers responsibility

Technical requirements

- These are non functional requirements
- Provide details about security, availability and integration
- They are very dynamic, change often
- Example 1: support high level of network availability: FHRP
- Example 2: Support integratioon with network services: Netflow
- They help to specify features and protocols, software versions which support them

Application requirements

- End users: customers, internal users, business partners
- Network should deliver the desired level of user expectation
- Application requirements can generate functional requirements

+Unstated requirements

### Design use cases

- Greenfield - from scratch
- Brownfield - Production environment already exists
- Add technology or application 
- Replace technology
- Merge or divest different networks - one of the most difficult
- Scaling a network
- Design failure - when you are asked to fix - example: STP root bridge and FHRP active device are different devices

### The buisiness

- We do design for business to make money

### Constraints

- Business constarints - budjet, staff...
- Application constraints - mandatory L2, hard coded IPs....
- Technology constraints - vendor

Some of main constraints

- Cost
- Time
- Location - no fiber on site
- Infrastructure
- Staff expertise

## Network Design Principles

- Security
- Scalability
- Availability
- Cost
- Manageability

### Security

- Perimeter security - turtle shell - legacy - firewall on perimeter - east-west is not limited
- Session and transaction based security - 100% authentication and 100% authorization  - ?
- Zero Trust Architecture - AI - Every device, user, application, server, service is assigned a trust score

### Availability

- Redundancy - multiple resources doing the same role
- Resilience - the ability of network to automatically failover
- Reliability - how much data passes network without loses
- The more availability - the more complexity and cost
- Main goal is app and service availability
- Network is a plumbing
- Availability requirements are unstated by the customer
- You need to talk to app developers and understand what it is dependent on

### Manageability

- Keep it super simple
- Do not create networks which require CCIE
- Your design should be managed by staff who operates the networks

### Scalability

- Grow with business

### Cost

- Not only money - personel, time, technical cost

## Network design techniques

- Failure isolation - large l2 domain is dangerous - we may connect hub and generate 
- Can be done in every network protocol

## RA VPN

- Where to put VPN termination device
    - `Internet > VPN server > Firewall > Core`
    - `Internet > VPN server > Core`
    - `Internet > Firewall > VPN Server (DMZ) > Firewall > Core`
- How it wil propogate routes to VPN IP pools? Routing protocol? NAT?
- How user will be authenticated?
- Split tunneling?
- Firewall rules
- Number of simulteneous VPN connections
- Bandwidth
- Two factor authentication
- Protocol used - SSL or IPSec.
- Differentiated access—The remote access VPN is configured to provide different access policies depending on assigned user roles.
- Strong encryption for data privacy—The Advanced Encryption Standard (AES) cipher with a key length of 256 bits is used for encrypting user data. Additional ciphers are also supported.
- Hashing for data integrity—The Secure Hash Standard 1 (SHA-1) cryptographic hash function with a 160-bit message digest is used to ensure that data has not been modified during transit.
- Internet link resiliency—A backup server reachable through the secondary ISP is configured in the AnyConnect client profile. This backup server is automatically used if the primary server is not reachable.
- Default route via corporate Firewall/IPS for remote users
- User groups which are allowed to access VPN
