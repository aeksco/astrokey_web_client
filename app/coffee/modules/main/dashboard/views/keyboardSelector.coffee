KeyboardView = require('./keyboardView')
NumpadView = require('./numpadView')
FunctionKeyboard = require('./functionKeyboard')
MediaKeyboard = require('./mediaKeyboard')
NavKeyboard = require('./navKeyboard')

# # # # #

# TODO - abstract
class SimpleNav extends Mn.LayoutView

  events:
    'click [data-trigger]': 'onNavItemClick'

  navItems: []

  regions:
    contentRegion: '[data-region=content]'

  onRender: ->
    def = _.where(_.result(@, 'navItems'), { default: true })[0]
    return unless def
    @triggerMethod("navigate:#{def.trigger}")

  serializeData: ->
    data = super
    _.extend(data, { navItems: _.result(@, 'navItems') })
    return data

  onNavItemClick: (e) =>
    console.log @
    el = $(e.currentTarget)
    el.addClass('active').siblings().removeClass('active')
    @triggerMethod("navigate:#{el.data('trigger')}")

# # # # #

class KeyboardSelector extends SimpleNav
  className: 'row h-100'
  template: require('./templates/keyboard_selector')

  navItems: [
    { icon: 'fa-keyboard-o',  text: 'Keyboard',  trigger: 'keyboard', default: true }
    { icon: 'fa-file-text-o', text: 'Numpad',   trigger: 'numpad' }
    { icon: 'fa-caret-square-o-up',    text: 'Function',    trigger: 'function' }
    { icon: 'fa-asterisk',    text: 'Media',    trigger: 'media' }
    { icon: 'fa-asterisk',    text: 'Navigation',    trigger: 'nav' }
  ]

  showKeyboardView: (keyboardView) ->

    # Handles KeySelection event
    keyboardView.on 'key:selected', (key) => @trigger('key:selected', key)

    # Shows the keyboardView
    @contentRegion.show keyboardView

  onNavigateKeyboard: ->
    @showKeyboardView(new KeyboardView({ model: @model, keys: @options.keys }))

  onNavigateNumpad: ->
    @showKeyboardView(new NumpadView({ model: @model, keys: @options.keys }))

  onNavigateFunction: ->
    @showKeyboardView(new FunctionKeyboard({ model: @model, keys: @options.keys }))

  onNavigateMedia: ->
    @showKeyboardView(new MediaKeyboard({ model: @model, keys: @options.keys }))

  onNavigateNav: ->
    @showKeyboardView(new NavKeyboard({ model: @model, keys: @options.keys }))

# # # # #

module.exports = KeyboardSelector