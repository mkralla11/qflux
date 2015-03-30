SmallAppDispatcher = require('../dispatcher/SmallAppDispatcher.js')
AppConstants = require('../constants/AppConstants.coffee')
SessionAPI = require('../utils/API/SessionAPI.coffee')
ActionTypes = AppConstants.ActionTypes
module.exports =
  signup: (email, password, passwordConfirmation) ->
    SmallAppDispatcher.handleViewAction
      type: ActionTypes.SIGNUP_REQUEST
      email: email
      password: password
      passwordConfirmation: passwordConfirmation
    SessionAPI.signup email, password, passwordConfirmation
    return
  login: (email, password) ->
    SmallAppDispatcher.handleViewAction
      type: ActionTypes.LOGIN_REQUEST
      email: email
      password: password
    SessionAPI.login email, password
    return
  logout: ->
    SmallAppDispatcher.handleViewAction type: ActionTypes.LOGOUT
    return
  loginGoogle: ->
    SmallAppDispatcher.handleViewAction type: ActionTypes.LOGIN_GOOGLE_REQUEST
    SessionAPI.loginGoogle()