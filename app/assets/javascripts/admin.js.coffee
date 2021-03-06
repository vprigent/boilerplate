#= require jquery
#= require jquery_ujs
#= require jquery.widget
#= require jquery.iframe-transport
#= require utils/jquery.fileupload
#= require bootstrap
#= require moment.min
#= require datetimepicker
#= require fastclick
#= require widgets
#= require select2
#= require nested_form
#= require bootstrap-markdown
#= require bootstrap-markdown.fr
#= require highlight.pack
#= require utils/markdown
#= require locales
#= require i18n

#= require ./widgets/navigation_highlight
#= require ./widgets/auto_resize
#= require ./widgets/collapse
#= require ./widgets/order_table
#= require ./widgets/json_form
#= require ./widgets/datepicker
#= require ./widgets/filepicker
#= require ./widgets/settings_editor
#= require ./widgets/settings_image_uploader
#= require ./widgets/markdown
#= require ./widgets/validation
#= require ./widgets/propagate_input_value
#= require ./widgets/select2
#= require ./widgets/field_limit

#= require_tree ./templates

window.DATE_FORMAT = 'YYYY-MM-DD'
window.DATE_DISPLAY_FORMAT = 'DD/MM/YYYY'
window.DATETIME_FORMAT = 'YYYY-MM-DD HH:mm Z'
window.DATETIME_DISPLAY_FORMAT = 'DD/MM/YYYY HH:mm'
window.TIME_FORMAT = 'HH:mm Z'
window.TIME_DISPLAY_FORMAT = 'HH:mm'

DEFAULT_EVENTS = 'load nested:fieldAdded'

is_mobile = -> $(window).width() < 992
is_in_template = (el) -> $(el).parents('.tpl').length > 0
is_mobile_or_in_template = (el) -> is_mobile() or is_in_template(el)

widgets 'navigation_highlight', '.navbar-nav', on: DEFAULT_EVENTS

widgets 'auto_resize', 'textarea', on: DEFAULT_EVENTS, unless: is_in_template
widgets 'collapse', '.collapse', on: DEFAULT_EVENTS, unless: is_in_template

widgets 'order_table', '.sortable', on: DEFAULT_EVENTS, unless: is_mobile_or_in_template

widgets 'settings_editor', '.settings_editor', on: DEFAULT_EVENTS
widgets 'settings_form', '[data-settings]', on: DEFAULT_EVENTS
widgets 'settings_image_uploader', '[data-settings] .file', on: DEFAULT_EVENTS, unless: is_in_template

widgets 'datepicker_mobile', '.datepicker, .datetimepicker, .timepicker', on: DEFAULT_EVENTS, if: is_mobile, unless: is_in_template
widgets 'datetimepicker', '.datetimepicker', on: DEFAULT_EVENTS, unless: is_mobile_or_in_template
widgets 'filepicker', '.form-group.file', on: DEFAULT_EVENTS, unless: is_in_template
widgets 'markdown', '[data-editor="markdown"]', on: DEFAULT_EVENTS, unless: is_mobile_or_in_template
widgets 'propagate_input_value', 'input:not(.select2-offscreen):not(.select2-input), select', on: DEFAULT_EVENTS, unless: is_in_template
widgets 'select2', 'select, .select2', on: DEFAULT_EVENTS, unless: is_mobile_or_in_template
widgets 'field_limit', '[data-limit]', on: DEFAULT_EVENTS, unless: is_in_template
widgets 'live_validation', '[required]', on: DEFAULT_EVENTS, unless: is_in_template
widgets 'form_validation', 'form', on: DEFAULT_EVENTS, unless: is_in_template
widgets 'json_form', 'form', on: DEFAULT_EVENTS, unless: is_in_template

I18n.attachToWindow()
hljs.initHighlightingOnLoad()

old_insertFields = NestedFormEvents::insertFields
NestedFormEvents::insertFields = (content, assoc, link) ->
  if content.indexOf('<tr') isnt -1
    $tr = $(link).closest('tr')
    $(content).insertBefore($tr)
  else if content.indexOf('<li') isnt -1
    $li = $(link).closest('li')
    $(content).insertBefore($li)
  else
    old_insertFields.call(this, content, assoc, link)

$ ->
  FastClick.attach(document.body)

  $('[data-toggle="collapse"]').on 'click', (e) ->
    e.preventDefault()
    $($(this).attr('data-target')).toggleClass('in')
