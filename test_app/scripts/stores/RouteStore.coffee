AppDispatcher = require('../dispatcher/AppDispatcher.js')
AppConstants = require('../constants/AppConstants.coffee')
SessionStore = require('../stores/SessionStore.coffee')
WebsiteStore = require('../stores/WebsiteStore.coffee')
AlertStore = require('../stores/AlertStore.coffee')
EventEmitter = require('events').EventEmitter
assign = require('object-assign')
Router = require('react-router')
Routes = require('../Routes.coffee')


router = Router.create
  routes: routes
  location: null#Router.HistoryLocation
ActionTypes = AppConstants.ActionTypes
CHANGE_EVENT = 'change'

RouteStore = assign {}, EventEmitter.prototype,
  emitChange: ->
    @emit CHANGE_EVENT
    return
  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
    return
  removeChangeListener: ->
    @removeListener CHANGE_EVENT, callback
    return
  getRouter: ->
    return router
  redirectHome: ->
    router.transitionTo 'app'
    return

RouteStore.dispatchToken = AppDispatcher.register (payload)->
  AppDispatcher.waitFor [
    SessionStore.dispatchToken
    AlertStore.dispatchToken
  ]
  action = payload.action
  if AlertStore.noErrors()
    switch action.type
      when ActionTypes.REDIRECT
        router.transitionTo action.route
      when ActionTypes.LOGIN_RESPONSE
        if SessionStore.isLoggedIn()
          router.transitionTo 'app'
      when ActionTypes.LOGOUT
          router.transitionTo 'login'
      # EXAMPLE: after success of resource creation,
      # redirect where ever is necessary, if necessary
      # when ActionTypes.RECEIVE_CREATED_RESOURCE
      #   if ResourceStore.valid()
      #     router.transitionTo 'app'
  true

module.exports = RouteStore
