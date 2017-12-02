AbstractKeyboardView = require('lib/views/keyboard_abstract')

# # # #

class FunctionKeyboard extends AbstractKeyboardView

  # Passes key objects to UI
  templateHelpers: ->
    keys = @options.keys.toJSON()

    return {
      # r0: _.where(keys, { row: 'func_r0'})
      r0: _.where(keys, { row: 'special_r0'})
    }

# # # # #

module.exports = FunctionKeyboard


