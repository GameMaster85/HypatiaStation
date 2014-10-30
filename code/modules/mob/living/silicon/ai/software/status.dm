/datum/aisoftware/status

/datum/aisoftware/status/New()
	..()

/datum/aisoftware/status/GetScreen()
	var/dat =""
	dat += "<h1>Status</h1><br>"
	dat += "<B>System integrity: [round((softowner.health/softowner.maxHealth)*100)]%</B><br><br>"
	dat += "<A href='byond://?src=\ref[src];announce=1'>Station announcement</A><br>"
	dat += "<A href='byond://?src=\ref[src];callshuttle=1'>Call the shuttle</A><br>"
	dat += "<A href='byond://?src=\ref[src];recallshuttle=1'>Recall the shuttle</A><br><br>"
	for (var/cat in softowner.alarms)
		dat += text("<B>[]</B><BR>\n", cat)
		var/list/alarmlist = softowner.alarms[cat]
		if (alarmlist.len)
			for (var/area_name in alarmlist)
				var/datum/alarm/alarm = alarmlist[area_name]
				dat += "<NOBR>"

				var/cameratext = ""
				if (alarm.cameras)
					for (var/obj/machinery/camera/I in alarm.cameras)
						cameratext += text("[]<A HREF=?src=\ref[];switchcamera=\ref[]>[]</A>", (cameratext=="") ? "" : " | ", src, I, I.c_tag)
				dat += text("-- [] ([])", alarm.area.name, (cameratext)? cameratext : "No Camera")

				if (alarm.sources.len > 1)
					dat += text(" - [] sources", alarm.sources.len)
				dat += "</NOBR><BR>\n"
		else
			dat += "-- All Systems Nominal<BR>\n"
		dat += "<BR>\n"
	dat += "<br><A href='byond://?src=\ref[src];refresh=1'>Refresh</A>"
	return dat

/datum/aisoftware/status/Topic(href, href_list)
	if(href_list["refresh"])
		softowner.aiInterface()
	else if (href_list["switchcamera"])
		softowner.switchCamera(locate(href_list["switchcamera"])) in cameranet.cameras
	else if (href_list["callshuttle"])
		softowner.ai_call_shuttle()
	else if(href_list["recallshuttle"])
		softowner.ai_recall_shuttle()
	else if(href_list["announce"])
		softowner.ai_announcement()