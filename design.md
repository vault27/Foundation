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
- 
