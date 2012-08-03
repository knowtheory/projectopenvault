POV.views.Interactives = Backbone.View.extend
  id: "interactives"
  initialize: (options) ->
    this.views = options.views
  render: () ->
    this.views.map((view) -> view.render()).join("\n")
  attach: () ->
    this.$el.html(this.render())

