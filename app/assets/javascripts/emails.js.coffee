# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


fillRecipientList = ->
	recip = $("#email_recipients").val().replace(/,/g,"</br>")
	$("#selected-recipients").html recip
	$("#email_recipients").on "change", ->
		fillRecipientList()
	$("#new_email").on "submit", (e) ->
		alert("The Upload Folder is Empty :(") e.preventDefault() if $("#email_folder").val() == ""

$(document).ready ->
	fillRecipientList() if $("#email_recipients").length > 0


