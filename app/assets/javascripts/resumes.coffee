# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

JQuery ->
  title_list= $('#title_list_id').html()
  $('#degree_list').change ->
    degree=$('#education_title_list :selected').text()
    options=$(title_list_id).filter("optgrooup[label='#{degree}']").html()
    if options
      $('#title_list_id').html(options)
    else
      $('#title_list_id').empty()
      $('#title_list_id').parent().hide()
