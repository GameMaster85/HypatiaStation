/obj/item/device/radio/ai
	var/obj/item/device/encryptionkey/keyslot //single encryption key for reusablitiy purposes
	name = "AI internal radio"
	freerange = 1
	canhear_range = 1 //canhear range is AI only

	icon = null
	icon_state = null


/obj/item/device/radio/ai/New()
	..()
	keyslot = new /obj/item/device/encryptionkey/ai()
	recalculateChannels()


/obj/item/device/radio/ai/proc/recalculateChannels()
	src.channels = list()
	src.syndie = 0

	if(keyslot)
		for(var/ch_name in keyslot.channels)
			if(ch_name in src.channels)
				continue
			src.channels += ch_name
			src.channels[ch_name] += keyslot.channels[ch_name]

		if(keyslot.syndie)
			src.syndie = 1


	for (var/ch_name in src.channels)
		if(!radio_controller)
			sleep(30) // Waiting for the radio_controller to be created.
		if(!radio_controller)
			src.name = "broken radio"
			return

		secure_radio_connections[ch_name] = radio_controller.add_object(src, radiochannels[ch_name],  RADIO_CHAT)
	return