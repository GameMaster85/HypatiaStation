/mob/living/silicon/ai/verb/aiInterface()
	set category = "IC"
	set name = "AI Interface"
	var/dat = ""
	var/right_part = GetScreen()
	var/left_part = ""
	if(detailwindow)
		left_part = detailwindow.GetScreen()
	else
		detailwindow = new /datum/aisoftware/status()
		left_part = detailwindow.GetScreen()

	// not sure why set machine?
	//src.set_machine(src)

	//background image should be drawn by someone
	//background-image:url(\"painew.png\");
	// Declaring a doctype is necessary to enable BYOND's crappy browser's more advanced CSS functionality
	dat = {"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
			<html>
			<head>
				<style type=\"text/css\">
					body {  background-color:#333333; background-repeat:no-repeat; margin-top:12px; margin-left:4px; }

					#header { text-align:center; color:white; font-size: 30px; height: 37px; letter-spacing: 2px; z-index: 4; font-family:\"Courier New\"; font-weight:bold;
						border-style: ridge;border-color:#CCCCCC;}
					#content { color:#CCCCCC; height:auto; overflow:hidden; font-family: \"Verdana\"; font-size:13px; }
					p { font-size:13px; margin-left: 5px; margin-right: 5px; }

					#leftmenu {  float: none; width:auto; overflow: hidden; overflow-y:auto; min-height:600px;border-style: ridge;border-color:#CCCCCC;}
					#leftmenu a:link { color: #CCCCCC; }
					#leftmenu a:hover { color: #CC3333; }
					#leftmenu a:visited { color: #CCCCCC; }
					#leftmenu a:active { color: #CCCCCC; }
					#rightmenu { width:225px; float:right;min-height:600px;border-style: ridge;border-color:#CCCCCC;}
					#rightmenu a:link { color: #CCCCCC; }
					#rightmenu a:hover { color: #CC3333; }
					#rightmenu a:visited { color: #CCCCCC; }
					#rightmenu a:active { color: #CCCCCC; }
				</style>
				<script language='javascript' type='text/javascript'>
				[js_byjax]
				</script>
			</head>
			<body scroll=yes>
				<div id=\"header\">
					[name] OS
				</div>
				<div id=\"content\">
					<div id=\"rightmenu\"><p>[right_part]</p></div>
					<div id=\"leftmenu\"><p>[left_part]</p></div>
				</div>
			</body>
			</html>"}
	usr << browse(dat, "window=ai;size=685x449;border=0;can_close=1;can_resize=1;can_minimize=1;titlebar=1")
	onclose(usr, "ai") //onclose is not really used yet!
	return


/mob/living/silicon/ai/proc/GetScreen()
	var/dat = {"
	<A href='byond://?src=\ref[src];soft=status'>Station Status</A><br>
	<A href='byond://?src=\ref[src];soft=laws'>Laws</A><br><br>
	<A href='byond://?src=\ref[src];soft=manifest'>Crew manifest</A><br>
	<A href='byond://?src=\ref[src];soft=camctrl'>Camera Control</A><br><br>
	<A href='byond://?src=\ref[src];soft=messenger'>PDA/messaging</A><br>
	<A href='byond://?src=\ref[src];soft=announce'>Announcements</A><br>
	<A href='byond://?src=\ref[src];soft=airadio'>Radio</A><br><br>
	<A href='byond://?src=\ref[src];soft=hologram'>Change Hologram</A><br>
	<A href='byond://?src=\ref[src];soft=iconchanger'>Change Icon</A><br>
	<A href='byond://?src=\ref[src];soft=mood'>Change Mood</A><br>"}
	return dat
//the topic for the above is in the ai.dm file


//this is the main menu,
/datum/aisoftware/
	var/mob/living/silicon/ai/softowner
/datum/aisoftware/New()
	if(istype(usr, /mob/living/silicon/ai))
		softowner = usr
/datum/aisoftware/proc/GetScreen()
	return