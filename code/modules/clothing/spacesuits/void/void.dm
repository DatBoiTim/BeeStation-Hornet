//NASA Voidsuit
/obj/item/clothing/head/helmet/space/void
	name = "void helmet"
	desc = "A high-tech dark red space suit helmet. Used for AI satellite maintenance."
	icon_state = "void"
	item_state = "void"

	heat_protection = HEAD
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 20)
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT

	light_overlay = "helmet_light"

/obj/item/clothing/suit/space/void
	name = "voidsuit"
	icon_state = "void"
	item_state = "void"
	desc = "A high-tech dark red space suit. Used for AI satellite maintenance."
	slowdown = 1
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 20)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT

	//Breach thresholds, should ideally be inherited by most (if not all) voidsuits.
	breach_threshold = 18
	can_breach = 1
