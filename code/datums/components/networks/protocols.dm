/******************************************************
* -----------BSNet Services and Protocols--------------
* Initially Designed by: DatBoiTim and Francinum
* Original Repository: Beestation/Beestation-Hornet
* Project Started: 2/28/2021
* Protocols for: BSNet Suite
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
/datum/protocol
	var/name = "protocol"
	var/opCode = -1 //This should never be an actually used opcode, and is purely a placeholder
	var/list/types = list() //The types of potential data being sent, can be as simple as 0-Request 1-Response, or more complex
	var/list/data = list() //Categories of Data. Formatted

/datum/protocol/icmp //Super Stripped Down Internet Control Message Protocol. Will be used like ICMP is IRL
	name = "ICMP"
	opCode = 1
	types = list(
		0, //Ping Reply
		1, //Ping
	)
	data = list(
		0 = "Identifier" //A text based identifier. Only 1 data type to send
	)

/datum/protocol/dns //Choice Name Resolution Protocol. Does what Name Resolution Protocol does.
	name = "DNS"
	opCode = 2
	types = list(
		0, //Request
		1, //Response
	)
	data = list(
		"hostname", //Name to Resolve
		0 //The Resolved Destination
	)

/*
* Basically a formal request for using your ID card to authenticate an identity
* I never said it had to be *your* identity, so yes this is VBD
*/
/datum/protocol/simpleAuth
	name = "SimpleAuth"
	opCode = 3
	types = list(
		0, //Challenge
		1 //Response
	)
	data = list(
		NULL, //Non Existent, so here is a placeholder
		"ID Info" //assigned_name, assignment, access_csv
	)
//Terminals are 25l x 80 col, VT-320 Spec, line 25 is reserved for local data
/datum/protocol/terminal
	name = "Terminal Data"
	opCode = 4
	types = list(
		0, //Line
		1, //Screen
		2, //Control initiation Code
		3 //Input for further Control
	)
	data = list(
		0, //Line
		1, //Screen
		2, //Control Code
		3 //Variable Length Serial Input
	)

//Protocol OpCodes 5+ are program reserved
