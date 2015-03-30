ServerSessionActionCreators = require('../../actions/server/SessionActionCreators.coffee')
AppConstants = require('../../constants/AppConstants.coffee')
APIUtils = require('./Utils.coffee')
request = require('superagent')
OAuth = require('../auth/OAuth.coffee')

APIEndpoints = AppConstants.APIEndpoints


module.exports =
  signup: (email, password, passwordConfirmation) ->
    req = request.post( APIEndpoints.REGISTRATION )
    APIUtils.setHeadersAndJson(req)

    req.send
      email: email
      password: password
      password_confirmation: passwordConfirmation
    .end (res) ->
      ServerSessionActionCreators.receiveLogin(res)

  login: (email, password) ->
    req = request.post(APIEndpoints.LOGIN)
    APIUtils.setHeadersAndJson(req)

    req.send
      email: email
      password: password
    .end (res) ->
      ServerSessionActionCreators.receiveLogin(res)
  loginGoogle: ()->
    OAuth.authenticate "google",
      then: (res)->
        ServerSessionActionCreators.receiveLoginGoogle(res)

