# Campus

## Design options

- STP + FHRP
- VSS + LAG
- BGP

## STP + HSRP

- Every access switch is connected to 2 Core cwitches
- 2 Core switches are connected between each other with LAG
- HSRP is configured on both Core switches
- Primary Core switch is root
- STP saves from failure of any link between Access switches and Core Switches, and between 2 Core switches
- HSRP saves from failure of Core Switch on layer 3

## Access layer

- Modular switch vs fixed switches approach
