POV = 
  models: {}
  views: {}

Backbone.sync = _.wrap Backbone.sync, (sync, method, model, options) ->
  getValue = (object,prop) ->
    if (!(object && object[prop]))
      null
    else
      if _.isFunction(object[prop]) then object[prop]() else object[prop]

  opts = _.extend(options, {dataType: 'jsonp'})
  opts.url = getValue(model, 'url') or urlError() unless options.url
  opts.url = unless /^http/.test opts.url then POV.host + opts.url else opts.url
  sync method, model, opts
