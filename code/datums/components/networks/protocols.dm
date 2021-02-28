/******************************************************
* ----------BSNet Services and Protocols---------------
* Initially Designed by: DatBoiTim and Francinum
* Original Repository: Beestation/Beestation-Hornet
* Project Started: 2/28/2021
* Services and Protocols for: BSNet Suite
******************************************************/
/*
* Services and Protocols provided and supported by BSNet
* Includes
* ICMP
* Address Resolution(DNS)
* Simple Auth
* Terminal Data
* Program Reserved Protocols
*/
/datum/component/protocol
	var/name = "protocol"
	var/opCode = -1 //This should never be an actually used opcode, and is purely a placeholder
