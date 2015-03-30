# React = require('react')

BasicError = 
  clearErrorsArray: ->
    @setState({ errors: [] })

  clearErrorsObject: ->
    @setState({ errors: {} })

  getBasicErrorMessageOptions: ->
    noop = ->
    opts = {messages: [], clearMessages: noop }

    if Array.isArray @state.errors
      opts =
        messages: @state.errors 
        clearMessages: @clearErrorsArray
    else if Object.keys(@state.errors).length != 0
      opts =
        messages: ["Please fix the errors below"]
        clearMessages: @clearErrorsObject
    return opts
module.exports = BasicError