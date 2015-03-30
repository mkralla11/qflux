React = require('react')
shallowEqual = require('react/lib/shallowEqual')
assign = require('object-assign')

ConnectToStores = (Component, stores, pickProps, getState) ->
  StoreConnector = React.createClass
    getStateFromStores: (props)->
      return getState(pickProps(props))

    getInitialState: ->
      @getStateFromStores(@props)


    componentDidMount: -> 
      stores.forEach (store)=>
        store.addChangeListener(@handleStoresChanged)
      

      @setState(@getStateFromStores(@props))


    componentWillReceiveProps: (nextProps) ->
      if !shallowEqual(pickProps(nextProps), pickProps(@props))
        @setState(@getStateFromStores(nextProps))


    componentWillUnmount: ->
      stores.forEach (store)=>
        store.removeChangeListener(@handleStoresChanged)

    handleStoresChanged: ->
      if @isMounted()
        @setState(@getStateFromStores(@props))

    render: ->
      React.createFactory(Component)(assign({}, @props, @state))

  return StoreConnector


module.exports = ConnectToStores