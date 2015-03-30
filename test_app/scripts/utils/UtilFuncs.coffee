
trycatch = (func)->
  try
    func.call()
  catch
    null

wrap = (obj)->
  if Array.isArray(obj)
    return obj
  else
    return [obj]

module.exports =
  trycatch: trycatch
  wrap: wrap