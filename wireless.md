# Wireless

mcsindex.com

What is the RX MCS?
In the example from step 3.7, the protocol is 802.11ax, the channel width is 40 MHz, and the spatial streams are 2, which narrows the possibility to the section of the table under "OFDM (802.11ax)", and under "40MHz" and limited to 2 spatial streams. Because the client's RX PHY Rate is 541.6 Mbps, the RX MCS is 11.

mDNS - ?

SSDP - ?

DTIM period - ?

4x4:4:ss - ?

Different POE versions - ?

6 Ghz requires many power and needs cool PoE
PoE
PoE+ - 802.3at
...

If you want to prefer 5 Ghz over 2.4, you need to configure it more powerfull on access point.

When setting a range, your minimum power should use the base power of the design. The maximum power is typically +3 dBm, but may go up to +6 dBm based on the scenario. Here, for example, our values are a 
minimum of 8 and a maximum of 11 for 2.4GHz and for 5GHz, a minimum of 14 and a maximum of 17. Mist’s RRM system will now work within these boundaries BSSID - Basic Service Set - MAC of AP - Unique Extended service set - 2 WLAN with the same SSID and different BSSID

## Certificates

- CWNA

## Organizations 

- IEEE
- Wi-Fi alliance
- IETF
- CWNP
- WLA

IEEE creates standards > Wi-Fi Alliance certifies Products > IETF manages RFCs > CWNP certifies Individuals > WLA brings together Industry Professionals
  
## Standards

- IEEE 802.11 - physical layer and datalink (MAC sublevel only)
- 802.11-2020 standard - pack of documents
- Wi-Fi 6 - 802.11ax - much faster

## Wi-Fi generations

8 in total

 - Wi-Fi 1 - HR - 802.11b - 1999
        - Frequency Band - 2.4 Ghz
        - Channel width - 22 MHz
        - Spatial streams - 1
        - Data Rate - 1,2,5.5,11 Mbps
        - MIMO - No
        - MU-MIMO - No
        - Max Modulation - QPSK
        - Subcarrier size - n/a
        - Symbol Duration - n/a
        - Guard Interval - n/a
        - OFDMA - No 
- Wi-Fi 2 - OFDM - 802.11a - 1999
        - Frequency Band - 5 Ghz
        - Channel width - 20 MHz
        - Spatial streams - 1
        - Data Rate - Up to 54 Mbps
        - MIMO - No
        - MU-MIMO - No
        - Max Modulation - 64 QAM
        - Subcarrier size - 312.5
        - Symbol Duration - 3.2 us
        - Guard Interval - 0.8 us
        - OFDMA - No 
- Wi-Fi 3 - ERP - 802.11g - 2003
        - Frequency Band - 2.4 Ghz
        - Channel width - 20 MHz
        - Spatial streams - 1
        - Data Rate - Up to 54 Mbps
        - MIMO - No
        - MU-MIMO - No
        - Max Modulation - 64 QAM
        - Subcarrier size - 312.5
        - Symbol Duration - 3.2 us
        - Guard Interval - 0.8 us
        - OFDMA - No
- Wi-Fi 4 - HT - 802.11n - 2009
        - Frequency Band - 2.4/5 Ghz
        - Channel width - 20/40 MHz
        - Spatial streams - 4
        - Data Rate - Up to 600 Mbps
        - MIMO - Yes
        - MU-MIMO - No
        - Max Modulation - 64 QAM
        - Subcarrier size - 312.5
        - Symbol Duration - 3.2 us
        - Guard Interval - 0.8, 0.4 us
        - OFDMA - No
- Wi-Fi 5 - VHT - 802.11n - 2014
        - Frequency Band - 5 Ghz
        - Channel width - 20/40/80/160 MHz
        - Spatial streams - 8
        - Data Rate - Up to 6.933 Gbps
        - MIMO - Yes
        - MU-MIMO - DL
        - Max Modulation - 256 QAM
        - Subcarrier size - 312.5
        - Symbol Duration - 3.2 us
        - Guard Interval - 0.8, 0.4 us
        - OFDMA - No
