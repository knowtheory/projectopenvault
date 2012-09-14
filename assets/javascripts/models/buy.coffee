POV.models.Buy = Backbone.Model.extend
  initalize: (attributes, options) ->
    @start_date = new Date "#{attributes.start_date} CDT"
    @end_date = new Date "#{attributes.end_date} CDT"

POV.models.Buys = Backbone.Collection.extend
  name: "buys"
  url: "/spending",
  model: POV.models.Buy,
  comparator: (model) -> model.get('start_date')
  total_cost: ->
    this.reduce ((grand_total, buy) -> grand_total + buy.get 'total_cost'), 0
