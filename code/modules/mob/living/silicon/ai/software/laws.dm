/datum/aisoftware/laws

/datum/aisoftware/laws/New()
	..()

/datum/aisoftware/laws/GetScreen()
	var/dat =""
	dat += "<br><h1>Laws</h1><br><br>"

	dat += "<b>Which laws do you want to include when stating them for the crew?</b><br><br>"
	var/datum/ai_laws/curlaws = softowner.laws


	if (curlaws.zeroth)
		if (!softowner.lawcheck[1])
			softowner.lawcheck[1] = "No" //Given Law 0's usual nature, it defaults to NOT getting reported. --NeoFite
		dat += {"<A href='byond://?src=\ref[src];lawc=0'>[softowner.lawcheck[1]] 0:</A> [curlaws.zeroth]<BR>"}

	for (var/index = 1, index <= curlaws.ion.len, index++)
		var/law = curlaws.ion[index]

		if (length(law) > 0)


			if (!softowner.ioncheck[index])
				softowner.ioncheck[index] = "Yes"
			dat += {"<A href='byond://?src=\ref[src];lawi=[index]'>[softowner.ioncheck[index]] [ionnum()]:</A> [law]<BR>"}
			softowner.ioncheck.len += 1

	var/number = 1
	for (var/index = 1, index <= curlaws.inherent.len, index++)
		var/law = curlaws.inherent[index]

		if (length(law) > 0)
			softowner.lawcheck.len += 1

			if (!softowner.lawcheck[number+1])
				softowner.lawcheck[number+1] = "Yes"
			dat += {"<A href='byond://?src=\ref[src];lawc=[number]'>[softowner.lawcheck[number+1]] [number]:</A> [law]<BR>"}
			number++

	for (var/index = 1, index <= curlaws.supplied.len, index++)
		var/law = curlaws.supplied[index]
		if (length(law) > 0)
			softowner.lawcheck.len += 1
			if (!softowner.lawcheck[number+1])
				softowner.lawcheck[number+1] = "Yes"
			dat += {"<A href='byond://?src=\ref[src];lawc=[number]'>[softowner.lawcheck[number+1]] [number]:</A> [law]<BR>"}
			number++

	dat += {"<br>Channel: <A href='byond://?src=\ref[src];lawr=1'>[softowner.lawchannel]</A><br>"}
	dat += {"<A href='byond://?src=\ref[src];laws=1'>State Laws</A>"}
	return dat

/datum/aisoftware/laws/Topic(href, href_list)
	if(href_list["laws"])
		if(softowner.check_unable())
			return
		softowner.statelaws()
	else if (href_list["lawi"]) // Toggling whether or not a law gets stated by the State Laws verb --NeoFite
		var/L = text2num(href_list["lawi"])
		switch(softowner.ioncheck[L])
			if ("Yes") softowner.ioncheck[L] = "No"
			if ("No") softowner.ioncheck[L] = "Yes"
	else if (href_list["lawc"]) // Toggling whether or not a law gets stated by the State Laws verb --NeoFite
		var/L = text2num(href_list["lawc"])
		switch(softowner.lawcheck[L+1])
			if ("Yes") softowner.lawcheck[L+1] = "No"
			if ("No") softowner.lawcheck[L+1] = "Yes"
	else if (href_list["lawr"]) // Selects on which channel to state laws
		var/setchannel = input(usr, "Specify channel.", "Channel selection") in list("State","Common","Science","Command","Medical","Engineering","Security","Supply","Binary","Holopad", "Cancel")
		if(setchannel == "Cancel")
			return
		softowner.lawchannel = setchannel
	softowner.aiInterface()
	return