- Wi-Fi 6 - HE - 802.11ax - 2020
        - Frequency Band - 2.4/5 Ghz
        - Channel width - 20/40/80/160 MHz
        - Spatial streams - 8
        - Data Rate - Up to 9.6 Gbps
        - MIMO - Yes
        - MU-MIMO - DL & UL
        - Max Modulation - 1024 QAM
        - Subcarrier size - 78.125
        - Symbol Duration - 12.8 us
        - Guard Interval - 0.8, 1.6, 3.2 us
        - OFDMA - Yes
- Wi-Fi 6E - HE - 802.11ax - 2020
        - Frequency Band - 6 Ghz
        - Channel width - 20/40/80/160 MHz
        - Spatial streams - 8
        - Data Rate - Up to 9.6 Gbps
        - MIMO - Yes
        - MU-MIMO - DL & UL
        - Max Modulation - 1024 QAM
        - Subcarrier size - 78.125
        - Symbol Duration - 12.8 us
        - Guard Interval - 0.8, 1.6, 3.2 us
        - OFDMA - Yes
- Wi-Fi 7 - EHT - 802.11be - 2024
        - Frequency Band - 2.4/5/6 Ghz
        - Channel width - 20/40/80/160/320 MHz
        - Spatial streams - 16
        - Data Rate - Up to 40 Gbps
        - MIMO - Yes
        - MU-MIMO - DL & UL
        - Max Modulation - 4096 QAM
        - Subcarrier size - 78.125
        - Symbol Duration - 12.8 us
        - Guard Interval - 0.8, 1.6, 3.2 us
        - OFDMA - Yes

## Frequencies


## RF basics

- Wave - alternating current changes in time - sin wave
- Wave length -
- Frequency - number of cycles (oscilaltions)  per second - 1 hz is 1 Cycle per second
- Amplitude - positive alteration and negative alteration
- Amplitute - maximum magnitude or strength of the signal - measured in decibels referenced to one milliwatt (dBm).A positive dBm value indicates a signal with higher amplitude, while a negative dBm value indicates a weaker signal.
- Two absolutely identical waves - they are in phase - together they will provide better amplitude and qulity of signal
- We can add phase difference - and the will be out of phase
- Phase difference is measured in degrees
- 180 degrees phase difference: 2 waves will cancell each over
- Power is measureed in Watts - The power level of an RF signal determines its range, coverage, and ability to penetrate obstacles. A higher wattage generally indicates a stronger signal that can travel over longer distances or through more obstacles.
- Wifi signals are measured in Miliwatts
- Measure in dBm is easier - dB ?
- 0 dBm = 1 mW, 3 dBm = 2 mW - ???
- Isotropic radiotar - radiates power equally in all directions - The Sun
- Gain value is described in dBi
- Inverse square law
- Signal to nose ratio
- QAM - ?
- EVM - ?
- MCS index table - ?
- Dynamic Rate Shifting

## Antenna

- Isotropic Radiator
- Omni Radiation Pattern
- Antenna always add gain to the signal - ?

## Modulation

A method of encoding data into an RF signal

- Baseband signal - digital signal
- Phase shift Keying - used in Wi-Fi - PSK - BPSK - binary - QPSK
- BPSK - a binary 0 is represented by a carrier signal with a phase of 0 degrees, while a binary 1 is represented by a carrier signal with a phase of 180 degrees. Simple. Good for noisy channels.
- Amplitude Shift Keying - Amplitude is always different - used in Wi-fi
- Frequency Shift Keying - Frequency is always changing
  
DSSS (Direct Sequence Spread Spectrum) and OFDM (Orthogonal Frequency Division Multiplexing) are two different modulation techniques used in wireless communication systems, including Wi-Fi.

## Physical characteristics

- Spectrum
- Channel
- Max modulation

**Spectrum**

Range of frequencies. Wi-Fi operates within specific frequency bands, which are portions of the overall electromagnetic spectrum. Bands are part of the larger radio frequency spectrum. 

**Channel**

Specific frequencies that are used for wireless communication. Each channel has width, for example 2401 - 2423. Each Channel has Center Frequency, for example 2412. Channel can be allowed in one country and prohibited in other.  Selecting appropriate channels within the spectrum helps minimize interference and optimize performance for Wi-Fi networks

## Frequency bands

Upload and download is in turn, one after another, half duplex

Wi-Fi adapters use a technique called "frequency division duplexing" (FDD) to transmit and receive data on the same frequency. FDD allows the adapter to separate the incoming and outgoing signals by utilizing different time slots or subcarriers within the same frequency band.  
Only one device on a channel can send data at a time.

