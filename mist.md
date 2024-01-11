# Mist

## Certification

- Juniper Networks Certified Associate, Mist AI
- Juniper Networks Certified Specialist, Mist AI

## Documentation

- https://design.mist.com/
- https://www.mist.com/

## Functions

- Access Points Cloud management
- AI-driven virtual assistant called Marvis which brings patented dynamic packet capture and machine learning technology to automatically identify, adapt and fix network issues
- Bluetooth Low Energy (BLE)-based - ?

## Concepts

- Subscription based, to activate subscription you need an activation code
- 90 days notice of subscription expiration
- We can see orders as well
- If subscriptions expire, you cannot configure anything
- Microservercise: Spark, Storm, Docker, Kafka
- AIFoundation: Marvis, Domain Expertise, Data Science, Data
- Many clouds globally, AWS and Google
- Devices to cloud - 443 + 2200 ports
- Ports to enable on your firewall  - article on mist site
- MSP account - MIST will be managed for you
- https://manage.mist.com
- ep.terminator.mistsys.net - AP reach this site
- Connect laptop instead of AP and access https://ep.terminator.mistsys.net/about for troubleshooting
- No console, no local control, only LED troubleshooting
- Local status page: ap.info, accessible via Browser, for help desk, page name is congurable
- AP config persistence - store config on AP, after reboot it will work
- Mesh networking - DFS scanning - mesh relay - mesh base - configured in APs menu or in device profile - should be enabled on site level - usually 4 relay to 1 base - we cannot chain them - only one hop
- AP replacement - configuration will be copied
- We have to setup the actual WLANs. The APs will not activate their radios if they are not advertising an SSID
- 16 MACs are avilable for BSSID - 16 SSIDs
- Reconnect and reauthorize client - different things
- Hotspot 2.0 - ? 
- WPA-2 PSK with multiple passphrases - multiple PSKs with one SSIDs - no connectivity between devices with different PSK
- Data Rates Otions - why? - compatible, No Legacy, High Density, Custom rates

## Configuration Steps

- Create profile > Create organization > Enable Subscriptions > Create User acconts > Choose region

## Organization

Organisation > Settings

    - ORG ID for API calls
    - Assign to Service Provider
    - Password policy
    - Session Policy
    - Proxy for switch managment
    - Auto Provisioning - autonaming for sites and APs - derive AP name from LLDp port description
    - API tokens
    - Admins + Roles
    - Access to manage and traffic captures for Juniper engineers
    - Integration with Juniper organization account, Teams, Zoom

Objects

- Labels - Many types
- Device Profile
- RF template
- WLAN Template - applied to certain sites or entire org or APs via device profile

### Site

- Created inside Organisation
- Can be added to Groups, then we can apply for example WLAN template to groups
- Variables can be created for it and then used in WLAN template for example as VLAN ID

Site Variables can be used for almost any 
configuration. An example is defining a Radius IP address 
and shared secret:
Variable = {{RADIUS_IP}}
Value = 172.16.1.10
Variable = {{RADIUS_SECRET}}
Value = juniper123
Another example is a site variable that defines the VLAN 
for a particular SSID that can also be applied to the VLAN 
configurations of managed switches and WAN appliances. 
This results in a fully automated and scalable solution that 
automatically sets the correct VLAN value across all 
managed devices.
Juniper Wireless Networks with Mist AI

Objects

- Labels
- WLANs
- Devices: Access Points, Switches
- Users
- Policy

- Create Site in Organization: Organization > Site Configuration
- Add devices to site: Access Points
- All data about connected switch is available
 
## Clients

Clients > Wi-Fi

- Stats
- MAC
- RSSI
- SNR
- Access Point
- VLAN
- BSSID
- Protocol 802.11ax
- Security: WPA2-PSK/CCMP
- BAND
- Channel
- Client insights: events +  Number of Spacial streams in Association Event + Client IP, Mask, Gateway in DHCP success Event + Applications - what client uses: Google, Youtube...
- RX PHY Rate - ?
- TX PHY Rate - ?
- Client's OS
- Traffic Capture
- Speed test
- Reconnect - 1 ping loss

### ?
- Site > Radio Management and then selecting Radio Settings - for default radio settings

### RF template

- Created inside organisation
- Applied to site
- 2.4 settings
- 5 settings
- 6 settings
- Power for every band
- Channel # width for every band
- Channel automatic or mannual for every band
- External antenna gain for each band

### WLAN template

Organisation > Wireless > WLAN Template
Applies to site or Groups or Org
Consists of WLANs, 3rd party tunnels, and Policy
WLANs created in a template are not available separatly

### WLAN

Site > Wireless > WLANs
Or inside WLAn template

SSID
    WPA-2(or3)/PSK, WPA-2(or3)/Enterprise-802.1x), WPA, Multimode PSK, Multimode Emterprise 802.1x, WEP, OWE, Open Access
    VLAN: Tagged, Untagged, Pool, Dynamic - Vlan ID based on Username via Radius
    VLAN ID: 1717
    Geofence - do not alow to connect for clients with weak signal
    Isolation: block traffic between clints in 1 AP or in 1 subnet
 Data rates
- Frequency Band
- VLAN: Tagged, Untagged, Pool, Dynamic
- Guest Portal

### Labels

- Site > Labels - Select a site before creation
- Organization > Labels

