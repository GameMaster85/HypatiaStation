//radio stuff here!
/datum/aisoftware/radio

/datum/aisoftware/radio/New()
	..()

/datum/aisoftware/radio/GetScreen()
	var/dat =""
	dat += "<br><h1>Radio</h1><br><br>"
	//might need to check for power!
	dat += "Microphone: <A href='byond://?src=\ref[src];talk=1'>[softowner.radio.broadcasting ? "Engaged" : "Disengaged"]</A><BR>"

	dat += {"
				Speaker: <A href='byond://?src=\ref[src];listen=1'>[softowner.radio.listening ? "Engaged" : "Disengaged"]</A><BR>
				Frequency:
				<A href='byond://?src=\ref[src];freq=-10'>-</A>
				<A href='byond://?src=\ref[src];freq=-2'>-</A>
				[format_frequency(softowner.radio.frequency)]
				<A href='byond://?src=\ref[src];freq=2'>+</A>
				<A href='byond://?src=\ref[src];freq=10'>+</A><BR>
				"}

	for (var/chan_name in softowner.radio.channels)
		var/list = !!(softowner.radio.channels[chan_name] & softowner.radio.FREQ_LISTENING) != 0
		dat +="<B>[chan_name]</B><br>	Speaker: <A href='byond://?src=\ref[src];ch_name=[chan_name]'>[list ? "Engaged" : "Disengaged"]</A><BR>"
	return dat

/datum/aisoftware/radio/Topic(href, href_list)
	if(href_list["talk"])
		softowner.radio.broadcasting = !softowner.radio.broadcasting
	else if(href_list["listen"])
		softowner.radio.listening = !softowner.radio.listening
	else if(href_list["ch_name"])
		var/chan_name = href_list["ch_name"]
		if (softowner.radio.channels[chan_name] & softowner.radio.FREQ_LISTENING)
			softowner.radio.channels[chan_name] &= ~softowner.radio.FREQ_LISTENING
		else
			softowner.radio.channels[chan_name] |= softowner.radio.FREQ_LISTENING
	else if(href_list["freq"])
		var/new_frequency = (softowner.radio.frequency + text2num(href_list["freq"]))
		if (!softowner.radio.freerange || (softowner.radio.frequency < 1200 || softowner.radio.frequency > 1600))
			new_frequency = sanitize_frequency(new_frequency, softowner.radio.maxf)
		softowner.radio.set_frequency(new_frequency)
		if(softowner.radio.hidden_uplink)
			if(softowner.radio.hidden_uplink.check_trigger(usr, softowner.radio.frequency, softowner.radio.traitor_frequency))
				usr << browse(null, "window=radio")
				return
	softowner.aiInterface()