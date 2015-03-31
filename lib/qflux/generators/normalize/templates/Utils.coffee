SessionStore = require('../../stores/SessionStore.coffee')
normalizr = require('normalizr')
normalize = normalizr.normalize
Schema = normalizr.Schema
arrayOf = normalizr.arrayOf

# Headers
_setAuthHeadersforRequest = (req)->
  for key, val of SessionStore.getAuthHeaders()
    req.set(key, val)
  return req

_setJson = (req)->
  return req.set('Accept', 'application/json')

_normalizeErrors = (res)->
  if res.status == 500
    res.body = {errors: "Uh oh...something went wrong. Don't worry, our developers have been notified."}
    return true
  else if res.status == 422
    return true
  else
    return false
  

# Schemas
session = new Schema 'session'
# Schema Example
#resource = new Schema 'resources'

module.exports =
  setHeadersAndJson: (req)->
    _setJson(req)
    _setAuthHeadersforRequest(req)
    return req
  ## Normalization Example
  # normalizeResourcesResponse: (res)->
  #   SessionStore.updateHeadersFromResponse(res)
  #   return res if _normalizeErrors(res)
  #   normalize res.body, 
  #     resources: arrayOf(resource)
  
  # normalizeResourceResponse: (res)->
  #   SessionStore.updateHeadersFromResponse(res)
  #   return res if _normalizeErrors(res)
  #   normalize res.body, 
  #     resource: resource