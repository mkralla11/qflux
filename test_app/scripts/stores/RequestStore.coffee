AppDispatcher = require('../dispatcher/AppDispatcher.js')
EventEmitter = require('events').EventEmitter
assign = require('object-assign')
AppConstants = require('../constants/AppConstants.coffee')
BaseUtils = require('../utils/UtilFuncs.coffee')
createStore = require('../utils/StoreUtils.coffee').createStore

ActionTypes = AppConstants.ActionTypes


_loadingCount = 0

_incLoading = ()->
  _loadingCount += 1

_decLoading = ()->
  if _loadingCount <= 0
    _loadingCount = 0
  else
    _loadingCount -= 1


RequestStore = createStore
  isLoading: ->
    _loadingCount > 0
  isNotLoading: ->
    _loadingCount == 0



RequestStore.dispatchToken = AppDispatcher.register (payload)->
  action_type = payload.action.type
  if /.+_REQUEST$/.test(action_type)
    _incLoading()
    RequestStore.emitChange()
  else if /^RECIEVE_.+/.test(action_type) || /.+_RESPONSE$/.test(action_type)
    _decLoading()
    RequestStore.emitChange()

module.exports = RequestStore
