PROCESSING_SUBSYSTEM_DEF(networks)
	name = "Networks"
	priority = FIRE_PRIORITY_NETWORKS
	wait = 1
	stat_tag = "NET"
	flags = SS_KEEP_TIMING
	init_order = INIT_ORDER_NETWORKS
	var/assignment_address = ADDRESS_RESTRICTED_FLOOR
	var/list/networks_by_id = list()				//id = network
	var/list/interfaces_by_address = list()				//hardware id = component interface
	var/resolve_collisions = TRUE

/datum/controller/subsystem/processing/networks/proc/register_interface(datum/interface/D)
	if(!interfaces_by_address[D.address])
		interfaces_by_address[D.address] = D
		return TRUE
	return FALSE

/datum/controller/subsystem/processing/networks/proc/unregister_interface(datum/interface/D)
	interfaces_by_address -= D.address
	return

/datum/controller/subsystem/processing/networks/proc/get_next_address()
	var/string = "[num2text(assignment_address++, 12)]"
	return make_address(string)

/datum/controller/subsystem/processing/networks/proc/make_address(string)
	if(!string)
		return resolve_collisions? make_address("[num2text(rand(ADDRESS_RESTRICTED_FLOOR, 65535), 12)]"):null
	var/hex = rustg_hash_string(RUSTG_HASH_MD5, string)
	if(!hex)
		return		//errored
	. = "[copytext_char(hex, 1, 9)]"		//16 ^ 8 possibilities I think.
	if(interfaces_by_address[.])
		return resolve_collisions? make_address("[num2text(rand(ADDRESS_RESTRICTED_FLOOR, 65535), 12)]"):null
