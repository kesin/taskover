jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

# Flash
$(document).ready ->
  if (flash = $("#taskover_alert")).length > 0
    flash.click -> $(@).fadeOut()
    flash.show()
    if flash_time?
      setTimeout (-> flash.fadeOut()), flash_time
    else
      setTimeout (-> flash.fadeOut()), 3000