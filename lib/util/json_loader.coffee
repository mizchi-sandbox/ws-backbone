class JSONLoader
  _init_ : {}
  _ignore_: {}

  constructor : (params={})->
    for k,v of @_init_
      if params[k] is undefined
        @[k] = @_init_[k]
      else
        @[k] = params[k]

  to_json : (cls,depth=3)->
    return @to_json(@,depth-1) if cls is undefined
    return cls unless cls instanceof Object

    json = {}
    for k,v of cls
      if typeof v is 'function' or @_ignore_[k]? or k in ['_ignore_', '_init_']
      else if typeof v in ['string','number','boolean']
        json[k] = v
      else if v instanceof Array
        json[k] = (@to_json(v[i],depth - 1) for i in [0...v.length])
      else if v instanceof Object and depth > 0
        json[k] = @to_json(v, depth - 1)
    json

module.exports = JSONLoader
