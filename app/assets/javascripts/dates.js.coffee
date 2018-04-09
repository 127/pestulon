$ ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "dd-mm-yy"
      dateFormat: "yy-mm-dd"
      altField: $(this).next()