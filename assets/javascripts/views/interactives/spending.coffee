POV.views.Spending = Backbone.View.extend
  selector: "#spending"
  id: "spending"
  events: 
    "click .navigation .facets span": "openTab"
  initialize: (options) ->
    @selector = options.selector or @selector
    @views =
      navigation: new POV.views.SpendingNavigation
      content   : new POV.views.SpendingContent
  render:       () -> this.$el.append view for view in @renderViews()
  renderViews:  () -> [@views.navigation.render(), @views.content.render()]
  attach:     (el) -> @setElement(el.find(@selector)) and @attachViews()
  attachViews:  () -> view.attach(this.$el) for selector, view of @views
  openTab: (event) -> @views.content.open @views.navigation.activeTabFor(event)

POV.views.SpendingNavigation = Backbone.View.extend
  selector:  ".navigation"
  className: "navigation"
  initialize: (options) -> @selector = options.selector if options?.selector
  render: () ->
    this.$el.html """
    <p class="title">Total Ad Spending</p>
    <div class="facets">
      <span class="candidates active">Candidate</span>
      <span class="committees">Committee</span>
      <span class="offices">Office</span>
    </div>
    """
  attach: (el) -> @setElement el.find(@selector)
  activeTabFor: (tab_name) ->
    active = this.$el.find(".facets span.active")
    clicked = $(event.target)
    active.removeClass('active')
    class_name = clicked.attr('class')
    clicked.addClass('active')
    class_name
    
POV.views.SpendingContent = Backbone.View.extend
  selector: ".content"
  className: "content"
  events: {}
  initialize: (options) ->
    @current_mode = if options?.mode then options.mode else "candidates"
    @modes =
      candidates: candidates
      #committee: committees
      #office:    offices
    @current_page = 1
  render: () ->
    this.$el.html """
    <div class="badges">
      #{@renderViews()}
    </div>
    <div class="pagination">
      <span>Previous</span>
      <span>Next</span>
    </div>
    """
  renderViews:  () -> 
    collection = @modes[@current_mode]
    return unless collection
    models = collection.page(1)
    views = _.map(models, (model) -> new POV.views.SpendingBadge({model:model}) )
    (view.render() for view in views).join("\n")
  attach:     (el) -> @setElement(el.find(@selector)) and @attachViews()
  attachViews:  () -> 
  open: (mode) ->
    @current_mode = mode
    @current_page = 1
    @render()