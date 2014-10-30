/datum/aisoftware/mood

/datum/aisoftware/mood/New()
	..()

/datum/aisoftware/mood/GetScreen()
	var/dat =""
	dat += "<br><h1>Change Mood</h1><br><br>"
	var/list/ai_emotions = list("Very Happy", "Happy", "Neutral", "Unsure", "Confused", "Surprised", "Sad", "Upset", "Angry", "Awesome", "BSOD", "Blank", "Problems?", "Facepalm", "Friend Computer")
	for(var/i = 1, i <= ai_emotions.len, i++)
		if(softowner.curmood == ai_emotions[i])
			dat += "<b>[ai_emotions[i]] (selected)</b><br>"
		else
			dat += "<A HREF='?src=\ref[src];newmood=[ai_emotions[i]]'>[ai_emotions[i]]</A><br>"
	return dat

/datum/aisoftware/mood/Topic(href, href_list)
	if(softowner.check_unable(1)) //AI_CHECK_WIRELESS
		return
	if(href_list["newmood"])
		softowner.curmood = href_list["newmood"]
		for (var/obj/machinery/M in machines) //change status
			if(istype(M, /obj/machinery/ai_status_display))
				var/obj/machinery/ai_status_display/AISD = M
				AISD.emotion = softowner.curmood
		//if Friend Computer, change ALL displays
			else if(istype(M, /obj/machinery/status_display))
				var/obj/machinery/status_display/SD = M
				if(softowner.curmood == "Friend Computer")
					SD.friendc = 1
				else
					SD.friendc = 0
	softowner.aiInterface()