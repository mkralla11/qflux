AppDispatcher = require('../dispatcher/AppDispatcher.js')
Constants = require('../constants/Constants.coffee')
assign = require('object-assign')
{ createStore, mergeIntoBag } = require('../utils/StoreUtils.coffee')
{ trycatch } = require('../utils/UtilFuncs.coffee').BaseUtils

ActionTypes = Constants.ActionTypes

_<%= name.pluralize.camelize(:lower) %> = {}
_errors = {}

# createStore function extends our store with EventEmitter.prototype
# allowing views to add/remove callbacks to/from the listeners in this store,
# view example: store.addChangeListener(doACallBack)
<%= name.singularize.camelize %>Store = createStore
  getAll<%= name.pluralize.camelize %>: ->
    _<%= name.pluralize.camelize(:lower) %>
  getErrors: ->
    _errors
  resetErrors: ->
    _errors = {}
  setErrors: (err)->
    _errors = err
  valid: ->
    Object.keys(_errors).length == 0


<%= name.singularize.camelize %>Store.dispatchToken = SmallAppDispatcher.register (payload) ->
  action = payload.action
  status = trycatch -> action.response.status

  # every request needs a status. Skip handling if 500, let AlertStore handle it
  unless status == null or status == 500
    switch action.type
      when ActionTypes.RECEIVE_<%= name.pluralize.upcase %>
        fetched<%= name.pluralize.camelize %> = action.response.entities.<%= name.underscore.downcase %>
        <%= name.singularize.camelize %>Store.resetErrors()
        mergeIntoBag(_<%= name.underscore.downcase %>, fetched<%= name.pluralize.camelize %>)
        <%= name.singularize.camelize %>Store.emitChange()
      when ActionTypes.RECEIVE_CREATED_<% name.singularize.upcase %>
        if status == 422
          <%= name.singularize.camelize %>Store.setErrors(action.response.body.errors)
          # no other object will need to see them
          delete action.response.body.errors
        else
          mergeIntoBag(_<%= name.underscore.downcase %>, action.response.entities.<%= name.underscore.downcase %>)
          <%= name.singularize.camelize %>Store.resetErrors()
        <%= name.singularize.camelize %>Store.emitChange()
  true

module.exports = <%= name.singularize.camelize %>Store