POV.views.Spending = Backbone.View.extend
  events: 
    "click .navigation .facets span": "openTab"
  initialize: (options) ->
    this.navigation = new POV.views.SpendingNavigation
      el: this.$el.find ".navigation"
    this.content    = new POV.views.SpendingContent
      el: this.$el.find ".content"
  render: () ->
    this.$el.append this.navigation.attach()
    this.$el.append this.content.attach()
  attach: () ->
    this.render()
  detach: () ->
    this.$el.empty()
  openTab: (event) ->
    this.content.open this.navigation.activeTabFor(event)

POV.views.SpendingNavigation = Backbone.View.extend
  className: "navigation"
  render: () ->
    """
    <p class="title">Total Spending</p>
    <div class="facets">
      <span class="candidate active">Candidate</span>
      <span class="committee">Committee</span>
      <span class="office">Office</span>
    </div>
    """
  attach: () ->
    this.$el.html(this.render())
  detach: () ->
    this.$el.remove()
  activeTabFor: (tab_name) ->
    active = this.$el.find(".facets span.active")
    clicked = $(event.target)
    active.removeClass('active')
    class_name = clicked.attr('class')
    clicked.addClass('active')
    class_name
    
POV.views.SpendingContent = Backbone.View.extend
  className: "content"
  events: {}
  initialize: (options) ->
    this.current_mode = if options.mode? then options.mode else "candidate"
    this.modes =
      candidate: candidates
      #committee: committees
      #office:    offices
    this.current_page = 1
    console.log("init")
  render: () -> 
    console.log("rendering")
    collection = this.modes[this.current_mode]
    models = collection
    console.log(models)
    console.log(models.length)
    views = models.map( (model) -> new POV.views.SpendingBadge({model:model}) )
    console.log(views)
    """
    <div class="badges">
      #{(view.render() for view in views).join("\n")}
    </div>
    """
    
  attach: () -> this.$el.html(this.render())
  open: (mode) ->
    this.current_mode = mode
    this.current_page = 1
    this.attach()