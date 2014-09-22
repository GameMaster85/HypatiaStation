/datum/aisoftware/photocam

/datum/aisoftware/photocam/New()
	..()

/datum/aisoftware/photocam/GetScreen()
	var/dat ={"
	<br><h1>Photo Camera</h1><br>
	<p><A href='byond://?src=\ref[src];togcampic=1'>Take Picture</a><BR><BR>

	There are currently [softowner.aiCamera.aipictures.len] Pictures stored.<br>"}
	for(var/datum/picture/p in softowner.aiCamera.aipictures)
		dat += "[p.fields["name"]] <A href='byond://?src=\ref[src];viewpic=[p.fields["name"]]'>View</A><A href='byond://?src=\ref[src];delpic=[p.fields["name"]]'>Delete</A><br>"
	dat += "</p>"
	return dat



//TODO: SHOULD UPDATE CAMERA
/datum/aisoftware/camcontrol/Topic(href, href_list)
	if(href_list["togcampic"])
		softowner.aiCamera.toggle_camera_mode()
	else if(href_list["viewpic"])
		var/datum/picture/pchoice
		for(var/datum/picture/q in softowner.aiCamera.aipictures)
			if(q.fields["name"] == href_list["viewpic"])
				pchoice = q
				break
		var/obj/item/weapon/photo/P = new/obj/item/weapon/photo()
		P.construct(pchoice)
		P.show(usr)
		usr << P.desc
		// TG uses a special garbage collector.. qdel(P)
		del(P) //so 10 thousand pictures items are not left in memory should an AI take them and then view them all.
	else if(href_list["delpic"])
		//delete picture!
		for(var/datum/picture/p in softowner.aiCamera.aipictures)
			if(p.fields["name"] == href_list["delpic"])
				softowner.aiCamera.aipictures -= p
				break
	softowner.aiInterface()