/datum/component/datagram //Basically IPv4 Datagram
	var/datum/component/DatagramHeader/H
	var/data = ""

/datum/component/datagramHeader //Basically the IPv4 Header. Some things omitted because why would we need them
	var/hlen = 0 //Header Length
	var/service = "" //Service
	var/dglen = 0 //Datagram Length, Not In Bytes. This is basically going to be a
	var/list/flags = list() //Flags
	var/upl = ""//Upper Layer Protocol
	var/srcAddy //Source Address
	var/dstAddy //Destination Address

/datum/component/datagramHeader/proc/calculateAndSetHeaderLength()
	var/totalHeader = ""
	totalHeader += src.service
	totalHeader += src.dglen
	for(var/i in src.flags)
		totalHeader += src.flags[i]
	totalHeader += src.upl
	totalHeader += src.srcAddy
	totalHeader += src.dstAddy
	src.hlen = totalHeader.length
