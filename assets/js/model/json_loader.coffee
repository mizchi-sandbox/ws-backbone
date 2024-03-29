class myapp.model.JsonLoader
  _init_ : {}
  _ignore_: {}

  constructor : (params={})->
    for k,v of @_init_
      if params[k] is undefined
        @[k] = @_init_[k] 
      else 
        @[k] = params[k]

  to_json : (cls)->
    return @toJson(@) if cls is undefined 
    return cls unless cls instanceof Object

    json = {}
    for k,v of cls
      if typeof v is 'function' or @_ignore_[k]?
      else if typeof v in ['string','number','boolean']
        json[k] = v
      else if v instanceof Array 
        json[k] = (@toJson(v[i]) for i in [0...v.length])
      else if v instanceof Object
        json[k] = @toJson(v)
    return json
