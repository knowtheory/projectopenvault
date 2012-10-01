$(document).ready () ->
  window.bylines = []
  _.each $(".byline"), (el) ->
    byline = new POV.views.Byline(el: $(el))
    bylines.push byline
    byline.attach()
  aggregate_data = new Backbone.Model
  window.aggregate_display = new POV.views.AggregateDisplay
    el: "#aggregate"
    model: aggregate_data
  aggregate_data.fetch(url: "/spending/aggregate")
  window.interactives = new POV.views.Interactives
    el: "#interactives"
