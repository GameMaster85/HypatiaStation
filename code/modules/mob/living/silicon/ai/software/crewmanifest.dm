/datum/aisoftware/crewmanifest


/datum/aisoftware/crewmanifest/GetScreen()
	//This crew manifest is not currect yet, as it is not full with, and it should
	var/dat = ""
	if(data_core)
		dat += data_core.ai_get_manifest()
	dat +="<br>"
	return dat

/datum/aisoftware/crewmanifest/Topic(href, href_list)
