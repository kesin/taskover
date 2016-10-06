jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
window.notifyTop = (message, type) ->
  $.notify { message: message },
    element: 'body'
    type: type
    placement:
      from: 'top'
      align: 'center'
    offset: 8
    spacing: 10
    z_index: 1031
    delay: 2500
    timer: 200
    animate:
      enter: 'animated fadeInDown'
      exit: 'animated fadeOutUp'
  return