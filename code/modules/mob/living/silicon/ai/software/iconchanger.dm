/datum/aisoftware/iconchanger

/datum/aisoftware/iconchanger/New()
	..()

/datum/aisoftware/iconchanger/GetScreen()
	var/dat =""
	dat += "<br><h1>Change Icon</h1><br><br>"

	if(!softowner.custom_sprite) //Check to see if custom sprite time, checking the appopriate file to change a var
		var/file = file2text("config/custom_sprites.txt")
		var/lines = text2list(file, "\n")

		for(var/line in lines)
		// split & clean up
			var/list/Entry = text2list(line, ":")
			for(var/i = 1 to Entry.len)
				Entry[i] = trim(Entry[i])

			if(Entry.len < 2)
				continue;

			if(Entry[1] == usr.ckey && Entry[2] == usr.real_name)
				softowner.custom_sprite = 1 //They're in the list? Custom sprite time
				softowner.icon = 'icons/mob/custom-synthetic.dmi'

	var/allsprites[0]
	if(softowner.custom_sprite == 1) //add custom sprite choice, if one is available
		allsprites["Custom"] = "[usr.ckey]-ai"
	allsprites["Clown"] = "ai-clown2"
	allsprites["Monochrome"] = "ai-mono"
	allsprites["Inverted"] = "ai-u"
	allsprites["Firewall"] = "ai-magma"
	allsprites["Green"] = "ai-wierd"
	allsprites["Red"] = "ai-red"
	allsprites["Static"] = "ai-static"
	allsprites["Text"] = "ai-text"
	allsprites["Smiley"] = "ai-smiley"
	allsprites["Matrix"] = "ai-matrix"
	allsprites["Angry"] = "ai-angryface"
	allsprites["Dorf"] = "ai-dorf"
	allsprites["Bliss"] = "ai-bliss"
	allsprites["Triumvirate"] = "ai-triumvirate"
	allsprites["Triumvirate Static"] = "ai-triumvirate-malf"
	var/s
	for(s in allsprites)
		if(softowner.icon_state == allsprites[s])
			dat += "<b>[s] (selected)</b><br>"
		else
			dat += "<A HREF='?src=\ref[src];newicon=[allsprites[s]]'>[s]</A><br>"
	return dat

/datum/aisoftware/iconchanger/Topic(href, href_list)
	if(softowner.stat || softowner.aiRestorePowerRoutine)
		usr << "You can't do that right now."
		return //should this give a nudge that you are dead or have no power?
	if(href_list["newicon"])
		softowner.icon_state = href_list["newicon"]
	softowner.aiInterface()