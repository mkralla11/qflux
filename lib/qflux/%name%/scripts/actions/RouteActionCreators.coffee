AppDispatcher = require('../dispatcher/AppDispatcher.js')
AppConstants = require('../constants/AppConstants.coffee')
ActionTypes = AppConstants.ActionTypes
module.exports = redirect: (route) ->
  AppDispatcher.handleViewAction
    type: ActionTypes.REDIRECT
    route: route
  return