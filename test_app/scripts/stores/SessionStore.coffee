AppDispatcher = require('../dispatcher/AppDispatcher.js')
AppConstants = require('../constants/AppConstants.coffee')
EventEmitter = require('events').EventEmitter
assign = require('object-assign')
ActionTypes = AppConstants.ActionTypes
CHANGE_EVENT = 'change'
BaseUtils = require('../utils/UtilFuncs.coffee')

# Load an access token from the session storage, you might want to implement
# a 'remember me' using localStorage
_errors = []

_tokenFormat =
  "access-token": "{{ token }}"
  "token-type":   "Bearer"
  client:         "{{ clientId }}"
  expiry:         "{{ expiry }}"
  uid:            "{{ uid }}"



# abstract persistent data store
_persistData = (key, val) ->
  window.localStorage.setItem(key, JSON.stringify(val))
  # switch @getConfig(configName).storage
  #   when 'localStorage'
  #     window.localStorage.setItem(key, JSON.stringify(val))
  #   else
  #     $.cookie(key, val, {path: '/'})


# abstract persistent data retrieval
_retrieveData = (key) ->
  JSON.parse(window.localStorage.getItem(key))
  # switch @getConfig().storage
  #   when 'localStorage'
  #     JSON.parse(window.localStorage.getItem(key))
  #   else $.cookie(key)

# abstract persistent data removal
_deleteData = (key) ->
  window.localStorage.removeItem(key)
  # switch @getConfig().storage
  #   when 'localStorage'
  #     window.localStorage.removeItem(key)
  #   else
  #     $.removeCookie(key, {path: '/'})



_setAuthHeaders = (h) ->
  newHeaders = assign({}, (_retrieveData('auth_headers') || {}), h)
  _persistData('auth_headers', newHeaders)


_invalidateTokens = ->
  # kill cookies, otherwise session will resume on page reload
  # setting this value to null will force the validateToken method
  # to re-validate credentials with api server when validate is called
  _deleteData('auth_headers')


SessionStore = assign {}, EventEmitter.prototype,
  emitChange: ->
    @emit CHANGE_EVENT
    return
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
    return
  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback
    return
  isLoggedIn: ->
    !!Object.keys(_retrieveData('auth_headers') || {}).length
  getAuthHeaders: ->
    _retrieveData('auth_headers') || {}
  getAccessToken: ->
    if @isLoggedIn()
      _retrieveData('auth_headers').accessToken
  getEmail: ->
    if @isLoggedIn()
      _retrieveData('auth_headers').uid
  updateHeadersFromResponse: (resp) ->
    newHeaders = {}
    for key, val of _tokenFormat
      if resp.headers[key]
        newHeaders[key] = resp.headers[key]
    _setAuthHeaders(newHeaders)
  getErrors: ->
    _errors
  resetErrors: ->
    _errors = []
  setErrors: (errors)->
    _errors = (if errors == null || errors == undefined then [] else errors)

SessionStore.dispatchToken = AppDispatcher.register (payload) ->
  action = payload.action
  status = BaseUtils.trycatch -> action.response.status

  unless status == 500
    switch action.type
      when ActionTypes.LOGIN_RESPONSE
        if status == 401
          SessionStore.setErrors(action.response.body.errors)
          # handle error setting here only
          delete action.response.body.errors
        else
          SessionStore.resetErrors()
          SessionStore.updateHeadersFromResponse(action.response)
        SessionStore.emitChange()

      when ActionTypes.LOGOUT      
        _invalidateTokens()
        SessionStore.emitChange()


module.exports = SessionStore