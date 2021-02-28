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
* datagram
* datagramHeader
* packet
* Helper Procs
*/

/datum/component/packet //The base of everything sent. Datagrams only determine how everything in a packet is formatted. This is the juicy shit that we actually care about when transmitting.
	var/datum/component/datagram/D

/datum/component/datagram //Basically IPv4 Datagram
	var/datum/component/datagramHeader/H
	var/data

/datum/component/datagramHeader //Basically the IPv4 Header. Some things omitted because why would we need them
	var/hlen = 0 //Header Length
	var/service = 0 //Service Number Designed to determine type of Service, probably unchanged
	var/list/flags = list() //this is going to be a list of all applied flags
	var/upl = 0 //Upper Layer Protocol. This is by default ICMP
	var/srcAddy //Source Address
	var/dstAddy //Destination Address

/datum/component/datagramHeader/proc/setHLEN() //Calculates and Sets HLEN to the total length of the header. Does not Return the Length
	var/totalHeader = ""
	totalHeader += src.service
	for(var/i in src.flags)
		totalHeader += src.flags[i]
	totalHeader += src.upl
	totalHeader += src.srcAddy
	totalHeader += src.dstAddy
	src.hlen = totalHeader.length

/datum/component/datagramHeader/proc/calculateHLEN() //Calculates and Returns HLEN
	var/totalHeader = ""
	totalHeader += src.service
	for(var/i in src.flags)
		totalHeader += src.flags[i]
	totalHeader += src.upl
	totalHeader += src.srcAddy
	totalHeader += src.dstAddy
	return totalHeader.length
