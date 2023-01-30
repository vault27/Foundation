# Palo Alto

## Portfolio
- Strata - Enterprise Security
- Prisma - Cloud Security
- Cortex - Security Operations

### Strata
- PA-220, PA-800, PA-3200, PA-5200, and PA-7000 Series
- VM-Series
- Panorama

### Prisma
- Prisma Cloud
- Prisma Access Secure Access Service Edge (SASE)
- Prisma SaaS
- VM-Series ML-powered NGFWs

### Cortex
- Cortex XDR
- Cortex XSOAR
- Cortex Data Lake
- AutoFocus

## HA

### Active/Passive
Configuration overview

### Active/Active

### Cluster
Configuration overview
- 2 HA4 interfaces(primary and backup) with type HA, IP address, mask
- On every device add all over devices with serial number, HA4 and HA4 backup IP addresses and sessions sync
- Enable cluster on all devices with the same cluster ID

#### Cluster Session Synchronization States  
- Pending → Synchronization is not triggered yet
- Unknown. → Device Serial Number and Peer IP is configured but session synchronization process has not started yet
- In-Progress  → Full session synchronization is running 
- Completed  → Full session synchronization is completed and new sessions will be synchronized in real time 
- Disabled → Session synchronization is disabled to the member or for HA peer


