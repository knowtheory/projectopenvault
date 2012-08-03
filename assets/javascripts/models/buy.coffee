POV.models.Buy = Backbone.Model.extend()

POV.models.Buys = Backbone.Collection.extend
  name: "buys"
  url: "/spending",
  model: POV.models.Buy,
  total_cost: ->
    this.reduce ((grand_total, buy) -> grand_total + buy.get 'total_cost'), 0
