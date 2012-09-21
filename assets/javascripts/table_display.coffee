#= require ./lib/date_utils
#= require ./lib/jquery-1.7.2.min
#= require ./lib/underscore-1.3.3
#= require ./lib/backbone-0.9.2
#= require initialize
#= require utilities
#= require_tree ./models
#= require_tree ./views

$(document).ready () ->
  aggregate_data = new Backbone.Model
  window.aggregate_display = new POV.views.AggregateDisplay
    el: "#aggregate"
    model: aggregate_data
  aggregate_data.fetch(url: "/spending/aggregate")