- 2.4
2401 to 2484 MHz. This bandwidth is divided among 14 channels. Each of the WLAN / Wi-Fi Channels are spaced 5 MHz apart, except the last two channels which are spaced 12 MHz apart. Most of these channels (Channel 1 to Channel 11) can be used across the globe, except channels 12, 13 and 14. Channel 12 (2456 - 2478 MHz) and Channel 13 (2461 - 2483 MHz) are not allowed in North America, whereas Channel 14 (2473 - 2484 MHz) can only be used in Japan
22 Mhz for each channel
- 5 Ghz - less range - less crowded
- 6 Ghz
- Adjecent channel Interference
- Transmit Spectrum Mask - ?
- Co channel conention - co channel interference vs  overlapping channels
- OFDM Spectral Mask - ?

## Layer 1

- Measusrment of Layer 1: how often raw radio frequency activity is heard  in the spectrum, measyred wuth spectrum analysis - legacy
- Possible issues: bad radio design
- Spatial stream - it is writeen in the form of 2 by 2 - how many antennas device has, 4 spacial streams max
- SISO - SIngle Input Single Output
- Multipath in wireless - signal goes direct + it bounces from walls
- MIMO - Multiple Input Multiple Output - eliminates the issue with multipath
- Multi user MIMO - MU MIMO
- Spatial multiplexing - can double or triple the data rate
- 3 types of frames
- How many bits I can get form single sin wave
- Guard interval - space beetween symbols - ti avoid inter symbol interference
- OFDM subcarriers - 64 subcarriers per 20 Mhz channel - they can be null, pilot and data - pilot do not carrier data, for sync only
- OFDMA - subdevides channel on smaller blocks

## Tools

- Wi-Fi Exporer Pro 3

## Frame classes

## State machine

How the client connects to the network

- State 1 - unauthenticated and Unassociated - class 1 frames - discover access point - then it goes to authentication - send auth frame
Successfull 802.11 Authentication
- State 2 - authenticated, but not assiciated - client sends its capabilities class 1 and 2 frames
Successfull 802.11 (Re) Association
- State 3 - authenticated and Associated - pending PSNA authentication
Successfull 4-way handshake
- State 4 - Authenticated and Assiciated - Class 1,2,3 Frames

## Distributed coordination function

- Rule 1 - Listen before you talk - if a station can hear another 802.11 transmission, it will defer transmission
- Rule 2 - Be quiet for a while - between every frame transmitting, there must be a minimum period of time  called an Interframe Space
- Rule 3 - Avoid collisions - station will wait for additional amount of time after Interframe Space - amount of time is randomly selected between a contention window's mim and max value

## AP discovery

 - Passive: client listens to beacon frames from AP, every 100 milliseconds, inside beacon - WLAN name and capabilities - AP sends on all channels of band frequency
- Active - Client broadcasts a probe request, directed - with specified SSID,  wildcard - all APs in range, AP will respond with Probe Respond with capabilities

## Roaming

- Client makes a dessicion to roam
- When signal goes lower then -72 db
- Some clients don't roam at at all - sticky clients

## Contention window

The contention window is a range of time slots during which a device waits before attempting to transmit its data. The size of the contention window determines the duration of this wait.

## WLAN Architechture

Autonomous AP > Controller and Lightweight APs > Controller and Intelligent APs > Cloud Managed VLAN

## Channel contention + adcent channel interference

## Reconnect to AP

The AP sends a de-authentication packet to the client. The client then disconnects from the AP and is then immediately authorized and reassociated. The client then gets an IP address through DHCP, ARPs for its gateway, and then performs a DNS query

## RoamS

Fast roam
Slow roam

## DHCP

- Wi-Fi access point does not provide DHCP functionality
- It provides only connectivity to the sub net
- DHCP server or DHCP relay can be anywhere on the subnet: separate server, or router

## 802.11 MAC Frame

Frame types:

- Data
- Managmenet
- Control

Header

- Frame Control - 2 bytes
- Duration/ID - 2 Bytes - how much time I will need to send data
- Address 1 - 6 bytes
- Address 2 - 6 bytes
- Address 3 - 6 bytes

## Security

WPA 3 - management frames encrypted
