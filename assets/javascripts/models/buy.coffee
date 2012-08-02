POV.models.Buy = Backbone.Model.extend
  parse: (response) ->
    console.log("RESPONSE")
    console.log(response)
    response

POV.models.Buys = Backbone.Collection.extend
  url: "/spending",
  model: POV.models.Buy,
  total_cost: ->
    this.reduce ((grand_total, buy) -> grand_total + buy.get 'total_cost'), 0
