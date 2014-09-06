/datum/aisoftware/announcement

/datum/aisoftware/announcement/New()
	..()

/datum/aisoftware/announcement/GetScreen()
	var/dat = {"<br><h1>Announcements</h1><br>
	Here is a list of words you can type into the 'Announcement' button to create sentences to vocally announce to everyone on the same level at you.<BR>
	You can also click on the word to preview it.<br>
	You can only say 30 words for every announcement.<br>
	Do not use punctuation as you would normally, if you want a pause you can use the full stop and comma characters by separating them with spaces, like so: 'Alpha . Test , Bravo'.<br><br>
	<A href='?src=\ref[src];announce=1'>Create announcement</A><br><br>

	<font class='bad'>WARNING:</font><BR>Misuse of the announcement system will get you job banned.<HR>"}
	var/index = 0
	var/list/vox_words = flist(VOX_PATH) // flist will return a list of strings with all the files in the path
	for(var/word in vox_words)
		index++
		var/stripped_word = copytext(word, 1, length(word) - 3) // Remove the .wav
		dat += "<A href='?src=\ref[src];say_word=[stripped_word]'>[capitalize(stripped_word)]</A>"
		if(index != vox_words.len)
			dat += " / "
	return dat

/datum/aisoftware/announcement/Topic(href, href_list)
	if(href_list["say_word"])
		play_vox_word(href_list["say_word"], null, softowner)
		return
	if(href_list["announce"])
		softowner.announcement()