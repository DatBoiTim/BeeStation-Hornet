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
* VOIP
* ICMP
* Address Resolution(DNS)
* Simple Auth
* Terminal Data
* Program Reserved Protocols
*/
/datum/component/service
	var/name = "Service"
	var/opCode = -1 //This should never be an actually used opcode
