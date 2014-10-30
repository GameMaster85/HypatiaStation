/datum/aisoftware/camcontrol

/datum/aisoftware/camcontrol/New()
	..()

/datum/aisoftware/camcontrol/GetScreen()
	var/dat ={"
	<br><h1>Camera Control</h1><br>
	<p><B>Active camera's: [cameranet.cameras.len]</B><br><br>"}

	if(softowner.camera)	//tried solving this differently but caused bugs
		dat += "<B>Current Camera: [softowner.camera.name]</B><br>"
	else
		dat += "<B>Current Camera: None</B><br>"

	dat += {"<A href='byond://?src=\ref[src];gtcore=1'>Go To Core</A><br>
	<A href='byond://?src=\ref[src];jmptocam=1'>Show Camera List</A><br>
	<A href='byond://?src=\ref[src];jmptonet=1'>Jump To Network</A><br><br>"}
	if(softowner.cameraFollow)
		dat += "<B>Currently Tracking: [softowner.cameraFollow]</B><br>"
	else
		dat += "<B>Currently Tracking: None</B><br>"

	dat += {"<A href='byond://?src=\ref[src];tracking=1'>Track With Camera</A><br><br>
	Camera lights: <A href='byond://?src=\ref[src];togcamlt=1'>[softowner.camera_light_on ? "<font color='green'> \[On\]</font>" : "<font color='red'> \[Off\]</font>"]</a><br>
	Camera Acceleration: <A href='byond://?src=\ref[src];toggacc=1'>[softowner.acceleration ? "<font color='green'> \[On\]</font>" : "<font color='red'> \[Off\]</font>"]</a><br><br>

	<A href='byond://?src=\ref[src];storeloc=1'>Store current location</A><br>
	<B>Stored locations:</B><br>"}
	for(var/i = 1, i <= softowner.stored_locations.len, i++)
		dat += "<A href='byond://?src=\ref[src];jmploc=[softowner.stored_locations[i]]'>[softowner.stored_locations[i]]</A>  <A href='byond://?src=\ref[src];delloc=[softowner.stored_locations[i]]'>remove</A><br>"
	dat += "</p>"
	return dat



//TODO: SHOULD UPDATE CAMERA
/datum/aisoftware/camcontrol/Topic(href, href_list)
	if(href_list["gtcore"])
		softowner.view_core()
	else if(href_list["jmptocam"])
		var/getcam = input("To which camera would you like to jump?") as null|anything in softowner.get_camera_list()
		if(!isnull(getcam))
			softowner.ai_camera_list(getcam)
	else if(href_list["tracking"])
		var/trackmob = input("Who would you like to track?") as null|anything in softowner.trackable_mobs()
		if(!isnull(trackmob))
			softowner.ai_camera_track(trackmob)
	else if(href_list["jmptonet"])
		softowner.ai_network_change()
	else if(href_list["togcamlt"])				//this could still be a proc in the AI, if needed
		softowner.toggle_camera_light()
	else if(href_list["togacc"])
		softowner.acceleration = !softowner.acceleration
	else if(href_list["storeloc"])
		var/locname = input(usr,"Choose a name for this location:","Save Location") as text
		if(locname == "Cancel")
			return
		softowner.ai_store_location(locname)
	else if(href_list["jmploc"])
		softowner.ai_goto_location(href_list["jmploc"])
	else if(href_list["delloc"])
		softowner.ai_remove_location(href_list["delloc"])
	softowner.aiInterface()