# IP fabric
- Physical underlay network
- Also known as a Clos network
- Responsibility to provide unicast IP connectivity from any physical device (server, storage device, router, or switch) to any other physical device
- A typical solution uses two layers—spine and leaf—to form what is known as a three-stage IP fabric, where each leaf device is connected to each spine device
- Five-stage IP fabric: a fabric layer (or “super spine”) to provide inter-pod, or inter-data center, connectivity
- A key benefit of an IP-based fabric is natural resiliency. High availability mechanisms such as MC-LAG or Juniper’s Virtual Chassis technology are not required, as the IP fabric uses multiple links at each layer and device. Resiliency and redundancy are provided by the physical network infrastructure itself
- 
