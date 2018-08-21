$ ->
  $('#carousel').find('.navigation li').click ->

    $(this).parent().find('.active').removeClass 'active'
    $(this).addClass 'active'

    $('#carousel').find('.items ul').css 'margin-left', -($(this).index() * $(this).parent().width())
