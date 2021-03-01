/******************************************************
* ----------------------BSNet--------------------------
* Initially Designed by: DatBoiTim and Francinum
* Original Repository: Beestation/Beestation-Hornet
* Project Started: 2/28/2021
* BSNet: Designed to replace TComms and NTNet
******************************************************/

/*
* Datagram Datums
* Contains:
* packet
* helperprocs
*/

/datum/component/packet //Basically IPv4 Datagram just really stripped down to the essentials
	var/datum/component/address/S //Source Address
	var/datum/component/address/D //Destination
	var/list/data = list( //All Placeholder for now. Will revisit when everything exists
		data["flags"], //Flags for delivery - Test Value
		data["protocol"], //Determines Protocol - Test Value
		data["type"], //Data Type from Protocol
		data["data"]//The actual data itself
	)

/*
* Interface Datums
* Contains:
* interface
* wiredInterface
* Powernet connection procs
* wirelessInterface
* helperprocs
*/

/datum/component/interface //Parent Class for Interfaces
	var/obj/connectedDevice //The Device which the interface is attached to
	var/address //Maximum address size is 65535. Any positive integer between 0 and this is valid. Addresses are actually technically assigned to the interface and not the device, hence it is here.

/datum/component/interface/wired
	var/datum/powernet/P //Powernet Connected. We all love PoE, it's time for EoP

/datum/component/interface/wireless
	var/datum/radio_frequency/radio_connection
