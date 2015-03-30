AppDispatcher = require('../dispatcher/AppDispatcher.js')
EventEmitter = require('events').EventEmitter
assign = require('object-assign')
AppConstants = require('../constants/AppConstants.coffee')
BaseUtils = require('../utils/UtilFuncs.coffee')

ActionTypes = AppConstants.ActionTypes


CHANGE_EVENT = 'change'
_alerts = {}

_addAlert = (obj)->
  assign _alerts, obj

AlertStore = assign {}, EventEmitter.prototype,
  emitChange: ->
    @emit CHANGE_EVENT
    return
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
    return
  removeChangeListener: ->
    @removeListener CHANGE_EVENT, callback
    return
  noErrors: ->
    _alerts.errors == null || _alerts.errors == undefined || Object.keys(_alerts.errors).length == 0
  dismissAlert: (key)->
    _alerts[key] = null
  dismissAllAlerts: ()->
    _alerts = {}
  getAllAlerts: ()->
    _alerts
  getAllAlertsAsArray: ()->
    arr = []
    for own key, val of _alerts
      if Array.isArray val
        arr = arr.concat(val)
      else
        arr.push(val)
    return arr

AlertStore.dispatchToken = AppDispatcher.register (payload)->
  mainErr = BaseUtils.trycatch -> payload.action.response.body.errors
  if !!mainErr
    _addAlert payload.action.response.body
    AlertStore.emitChange()
  true

module.exports = AlertStore
