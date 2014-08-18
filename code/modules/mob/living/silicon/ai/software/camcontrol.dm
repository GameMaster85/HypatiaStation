/datum/aisoftware/camcontrol

/datum/aisoftware/camcontrol/New()
	..()

/datum/aisoftware/camcontrol/GetScreen()
	var/dat ={"
	<br><h1>Camera Control</h1><br>
	<B>Active camera's: [cameranet.cameras.len]</B><br><br>"}

	if(softowner.current)	//tried solving this differently but caused bugs
		dat += "<B>Current Camera: [softowner.current.name]</B><br>"
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
	Camera Acceleration: <A href='byond://?src=\ref[src];toggacc=1'>[softowner.acceleration ? "<font color='green'> \[On\]</font>" : "<font color='red'> \[Off\]</font>"]</a>"}
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
	else if(href_list["jmptonet"])				//this could still be a proc in the AI, if needed
		softowner.unset_machine() //not sure unset_machine()
		softowner.cameraFollow = null
		var/cameralist[0]
		if(usr.stat == 2)
			usr << "You can't change your camera network because you are dead!"
			return
		var/mob/living/silicon/ai/U = usr
		for (var/obj/machinery/camera/C in cameranet.cameras)
			if(!C.can_use())
				continue
			var/list/tempnetwork = difflist(C.network,RESTRICTED_CAMERA_NETWORKS,1)
			if(tempnetwork.len)
				for(var/i in tempnetwork)
					cameralist[i] = i
		var/old_network = softowner.network
		softowner.network = input(U, "Which network would you like to view?") as null|anything in cameralist
		if(!U.eyeobj) //no eye object for some reason
			U.view_core()
			return
		if(isnull(softowner.network))
			softowner.network = old_network // If nothing is selected
		else
			for(var/obj/machinery/camera/C in cameranet.cameras)
				if(!C.can_use())
					continue
				if(softowner.network in C.network)
					U.eyeobj.setLoc(get_turf(C))
					break
		usr << "\blue Switched to [softowner.network] camera network."
	else if(href_list["togcamlt"])				//this could still be a proc in the AI, if needed
		softowner.camera_light_on = !softowner.camera_light_on
		if(softowner.camera_light_on)
			softowner.lightNearbyCamera()
		else if(softowner.current)
			softowner.current.SetLuminosity(0)
	else if(href_list["togacc"])
		softowner.acceleration = !softowner.acceleration
	softowner.aiInterface()