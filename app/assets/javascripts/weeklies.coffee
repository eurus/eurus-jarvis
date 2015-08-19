# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).bind 'page:load', ->
  initPage()
  return

initPage = (e) ->
  $('#weekly_sumary').summernote
    height: 400
    toolbar: [
      [
        'style'
        [ 'style' ]
      ]
      [
        'font'
        [
          'bold'
          'italic'
          'underline'
          'clear'
        ]
      ]
      [
        'fontsize'
        [ 'fontsize' ]
      ]
      [
        'fontname'
        [ 'fontname' ]
      ]
      [
        'color'
        [ 'color' ]
      ]
      [
        'para'
        [
          'ul'
          'ol'
          'paragraph'
        ]
      ]
      [
        'height'
        [ 'height' ]
      ]
      [
        'table'
        [ 'table' ]
      ]
      [
        'insert'
        [
          'link'
          'hr'
        ]
      ]
      [
        'view'
        [
          'fullscreen'
          'codeview'
        ]
      ]
      [
        'help'
        [ 'help' ]
      ]
    ]
