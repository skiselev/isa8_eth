# ISA 8-Bit Ethernet Controller
ISA 8-Bit Ethernet Network Interface Controller

## Introduction
ISA 8-Bit Ethernet Controller is an open source network interface controller (NIC) card, designed specifcally to be used in computers with 8-bit only ISA (aka XT) bus, such as IBM* PC, IBM* PC XT, various PC/XT compatibles, for example [Micro 8088](https://github.com/skiselev/micro_8088) system. It is based on Realtek RTL8019 ethernet controller and is NE2000-compatible.

![ISA 8-Bit Ethernet - Assembled Board](images/ISA8_Ethernet-Assembled_Board_Mid_Res.jpg)

## Specifications
* ISA 8-bit interface (62 pin / card edge)
* NE2000 compatible
  * Note: Popular Crynwr NE2000 pocket driver does not support NE2000 in 8-bit slots. Please use a patched driver instead
* Supports configuration using switches, jumperless configruaiton using RSET8019 utility or PnP
  * Uses DIP switches instead of jumpers for reliablity and ease of configuration
* Boot ROM support
  * Socket supports 512 KiB Flash ROM, such as SST/Microchip 39SF040
  * Can be configured in 16 KiB, 32 KiB, 64 KiB, or page mode. In page mode the entire 512 KiB are accessible through a 16 KiB window
  * Also compatible with other DIP 32-pin Flash ROMs, such as 128 KiB 39SF010A, and 256 KiB 39SF020, or similar
  * 40-pin memory extension connector allows connecting up to 4 MiB of memory that can be used in page mode

## Hardware Documentation

### Schematic and PCB Layout

[Schematic - Version 1.0](KiCad/ISA8_Ethernet-Schematic-1.0.pdf)

[PCB Layout - Version 1.0](KiCad/ISA8_Ethernet-Board-1.0.pdf)

### Building Instructions

* Clean the PCB with alcohol
* Apply fluid flux to SMD components pads
* Solder U1 RTL8019 IC
* Solder R1 - R7 resistors and RN1 - RN4 resistor arrays
  * Note that RN1 - RN3 are only required if using DIP switches for configuration. They are not required for jumperless configuration
* Solder C1 - C8 ceramic capacitors
* Solder C9 and C10 tantalum capacitors
* Solder Y1 crystal
* Program U3 EEPROM
  * Make sure to use unique MAC address
* Solder U3 EEPROM
* Optional: Solder SW1 - SW4 DIP switches and U2 IC socket
* Solder J1 Ethernet jack with integrated magentics
* Clean the remaining flux with alcohol
* Test the board

### Switches and Connectors

### Bill of Materials - Version 1.0

[ISA 8-bit Ethernet project on Mouser.com](https://www.mouser.com/ProjectManager/ProjectDetail.aspx?AccessID=xxxxxxxxxx) - View and order all components except of the PCB and the Realtek RTL8019 IC.

[ISA 8-bit Ethernet project on OSH Park](https://oshpark.com/shared_projects/xxxxxxxx) - View and order the PCB.

Component type     | Reference | Description                       | Quantity | Possible sources and notes 
------------------ | --------- | --------------------------------- | -------- | --------------------------
PCB                |           | ISA 8-bit Ethernet PCB - Version 1.0  | 1   | Buy from my Tindie store: [ISA 8-bit Ethernet PCB, and optionally a preprogrammed EEPROM](https://www.tindie.com/products/weird/isa8-eth-pcb), or order from a PCB manufacturer of your choice using provided Gerber or KiCad files

## Red Tape

### Licensing

ISA 8-bit Ethernet is an open source hardware project certified by [Open Source Hardware Association](https://www.oshwa.org/), certification UID is [USxxxxxx](https://certification.oshwa.org/usxxxxxx.html). The hardware design itself, including schematic and PCB layout design files are licensed under the strongly-reciprocal variant of [CERN Open Hardware Licence version 2](license-cern_ohl_s_v2.txt). Documentation, including this file, is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License](license-cc-by-sa-4.0.txt).

![CERN-OHL-2.0-S, CC-BY-SA-4.0](images/CERN-OHL-2.0-S_CC-BY-SA-4.0.svg)
