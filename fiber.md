# Fiber

## Bidirectional (BiDi) WDM Transceivers

- Sends and receives data via single optical fiber
- Uses WDM (wavelength division multiplexing) 

## DWDM

- You rent on frequency in fiber and send everything you need there

## Troubleshoot SFP

```
qprk-e-cor-swi01-c200#sh int tw1/0/17 transceiver 
ITU Channel not available (Wavelength not available),
Transceiver is internally calibrated.
If device is externally calibrated, only calibrated values are printed.
++ : high alarm, +  : high warning, -  : low warning, -- : low alarm.
NA or N/A: not applicable, Tx: transmit, Rx: receive.
mA: milliamperes, dBm: decibels (milliwatts).

                                             Optical   Optical
             Temperature  Voltage  Current   Tx Power  Rx Power
Port         (Celsius)    (Volts)  (mA)      (dBm)     (dBm)
---------    -----------  -------  --------  --------  --------
Twe1/0/17    26.4       3.32       6.1      -2.2     -29.6   
```

```
qprk-e-cor-swi01-c200#sh int tw1/0/17 transceiver detail 
ITU Channel not available (Wavelength not available),
Transceiver is internally calibrated.
mA: milliamperes, dBm: decibels (milliwatts), NA or N/A: not applicable.
++ : high alarm, +  : high warning, -  : low warning, -- : low alarm.
A2D readouts (if they differ), are reported in parentheses.
The threshold values are calibrated.

                                High Alarm  High Warn  Low Warn   Low Alarm
             Temperature        Threshold   Threshold  Threshold  Threshold
Port         (Celsius)          (Celsius)   (Celsius)  (Celsius)  (Celsius)
---------    -----------------  ----------  ---------  ---------  ---------
Twe1/0/17    27.8                   75.0       70.0        0.0       -5.0

                                High Alarm  High Warn  Low Warn   Low Alarm
             Voltage            Threshold   Threshold  Threshold  Threshold
Port         (Volts)            (Volts)     (Volts)    (Volts)    (Volts)
---------    -----------------  ----------  ---------  ---------  ---------
Twe1/0/17    3.32                   3.63       3.46       3.13       2.97

                                  High Alarm  High Warn  Low Warn   Low Alarm
                 Current          Threshold   Threshold  Threshold  Threshold
Port       Lane  (milliamperes)   (mA)        (mA)       (mA)       (mA)
---------  ----  ---------------  ----------  ---------  ---------  ---------
Twe1/0/17  N/A    6.1                 10.5       10.5        2.5        2.5

                 Optical          High Alarm  High Warn  Low Warn   Low Alarm
                 Transmit Power   Threshold   Threshold  Threshold  Threshold
Port       Lane  (dBm)            (dBm)       (dBm)      (dBm)      (dBm)
---------  ----  ---------------  ----------  ---------  ---------  ---------
Twe1/0/17  N/A   -2.2                  1.7       -1.3       -7.3      -11.3

                 Optical          High Alarm  High Warn  Low Warn   Low Alarm
                 Receive Power    Threshold   Threshold  Threshold  Threshold
Port       Lane  (dBm)            (dBm)       (dBm)      (dBm)      (dBm)
---------  ----  ---------------  ----------  ---------  ---------  ---------
Twe1/0/17  N/A  -29.6                  2.0       -1.0       -9.9      -13.9
```
