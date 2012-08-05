POV = 
  models: {}
  views: {}
  host: 'http://pov.knowtheory.net'
  formatDollars: (value) ->
    characters = '' + value
    groups = []
    group_count = Math.ceil characters.length / 3
    end = characters.length
    while (end > 0)
      start = end - 3
      start = 0 if start < 0
      groups.push(characters.slice(start, end))
      end -= 3
    groups.reverse().join(',')
  

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
