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
    <p class="title">Mid-Missouri TV Ad Spending by:</p>
    <div class="facets">
      <span class="candidates active">Candidate</span>
      <span class="committees">Committee</span>
      <span class="offices">Office</span>
    </div>
    """
  attach: (el) -> @setElement el.find(@selector)
  activeTabFor: (event) ->
    active = this.$el.find(".facets span.active")
    clicked = $(event.target)
    active.removeClass('active')
    class_name = clicked.attr('class')
    clicked.addClass('active')
    class_name

POV.views.SpendingContent = Backbone.View.extend
  events: 
    "click .pagination .previous"   : "clickPreviousPage"
    "click .pagination .next"       : "clickNextPage"
    
  selector: ".content"
  className: "content"
  initialize: (options) ->
    @current_mode = if options?.mode then options.mode else "candidates"
    @modes =
      candidates: 
        collection: candidates
        view:       POV.views.CandidateBadge
      committees: 
        collection: committees
        view:       POV.views.CommitteeBadge
      offices:
        collection: offices
        view:       POV.views.OfficeBadge
    @current_collection = @modes[@current_mode].collection
    @current_page = 0
  render: () ->
    this.$el.html """
    <div class="badges">
      #{@renderViews()}
    </div>
    <div class="pagination">
      <div class="next">Next</div>
      <div class="previous">Previous</div>
    </div>
    """
  renderViews:  () -> 
    return unless @current_collection
    @current_pages = @current_collection.pages(6)
    @current_models = @current_pages[@current_page]
    views = _.map(@current_models, (model) => new @modes[@current_mode].view({model:model}) )
    (view.render() for view in views).join("\n")
  attach:     (el) -> @setElement(el.find(@selector)) and @attachViews()
  attachViews:  () -> 
  open: (mode) ->
    @current_mode = mode
    @current_page = 0
    @current_collection = @modes[@current_mode].collection
    @render()
  previousPage: () -> 
    @current_page = @current_pages.length if @current_page == 0
    @current_page--
    @render()
  nextPage:     () -> 
    @current_page++
    @current_page = 0 if @current_page == @current_pages.length
    @render()
  clickPreviousPage: (event) -> @previousPage()
  clickNextPage:     (event) -> @nextPage()
