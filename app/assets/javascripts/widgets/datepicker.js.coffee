
widgets.define 'datepicker', (el) ->
  $el = $(el)

  try
    $el.datetimepicker
      format: 'YYYY-MM-DD'
      displayFormat: 'DD/MM/YYYY'
      locale: 'fr'
      # inline: true
      calendarWeeks: true
      sideBySide: true
  catch e
    console.error(e)

widgets.define 'datetimepicker', (el) ->
  $el = $(el)

  try
    $el.datetimepicker
      format: 'YYYY-MM-DD HH:mm Z'
      displayFormat: 'DD/MM/YYYY HH:mm'
      locale: 'fr'
      # inline: true
      calendarWeeks: true
      sideBySide: true
  catch e
    console.error(e)

widgets.define 'timepicker', (el) ->
  $el = $(el)

  try
    $el.datetimepicker
      format: 'HH:mm Z'
      displayFormat: 'HH:mm'
      locale: 'fr'
      # inline: true
      calendarWeeks: true
      sideBySide: true
  catch e
    console.error(e)

widgets.define 'datepicker_mobile', (el) ->
  $el = $(el)

  type = switch true
    when $el.hasClass('datetimepicker') then 'datetime'
    when $el.hasClass('datepicker') then 'date'
    when $el.hasClass('timepicker') then 'time'

  if $el.val() isnt ''
    value = new Date($el.val()).toISOString()
  else
    value = ''

  $handler = $("""
    <input type='#{type}' value='#{value}' class='form-control'></input>
  """)

  $handler.attr('name', $el.attr('name')) if $el.attr('name')
  $handler.attr('placeholder', $el.attr('placeholder')) if $el.attr('placeholder')

  $el.after($handler)
  $el.remove()
