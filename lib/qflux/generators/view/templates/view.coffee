React = require('react')
# instantiate dom element funcs
{div, a}= React.DOM

RouteHandler = require('react-router').RouteHandler
PropTypes = React.PropTypes
<% if options["connect_to_stores"] %>
connectToStores = require('../utils/ConnectToStores.coffee')
#Store1 = require('../stores/store1.coffee')
#Store2 = require('../stores/store2.coffee')
#Store3 = require('../stores/store3.coffee')
<%else%>#Store1 = require('../stores/store1.coffee')<%end%>

<%= template_name %> = React.createClass
  # define props interface here
  propTypes:
    firstProp:  PropTypes.bool.isRequired
    secondProp: PropTypes.string
    thirdProp:  PropTypes.any
<% if !options["connect_to_stores"] %>
  getInitialState: ->
    # items: Store1.getAllItems()
    # errors: Store1.getErrors()

  componentDidMount: ->
    ### BIND: store listeners and dom events ###
    # Store1.addChangeListener(this._onChange)

  componentWillUnmount: ->
    ### UNBIND: store listeners and dom events ###
    # Store1.removeChangeListener(this._onChange)

  _onChange: ->
    # @setState
    #   websites: Store1.getAllItems()
    #   errors: Store1.getErrors()
<% end %>
  # define private helper methods
  _privateHelper: ->

  # define public helper methods
  publicHelper: ->

  render: ->
    <%= 'RouteHandler' if options["layout"] %>



# define pickProps func consumed by connectToStores
# that will parse desired props from parent
# component
pickProps = (params) ->
  params

# define getState func consumed by connectToStores
# this is where you want to grab data from stores
# 
getState = (params) ->
  {
    firstState: "a state"
    # Store1State:  Store1.getState()
    # Store2State:  Store2.getState()
    # Store3State:  Store3.getState()
  }

<% if options["connect_to_stores"] %>
module.exports = connectToStores(<%= template_name %>, [
  #Store1
  #Store2
  #store3
], pickProps, getState)
<%end%>