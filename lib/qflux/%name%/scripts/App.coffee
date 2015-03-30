React = require('react')
router = require('./stores/RouteStore.coffee').getRouter()
window.React = React

router.run (Handler, state)->
  React.render Handler, document.getElementById('main')

