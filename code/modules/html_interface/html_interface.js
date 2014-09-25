$(document).ready(function()
{
	window.location.href = "byond://?src=" + hSrc + "&html_interface_action=onload";
});

function setTitle(new_title)				{ $("title").html(new_title); }
function updateLayout(new_html)				{ $("body").html(new_html); }
function updateContent(id, new_html)		{ $("#" + id).html(new_html); }