/datum/aisoftware/hologram

/datum/aisoftware/hologram/New()
	..()


//TODOO, make bold what hologram is currently used.
/datum/aisoftware/hologram/GetScreen()
	var/dat =""
	dat += "<br><h1>Change Hologram</h1><br><br>"
	dat += "<B>Unique:</B><br>"
	var/icon_list[] = list("default","floating face")
	for(var/holo in icon_list)
		dat += "<A href='byond://?src=\ref[src];uholo=[holo]'>[holo]</A><br>"
	dat+="<br><B><Crew members:</B><br>"
	for(var/datum/data/record/t in data_core.locked)//Look in data core locked.
		dat +="<A href='byond://?src=\ref[src];crew=[t.fields["id"]]'>[t.fields["name"]]: [t.fields["rank"]]</A><br>"
	return dat

/datum/aisoftware/hologram/Topic(href, href_list)
	if(softowner.check_unable())
		return
	if(href_list["uholo"])
		del(softowner.holo_icon)
		switch(href_list["uholo"])
			if("default")
				softowner.holo_icon = getHologramIcon(icon('icons/mob/AI.dmi',"holo1"))
			if("floating face")
				softowner.holo_icon = getHologramIcon(icon('icons/mob/AI.dmi',"holo2"))
	else if(href_list["crew"])
		for(var/datum/data/record/t in data_core.locked)
			if(t.fields["id"] == href_list["crew"])
				var/icon/character_icon = t.fields["image"]
				if(character_icon)
					del(softowner.holo_icon)
					softowner.holo_icon = character_icon
				break
	softowner.aiInterface()