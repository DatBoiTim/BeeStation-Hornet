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

/datum/packet //Basically IPv4 Datagram just really stripped down to the essentials
	var/srcAddress //Source Address
	var/dstAddress //Destination
	var/list/data = list()

//Standard Args Constructor
/datum/packet/New(argSRCAddress, argDSTAddress, argFlag, argProtocol, argType, argData)
	srcAddress = argSRCAddress
	dstAddress = argDSTAddress
	//Associative fields for data
	data["flags"] = argFlag
	data["protocol"] = argProtocol
	data["type"] = argType
	data["data"] = argData

//Copy Constructor
/datum/packet/New(datum/packet/P)
	srcAddress = P.srcAddress
	dstAddress = P.dstAddress
	data["flags"] = P.data["flags"]
	data["protocol"] = P.data["protocol"]
	data["type"] = P.data["type"]
	data["data"] = P.data["data"]

/*
* Interface Datums
* Contains:
* interface
* wiredInterface
* Powernet connection procs
* wirelessInterface
* helperprocs
*/

/datum/component/interface //Parent Class for Interfaces. Despite identical fields, this is a non-functional interface due to inheritance reasons
	var/obj/connectedDevice //The Device which the interface is attached to
	var/datum/radio_frequency/RF //Apparently this needs to exist for all, I just have to determine the transmission media
	var/address //Maximum address size is 65535. Any positive integer between 0 and this is valid. Addresses are actually technically assigned to the interface and not the device, hence it is here.

//Standard Args Constructor
/datum/component/interface/New(obj/D, datum/radio_frequency/R, addy)
	connectedDevice = D
	RF = R
	SSradio.add_interface(src, RF)
	address = addy

//Send Signal
/*
* Constructs a Packet, Packages Packet in a Signal, Posts the Signal
*/
/datum/component/interface/proc/send_packet(destination, packFlag, packProtocol, packType, packData, signalTranMethod=1, range=-1)
	var/datum/packet/P = new(address, destination, packFlag, packProtocol, packType, packData)
	var/datum/signal/S = new(P, signalTranMethod)
	RF.interface_post_signal(src, S, null, range)

/datum/component/interface/proc/recieve_radio_signal(datum/signal/S)
	var/datum/packet/P
	if(istype(S.data, /datum/packet))
		P = S.data
		world.log<<"Packet Recieved"
	if(P.dstAddress == src.address || P.dstAddress == NETWORK_BROADCAST_ID) //This is where we will pass the packet up to the device
		return P
	else
		return FALSE

/datum/component/interface/wired
	var/datum/powernet/powernet //Powernet Connected. We all love PoE, it's time for EoP

//Standard Args Constructor
/datum/component/interface/wired/New(datum/powernet/P, obj/D, datum/radio_frequency/R,addy)
	powernet = P
	..(D, R,addy)

//Connects Connected Device to the Powernet
/datum/component/interface/wired/proc/connect_to_network()
	var/turf/T = connectedDevice.loc
	if(!T || !istype(T))
		return FALSE

	var/obj/structure/cable/C = T.get_cable_node()
	if(!C || !C.powernet)
		return FALSE

	C.powernet.add_machine(src)
	return TRUE

/datum/component/interface/wired/proc/disconnect_from_network()
	if(!powernet)
		return 0 //No Powernet Connected
	powernet.remove_interface(src)
	return 1 //Powernet Successfully Disconnected

/datum/component/interface/wired/send_packet(destination, packFlag, packProtocol, packType, packData, signalTranMethod=0, range=-1)
	if(src.powernet) //Is it plugged in?
		..(destination, packFlag, packProtocol, packType, packData, signalTranMethod, range)
	else
		return FALSE

/datum/component/interface/wired/recieve_radio_signal(datum/signal/S)
	if(src.powernet) //Is it plugged in?
		..(S)
	else
		return FALSE

/datum/component/interface/wireless //Same Fields But Actually Functional

//Standard Args Constructor
/datum/component/interface/wireless/New(datum/radio_frequency/R, obj/D, addy)
	..(D, R, addy)

/datum/component/interface/wireless/proc/change_freq(datum/radio_frequency/N)
	SSradio.remove_interface(src, RF)
	RF = N
	SSradio.add_interface(src, RF)
