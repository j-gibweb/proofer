# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

fillRecipientList = ->
  recip = $("#recip_lists").val().replace(/,/g,"</br>")
  $("#selected-recipients").html recip
  $("#recipient_list").on "change", ->
    fillRecipientList()

$(document).ready ->
  fillRecipientList() if $("#recipient_list").length > 0

# changeVisibility = (field_name) ->
#   if $(field_name).is(":visible")
#     $(field_name).hide()
#   else
#     $(field_name).show()
#   return
