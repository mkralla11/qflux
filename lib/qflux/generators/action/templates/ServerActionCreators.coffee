AppDispatcher = require('../../dispatcher/AppDispatcher.js')
AppConstants = require('../../constants/AppConstants.coffee')
ActionTypes = AppConstants.ActionTypes
module.exports =
  receive<%= name.camelize.pluralize %>: (res) ->
    AppDispatcher.handleServerAction
      type: ActionTypes.RECEIVE_<%= name.pluralize.upcase %>
      response: res
    return
  receive<%= name.camelize.singularize %>: (res) ->
    AppDispatcher.handleServerAction
      type: ActionTypes.RECEIVE_<%= name.singularize.upcase %>
      response: res
    return
  receiveCreated<%= name.camelize.singularize %>: (res) ->
    AppDispatcher.handleServerAction
      type: ActionTypes.RECEIVE_CREATED_<%= name.singularize.upcase %>
      response: res
    return