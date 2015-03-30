SmallAppDispatcher = require('../../dispatcher/SmallAppDispatcher.js')
AppConstants = require('../../constants/AppConstants.coffee')
ActionTypes = AppConstants.ActionTypes
module.exports =
  receiveLogin: (r) ->
    SmallAppDispatcher.handleServerAction
      type: ActionTypes.LOGIN_RESPONSE
      response: r
    return