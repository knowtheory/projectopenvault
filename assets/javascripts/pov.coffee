$(document).ready () ->
  aggregate_data = new Backbone.Model
  window.aggregate_display = new POV.views.AggregateDisplay
    el: "#aggregate"
    model: aggregate_data
  aggregate_data.fetch(url: "/spending/aggregate")
  window.interactives = new POV.views.Interactives
    el: "#interactives"
