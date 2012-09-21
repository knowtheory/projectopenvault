POV.models.Buy = Backbone.Model.extend
  initialize: (attributes, options) ->
    @_start_date = new Date "#{attributes.start_date} CDT"
    @_end_date   = new Date "#{attributes.end_date} CDT"
    @start_time = this.parse_time(attributes.start_time)
    @end_time = this.parse_time(attributes.end_time)

  parse_time: (time) ->
    matcher     = /(\d{1,2})(:(\d{2}))?\s+([axp]\.?m\.?)/
    results     = time.match(matcher)
    [match, hour, nobody_cares, minute, time_of_day] = results
    { hour: +hour, minute: (+minute || 0), time_of_day: time_of_day }
  
  start_date: () -> DateUtils.create("%b. %d")(@_start_date)
  end_date: () -> DateUtils.create("%b. %d")(@_end_date)
    
POV.models.Buys = Backbone.Collection.extend
  name: "buys"
  url: "/spending",
  model: POV.models.Buy,
  comparator: (model) -> model.get('start_date')
  total_cost: ->
    this.reduce ((grand_total, buy) -> grand_total + buy.get 'total_cost'), 0
  sorter: (property) ->
    time_sorter = (one, two) ->
      if one.time_of_day < two.time_of_day
        -1
      else if two.time_of_day < one.time_of_day
        1
      else
        if one.hour < two.hour
          -1
        else if two.hour < one.hour
          1
        else
          if one.minute < two.minute
            -1
          else if two.minute < one.minute
            1
          else
            0

    sorter = switch property
      when "start_date" then (model) -> model._start_date
      when "end_date"   then (model) -> model._end_date
      when "start_time" then (one, two) -> time_sorter(one.start_time,two.start_time)
      when "end_time"   then (one, two) -> time_sorter(one.end_time,two.end_time)
      else                   (model) -> model.get(property)

POV.models.BuyProperties = Backbone.Collection.extend
  current_filter: () ->
    @filter
