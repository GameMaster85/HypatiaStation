/datum/aisoftware/messenger

/datum/aisoftware/messenger/New()
	..()

/datum/aisoftware/messenger/GetScreen()

	var/dat = "<h2>Digital Messenger</h2><hr>"
	dat += {"<b>Signal/Receiver Status:</b> <A href='byond://?src=\ref[src];toggler=1'>
	[(softowner.aiPDA.toff) ? "<font color='red'> \[Off\]</font>" : "<font color='green'> \[On\]</font>"]</a><br>
	<b>Ringer Status:</b> <A href='byond://?src=\ref[src];;ringer=1'>
	[(softowner.aiPDA.silent) ? "<font color='red'> \[Off\]</font>" : "<font color='green'> \[On\]</font>"]</a><br><br>"}
	dat += "<ul>"
	if(!softowner.aiPDA.toff)
		for (var/obj/item/device/pda/P in sortAtom(PDAs))
			if (!P.owner||P.toff||P == softowner.aiPDA)	continue
			dat += "<li><a href='byond://?src=\ref[src];target=\ref[P]'>[P]</a>"
			dat += "</li>"
	dat += "</ul>"
	dat += "Messages: <hr>"

	dat += "<style>td.a { vertical-align:top; }</style>"
	dat += "<table>"
	for(var/index in softowner.aiPDA.tnote)
		if(index["sent"])
			dat += addtext("<tr><td class='a'><i><b>To</b></i></td><td class='a'><i><b>&rarr;</b></i></td><td><i><b><a href='byond://?src=\ref[src];software=pdamessage;target=",index["src"],"'>", index["owner"],"</a>: </b></i>", index["message"], "<br></td></tr>")
		else
			dat += addtext("<tr><td class='a'><i><b>From</b></i></td><td class='a'><i><b>&rarr;</b></i></td><td><i><b><a href='byond://?src=\ref[src];software=pdamessage;target=",index["target"],"'>", index["owner"],"</a>: </b></i>", index["message"], "<br></td></tr>")
	dat += "</table>"
	return dat

/datum/aisoftware/messenger/Topic(href, href_list)
	if(href_list["toggler"])
		if(usr.stat == 2)
			usr << "You can't do that because you are dead!"
			return
		softowner.aiPDA.toff = !softowner.aiPDA.toff
		usr << "<span class='notice'>PDA sender/receiver toggled [(softowner.aiPDA.toff ? "Off" : "On")]!</span>"
	else if(href_list["ringer"])
		if(usr.stat == 2)
			usr << "You can't do that because you are dead!"
			return
		softowner.aiPDA.silent = !softowner.aiPDA.silent
		usr << "<span class='notice'>PDA ringer toggled [(softowner.aiPDA.silent ? "Off" : "On")]!</span>"
	else if(href_list["target"])
		var/target = locate(href_list["target"])
		softowner.aiPDA.create_message(usr, target)
	softowner.aiInterface()