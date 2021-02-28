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

/datum/component/datagram //Basically IPv4 Datagram just really stripped down to the essentials
	var/datum/component/address/S //Source Address
	var/datum/component/address/D //Destination
	var/list/data = list( //All Placeholder for now. Will revisit when everything exists
		"flags", //Flags for delivery
		"protocol", //Determines Protocol
		"type", //Data Type from Protocol
		"data" //The actual data itself
	)

/*
* Interface Datums
* Contains:
* address
* interface
* wiredInterface
* Powernet connection procs
* wirelessInterface
* helperprocs
*/

/datum/component/address
	var/list/address = list(0, 0)
	/*
	* Address are only 2 octets to save space. If more than 256^2 devices exist something is already very wrong
	* This is as far as we felt apropriate
	* in actuality this ranges from 0-255
	*/
/datum/component/interface //Parent Class for Interfaces
	var/obj/connectedDevice //The Device which the interface is attached to
