POV = 
  models: {}
  views: {}
  host: 'http://localhost:9292'

Backbone.sync = _.wrap Backbone.sync, ((sync, method, model, options) -> 
  getValue = (object,prop) ->
    if (!(object && object[prop]))
      null
    else
      if _.isFunction(object[prop]) then object[prop]() else object[prop]

  opts = _.extend(options, {dataType: 'jsonp'})
  url = getValue(model, 'url') or urlError() unless options.url
  url = unless /^http/.test url then POV.host + url else url
  sync(method, model, _.extend(options, {dataType: 'jsonp', url: url})))

#jsonp_sync = _.wrap(Backbone.sync, ((sync, method, model, options) -> 
#  sync(method, model, _.extend(options, {dataType: 'jsonp'}))))

