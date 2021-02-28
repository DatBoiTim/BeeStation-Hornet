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

/*
	* Address are only 2 octets to save space. If more than 256^2 devices exist something is already very wrong
	* This is as far as we felt apropriate
	* in actuality this ranges from 0-255
	*/
/datum/component/address
	var/list/address = list(0, 0) //Each Num Value separated by a comma represents an octet

//Turns the list into a string
/datum/component/address/proc/addressToString()
	var/addressAsString = ""
	for(var/i in src.address)
		addressAsString += src.address[i] //Appends Each Entry in address.address to addressAsString
		if(src.address[i+1]) //Checks if there is a next entry, appends a '.' to addressAsString if there is a next entry. Allows for proper IP-like address format
			addressAsString += "."
	return addressAsString

/datum/component/interface //Parent Class for Interfaces
	var/obj/connectedDevice //The Device which the interface is attached to
	var/datum/component/address/A //Interface Address

/datum/component/interface/wired
	var/datum/powernet/P //Powernet Connected. We all love PoE, it's time for EoP

/datum/component/interface/wireless
	var/datum/radio_frequency/radio_connection
