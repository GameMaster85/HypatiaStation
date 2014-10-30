//radio stuff here!
/datum/aisoftware/radio

/datum/aisoftware/radio/New()
	..()

/datum/aisoftware/radio/GetScreen()
	var/dat =""
	dat += "<br><h1>Radio</h1><br>"
	dat += "Microphone: <A href='byond://?src=\ref[src];talk=1'>[softowner.aiRadio.broadcasting ? "Engaged" : "Disengaged"]</A><BR>"

	dat += {"
				Speaker: <A href='byond://?src=\ref[src];listen=1'>[softowner.aiRadio.listening ? "Engaged" : "Disengaged"]</A><BR>
				Frequency:
				<A href='byond://?src=\ref[src];freq=-10'>-</A>
				<A href='byond://?src=\ref[src];freq=-2'>-</A>
				[format_frequency(softowner.aiRadio.frequency)]
				<A href='byond://?src=\ref[src];freq=2'>+</A>
				<A href='byond://?src=\ref[src];freq=10'>+</A><BR><BR>
				"}

	for (var/chan_name in softowner.aiRadio.channels)
		var/list = !!(softowner.aiRadio.channels[chan_name] & softowner.aiRadio.FREQ_LISTENING) != 0
		dat +="<B>[chan_name]</B><br>	Speaker: <A href='byond://?src=\ref[src];ch_name=[chan_name]'>[list ? "Engaged" : "Disengaged"]</A><BR><BR>"
	return dat

/datum/aisoftware/radio/Topic(href, href_list)
	if(softowner.check_unable(2)) //AI_CHECK_RADIO
		return
	if(href_list["talk"])
		softowner.aiRadio.broadcasting = !softowner.aiRadio.broadcasting
	else if(href_list["listen"])
		softowner.aiRadio.listening = !softowner.aiRadio.listening
	else if(href_list["ch_name"])
		var/chan_name = href_list["ch_name"]
		if (softowner.aiRadio.channels[chan_name] & softowner.aiRadio.FREQ_LISTENING)
			softowner.aiRadio.channels[chan_name] &= ~softowner.aiRadio.FREQ_LISTENING
		else
			softowner.aiRadio.channels[chan_name] |= softowner.aiRadio.FREQ_LISTENING
	else if(href_list["freq"])
		var/new_frequency = (softowner.aiRadio.frequency + text2num(href_list["freq"]))
		if (!softowner.aiRadio.freerange || (softowner.aiRadio.frequency < 1200 || softowner.aiRadio.frequency > 1600))
			new_frequency = sanitize_frequency(new_frequency, softowner.aiRadio.maxf)
		softowner.aiRadio.set_frequency(new_frequency)
		if(softowner.aiRadio.hidden_uplink)
			if(softowner.aiRadio.hidden_uplink.check_trigger(usr, softowner.aiRadio.frequency, softowner.aiRadio.traitor_frequency))
				usr << browse(null, "window=radio")
				return
	softowner.aiInterface()