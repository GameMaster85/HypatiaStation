/datum/prefilledpaper
	var/name
	var/text

var/list/prefilledpapers = createprefilledpapers()

/proc/createprefilledpapers()
	var/list/allpapers = list()
	var/datum/prefilledpaper/prefilledtemp = new /datum/prefilledpaper()
	prefilledtemp.name = "Job Demotion"
	allpapers.Add(prefilledtemp)
	prefilledtemp.text = {"\[center\]\[b\]\[u\]\[i\]Job Demotion Record\[/b\]\[/u\]\[/i\]\[br\]
\[i\]\[b\] NanoTrasen Hypatia Station \[/i\]\[/b\]\[/center\]
\[hr\]
\[center\]Name:\[fillfield\]\[/center\]\[br\]
\[center\]Position:\[fillfield\]\[/center\]\[br\]
\[hr\]
Terminated Employee: \[fillfield\]\[br\]
Demoted from the assignment of: \[fillfield\]\[br\]
Reason for Termination: \[br\]\[field\]
\[hr\]
\[center\]\[b\]Authorization\[/b\]\[br\]
If authorized, please sign here, \[signfield\], and stamp the document with the Department Stamp.\[br\]\[br\]
\[small\]If the job demotion is done in an unlawful manner, this form is null and void and security action will be taken.\[/small\]"}
	prefilledtemp = new /datum/prefilledpaper()
	prefilledtemp.name = "Job Transfer Request"
	allpapers.Add(prefilledtemp)
	prefilledtemp.text = {"\[Large\]\[u\]Job Transfer Request\[/u\]\[/Large\]\[br\]
\[br\]
\[br\]
I, \[u\]\[i\]\[fillfield\]\[/i\]\[/u\]\[small\](Your name)\[/small\],
request to be transferred from my current department, \[u\]\[i\]\[fillfield\]\[/i\]\[/u\]\[small\](Your current department)\[/small\]\[br\]
to \[u\]\[i\]\[fillfield\]\[/i\]\[/u\]\[small\](Your future department)\[/small\].\[br\]
\[br\]
\[br\]
Approved:\[br\]
\[signfield\]\[small\](Current head's signature)\[/small\]\[br\]
\[signfield\]\[small\](Future head's signature)\[/small\]\[br\]
\[br\]
\[hr\]
\[br\]
Stamps below:\[br\]
\[br\]"}
	prefilledtemp = new /datum/prefilledpaper()
	prefilledtemp.name = "Extended acces form"
	allpapers.Add(prefilledtemp)
	prefilledtemp.text = {"\[center\]\[b\]\[u\]\[i\]Extended Access Form\[/b\]\[/u\]\[/i\]\[br\]
\[i\]\[b\] NanoTrasen Hypatia Station \[/i\]\[/b\]\[/center\]
\[hr\]
\[center\]Name: \[fillfield\]\[br\]\[/center\]
\[center\]Rank: \[fillfield\]\[br\]\[/center\]
\[hr\]
Requested Access: \[field\]\[br\]
Reason(s): \[br\]\[field\]\[br\]
Signature: \[br\]\[signfield\]\[br\]
\[hr\]
\[center\]\[b\]Authorization\[/b\]\[br\]
If authorized, please sign here, \[signfield\], and stamp the document with the Department Stamp.\[br\]\[br\]
\[small\]Standard Operating Procedure must be followed at all times. At any time it is not, this form becomes null and void.\[/small\]"}
	prefilledtemp = new /datum/prefilledpaper()
	prefilledtemp.name = "Arrest warrent"
	allpapers.Add(prefilledtemp)
	prefilledtemp.text = {"\[Large\]\[u\]Warrant for Arrest\[/u\]\[/Large\]\[br\]
\[br\]
\[br\]
I, \[u\]\[i\]\[fillfield\]\[/i\]\[/u\]\[small\](Head Of Security/Magistrate)\[/small\],\[br\]
request to have the following individual(s) detained for trial: \[u\]\[i\]\[field\]\[/i\]\[/u\]\[small\](Individuals Suspected)\[/small\]\[br\]
on grounds of \[u\]\[i\]\[field\]\[/i\]\[/u\]\[small\](Crimes suspected of commiting)\[/small\].\[br\]
\[br\]
\[br\]
Approved:\[br\]
\[signfield\]\[small\](Captain/Magistrates Signature)\[/small\]\[br\]
\[br\]
\[br\]
\[br\]
Stamps below:\[br\]
\[br\]"}
	return allpapers