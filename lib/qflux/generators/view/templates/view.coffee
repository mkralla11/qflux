React = require('react')
RouteHandler = require('react-router').RouteHandler
PropTypes = React.PropTypes
connectToStores = require('../utils/ConnectToStores.coffee')

#Store1 = require(../stores/store1.coffee)
#Store2 = require(../stores/store2.coffee)
#Store3 = require(../stores/store3.coffee)

<%= view_name %> = React.createClass
  # define props interface here
  propTypes:
    firstProp:  PropTypes.bool.isRequired
    secondProp: PropTypes.string
    thirdProp:  PropTypes.any

  # define private helper methods
  _privateHelper: ->
    return

  # define public helper methods
  publicHelper: ->
    return

  render: ->
    return


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


module.exports = connectToStores(<%= view_name %>, [
  #Store1
  #Store2
  #store3
], pickProps, getState)
