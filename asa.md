# ASA

## Cisco Secure Desktop and DAP

- DAP - Dynamic Access Policy
- For example we can block all Win7 machines connecting via VPN
- There are a lot criteria we may define and a lot of actions we can configure
- We also can restrict browsing, file servers etc... configure ACLs
- Basic Host scan: OS, files, Registry, Address, Certificates
- Advanced Endpoint assesment: antivirus, antispyware, personal firewall and probably remediation

## AnyConnect profiles

- Local AnyConnect Profiles - XML and profile files are stored locally to the users machine. The location varies based on OS.
- Windows XP - %ALLUSERSPROFILE%\Application Data\Cisco\ Cisco AnyConnect Secure Mobility Client\Profile
- Windows Vista - %ProgramData%\Cisco\Cisco AnyConnect Secure Mobility Client\Profile
- Windows 7 - %ProgramData%\Cisco\Cisco AnyConnect Secure Mobility Client\Profile
- Mac OS X - /opt/cisco/anyconnect/profile
- Linux - /opt/cisco/anyconnect/profile

## Network Access manager

- Win 7 - C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Network Access Manager\newConfigFiles