SessionStore = require('../stores/SessionStore.coffee')

Authentication = statics: willTransitionTo: (transition) ->
  nextPath = transition.path
  if !SessionStore.isLoggedIn()
    transition.redirect '/login', {}, 'nextPath': nextPath
  return
  
module.exports = Authentication