Types:

- WLAN
- ...

### Policy

- Site > Policy
- WLAN Template > Policy
- You may block Youtube

### Access Point

- Assigned to site

### Device profile

- Is not required
- WLAN templates
- Band settings are defined by site, but can be overrideen
- Applied to many APs

### Cloud services:

- Wi-Fi Assurance - subscription
- Wired Assurance - subscription
- WAN assurance
- Marvis
- Premium Analytics
- User management
- Asset tracking

### Devices

- Mist edge
- Access Points
- BT11 BLE
- Switches
- WAN routers

### Implementation

Day 0 - connect AP to the cloud
Day 1 - Deploy
Day 2 - Maintenence

### Templates

- WXLAN - SSIDs - main template
- RF - different for different countries
- Device Profile

RRM - resource radio management
Dynamic Packet Capture - when event occurs - for bad events - in Monitor section - you can download it - or you can Analyze it in CLoudshark

### APIs

- Webhook
- Web?
- ?

### Data plane

- To access switch
- To central MIST edge device: on-premise
- Some VLANs can be localy bridge and some to MIST edge

## Onboard the AP

- Activation code
- QR code + MISt app

## Client onboarding

- For BYOD devices
- 

## MIST Edge

- Tunnel termination device
- One arm: traffic comes from all APs via tunnel to MIST and MMIST sends traffic back to distribution switches
- Two arm: APs are connected to one interface and distribution switch via another
- One MIST edge for organization - located in data center for example
- It can also be used to extend corporate wi-fi network to home
- L2TP tunnels from APs to Edge
- Linux box or VM
- MIST Edges section
- It may be Primary and secondary - ?
- Downstream interfaces to APs
- Upstream interfaces to outside
- If several interfaces are chosen for Upstream or Downstream - it forms LAG automatically
- Upstream and downstream can be the same interfaces
- Upstream port can be configured as VLAn tagged
- Upstream port can go to firewall
- Edge can be configured on Org level and Site level
- It can act as Radius proxy
- We go the site and add a tunnel
- In WLAN or WLAn template options we confiure Custom Forwarding + which VLANs localy forwareded and which to tunnel
- Beside NIST Edges we create tunnels in the same section
- Auto preemtprion
- Anchor MIST tunnel - ?
- IPSec support
- DHCP relay
- Autopreemption
- Upstream monitoring
- Installation: Organization > Mist Edges - ?
- We can log in locally via console: user: pass: Mist@1234, root pass for su: mist

## Guest portal

7 auth options

- No authorization
- Passphrase
- Auth code from email or text
- Sponsored guest
- Social login
- External portal
- Third party SSO

Sites > WLANs > WLAN name > Custom Guest Portal
Or inside WLAN Template > WLAN

Sponsored guest: user connects to wi-fi, immediately gets captive portal, fill the details, specifies his email and sponsor email. Sponsor gets email and inside it clicks Approve or Deny Access for this Wi-Fi user, after this wi-fi user gets access to the internet. :)

## WXLAN policy

- Allow or block users to certain resources
- WLAN, site level, Org level - ?
- If we block Bittorent, everything else will be allowed - allow all implicit rule
- If we allow something - it will deny everythin else?
- First match rule principle

### BYOD—Multiple PSK Setup

- Site > Wireless > Preshared keys
- You create PSK for certain WLAN and send it to user's email

### Security

- Rogue AP - Installed on network, public auth - personal employee hotspot
- Neighbor AP - is not a threat, nearby office
- HoneyPot AP - not connected to network, copies your SSID, goal - spoof logins
- Scanniing radio - for finding bad AP
- In MIST: Site > Security - shows all bad APs
- Detect bad APs is enebled in Site configuration
- Auto drop clients whoa failed auth 4 times

### SLEs

- Service Level Expectations
- Monitor > Service Levels
- Some SLEs use user minutes

Metrics:

- Time to connect
- Successfull connects
- Coverage
- Roaming
- Throughput
- Capacity
- AP Healtth

### Mist events and alerts

- Site event
- AP event
- Client event

Site event

- Analytics > Events
- AP cloud connectivity
- Client's DNS and DHCP connectivity

AP events

- Can be seen in Marvis
- RANK APeventtypes by apeventcount

Alerts

- Monitor > Alerts

### Traffic capture

- Site >  Capture Packets
- Client, WLAN, AP, Band - everything can be chosen to configure capture

### RRM - ?

- Radio Resource Management
- Dual band- ?
- Site > Radio Management

### DFS - ?

### Dashboard reports

Analytics > Network Analytics

- Entire Org, Site, Ap....
- Bytes, active clients..
- Only 30 days of storage
- If you need more - Premium Analytics

### Marvis

- No natural language
- Only Querry language

### Location services

- Virtual Bluetooth - vBLE
- RTLS - real time location services
- Way finding

Position Estimation Algorithms

- Cell-of-Origin - nearest neighbor
- Trilateration
- Triangulation
- Fingerprinting

Mist  Location options

- Wi-Fi
- BLE Asset Visibility - requires subscription
- vBLE Engagement

BLE Array Beams

### User engagement and proximity tracing

Location section
    Live view - We can see on a building map where users are located
    Location Diagnostics
    RF Environment Replay
We import floorplans
Generate proximity zones
