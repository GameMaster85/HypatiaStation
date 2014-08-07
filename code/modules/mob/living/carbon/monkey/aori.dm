/mob/living/carbon/monkey/aori
	name = "aori"
	voice_name = "aori"
	speak_emote = list("cuues")
	icon_state = "native1"
	universal_understand = 0
	universal_speak = 0

/mob/living/carbon/monkey/aori/New()

	..()
	alien = 1
	gender = NEUTER
	dna.mutantrace = "tribal"

/mob/living/carbon/monkey/aori/say_quote(var/text)
	var/ending = copytext(text, length(text))
	if (ending == "?")
		return "Kaei"
	return "cuu"

//this disables the reandom events
/mob/living/carbon/monkey/aori/handle_random_events()
	return