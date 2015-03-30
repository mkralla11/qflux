Server<%= name.singularize.camelize %>ActionCreators = require('../../actions/server/<%= name.singularize.camelize %>ActionCreators.coffee')
AppConstants = require('../../constants/AppConstants.coffee')
APIUtils = require('./Utils.coffee')
request = require('superagent')
APIEndpoints = AppConstants.APIEndpoints


module.exports = <% if options[:resource] %>
  # load many
  load<%= name.pluralize.camelize %>: ->
    r = request.get(APIEndpoints.<%= name.pluralize.upcase %>)
    APIUtils.setHeadersAndJson(r)
    r.end (res) ->
      norm = APIUtils.normalize<%= name.pluralize.camelize %>Response(res)
      Server<%= name.singularize.camelize %>ActionCreators.receive<%= name.pluralize.camelize %> norm

  # load one
  load<%= name.singularize.camelize %>: (<%= name.camelize(:lower) %>Id) ->
    r = request.get(APIEndpoints.<%= name.pluralize.upcase %> + '/' + <%= name.camelize(:lower) %>Id)
    APIUtils.setHeadersAndJson(r)
    norm = APIUtils.normalize<%= name.singularize.camelize %>Response(res)
    r.end (res) ->
      Server<%= name.singularize.camelize %>ActionCreators.receive<%= name.singularize.camelize %> res

  # create one
  create<%= name.singularize.camelize %>: (param1, param2) ->
    r = request.post(APIEndpoints.<%= name.pluralize.upcase %>)
    APIUtils.setHeadersAndJson(r)
    r.send
      <%= name.singularize.downcase %>:
        param1: param1
        param2: param2
    .end (res) ->
      norm = APIUtils.normalize<%= name.singularize.camelize %>Response(res)
      Server<%= name.singularize.camelize %>ActionCreators.receiveCreated<%= name.singularize.camelize %> norm
  <%end%><% options[:api_endpoint_methods].each do |epo| %>
  <%= epo.to_s %>: () ->
    APIUtils.setHeadersAndJson(r)
    norm = APIUtils.normalize<%= name.singularize.camelize %>Response(res)
    r.end (res) ->
      Server<%= name.singularize.camelize %>ActionCreators.receive<%= name.singularize.camelize %> res
  
  <%end%>