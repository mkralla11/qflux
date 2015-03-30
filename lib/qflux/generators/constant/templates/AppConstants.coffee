keyMirror = require('keymirror')
config = require('../utils/Config.js')
APIRoot = "https://" + config.API_URL
isProduction = config.IS_PRODUCTION
authPath = '/auth'

module.exports =
  APIEndpoints:
    APIRoot: APIRoot
    LOGIN: APIRoot + authPath + '/sign_in'
    REGISTRATION: APIRoot + authPath
    OAuth:
      GOOGLE: APIRoot + '/auth/google_oauth2'
      FACEBOOK: APIRoot + '/auth/facebook'

  isProduction: isProduction

  PayloadSources: keyMirror
    SERVER_ACTION: null
    VIEW_ACTION: null
  ,
  ActionTypes: keyMirror
    LOGIN_GOOGLE_REQUEST: null
    LOGOUT: null
    LOGIN_REQUEST: null
    LOGIN_RESPONSE: null
    REDIRECT: null
    ## Example Resource Constants:
    # LOAD_RESOURCE: null
    # RECEIVE_RESOURCES: null
    # LOAD_RESOURCE: null
    # RECEIVE_RESOURCE: null
    # CREATE_RESOURCE: null
    # RECEIVE_CREATED_RESOURCE: null
    <% if options[:resource] %>
    LOAD_<%=name.pluralize.camelize.upcase%>: null
    LOAD_<%=name.singularize.camelize.upcase%>: null
    CREATE_<%=name.singularize.camelize.upcase%>: null
    <%end%><% options[:constants].each do |con| %>
    <%= con %>: null<%end%>