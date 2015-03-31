React = require('react')
Router = require('react-router')
Route = Router.Route
DefaultRoute = Router.DefaultRoute

App = require('./views/App.react.jsx')
LoginPage = require('./views/session/LoginPage.react.jsx')
SignupPage = require('./views/session/SignupPage.react.jsx')

# Example Resource:
# ResourcesPage = require('./views/resources/Index.coffee')
# ResourcePage = require('./views/resources/Show.coffee')
# ResourceNew = require('./views/resources/New.coffee')

module.exports =
  Route 
    name: "app" 
    handler: App
    path: "/"

    DefaultRoute 
      handler: ResourcesPage,

    Route 
      name: "login" 
      path: "/login" 
      handler: LoginPage,

    Route 
      name: "signup" 
      path: "/signup" 
      handler: SignupPage

    ## Example Resource:    
    # Route 
    #   name: "resources" 
    #   path: "/resources" 
    #   handler: ResourcesPage,

    # Route 
    #   name: "resource" 
    #   path: "/resources/:resourceId" 
    #   handler: ResourcePage,

    # Route 
    #   name: "new-resource" 
    #   path: "/resource/new" 
    #   handler: ResourceNew