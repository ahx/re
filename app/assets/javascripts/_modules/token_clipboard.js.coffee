$ ->
  # initialize manual tooltip
  $('.input-login-token').tooltip
    animation: false
    trigger: 'manual'
    title: 'in die Zwischenablage kopieren'

  # select whole input field when clicked
  $('.input-login-token').click ->
    @.select()

  clip = new ZeroClipboard($(".input-login-token button"), hoverClass: 'btn-primary')

  clip.on 'mouseover', ->
    $('.input-login-token').tooltip('show')

  clip.on 'mouseout', ->
    $('.input-login-token').tooltip('hide')

  clip.on 'complete', ->
    $tooltip = $('.input-login-token').data('tooltip')
    $tooltip.changeTitle('kopiert!')
