EventEmitter = require('events').EventEmitter
assign = require('object-assign')
shallowEqual = require('react/lib/shallowEqual')
_ = require('lodash')

CHANGE_EVENT = 'change'

createStore = (spec)->
  store = assign
    emitChange: ()->
      this.emit(CHANGE_EVENT)
    ,
    addChangeListener: (callback)->
      this.on(CHANGE_EVENT, callback)
    ,
    removeChangeListener: (callback)->
      @removeListener(CHANGE_EVENT, callback)
  , spec, EventEmitter.prototype
  
  for key, val of store
    if _.isFunction(val)
      store[key] = store[key].bind(store)


  store.setMaxListeners(0)
  return store


isInBag = (bag, id, fields)->
  item = bag[id]
  if !bag[id]
    return false
  
  if fields
    return fields.every((field)-> item.hasOwnProperty(field))
  else 
    return true
  


mergeIntoBag = (bag, entities, transform)->
  if !transform
    transform = (x) -> x
  
  for own key, val of entities
    if !bag.hasOwnProperty(key)
      bag[key] = transform(entities[key])
    else if !shallowEqual(bag[key], entities[key])
      bag[key] = transform(assign({}, bag[key], entities[key]))
    
module.exports =
  createStore: createStore
  isInBag: isInBag
  mergeIntoBag: mergeIntoBag
