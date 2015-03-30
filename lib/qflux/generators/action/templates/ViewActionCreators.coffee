AppDispatcher = require('../../dispatcher/AppDispatcher.js')
Constants = require('../../constants/Constants.coffee')
<%= name.camelize %>API = require('../../utils/API/<%= name.camelize %>API.coffee')
ActionTypes = AppConstants.ActionTypes

module.exports =
  load<%= name.pluralize %>: ->
    AppDispatcher.handleViewAction 
      type: ActionTypes.LOAD_<%= name.pluralize.upcase %>
    <%= name.camelize %>API.load<%= name.pluralize %>()
    return
  load<%= name.singularize.camelize %>: (<%= name.downcase %>Id) ->
    AppDispatcher.handleViewAction
      type: ActionTypes.LOAD_<%= name.upcase %>
      <%= name.downcase %>Id: <%= name.camelize(:lower) %>Id
    <%= name.camelize %>API.load<%= name.camelize %> <%= name.camelize(:lower) %>Id
    return
  create<%= name.singularize.camelize %>: (param1, param2) ->
    AppDispatcher.handleViewAction
      type: ActionTypes.CREATE_<%= name.upcase %>
      param1: param1
      param2: param2
    <%= name.camelize %>API.create<%= name.camelize(:lower) %> param1, param2
    return