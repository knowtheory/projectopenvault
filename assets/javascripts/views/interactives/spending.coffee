POV.views.Spending = Backbone.View.extend
  selector: "#spending"
  id: "spending"
  events: 
    "click .navigation .facets span": "openTab"
    "click .pagination .previous"   : "clickPreviousPage"
    "click .pagination .next"       : "clickNextPage"
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
  clickPreviousPage: (event) -> @views.content.previousPage()
  clickNextPage:     (event) -> @views.content.nextPage()

POV.views.SpendingNavigation = Backbone.View.extend
  selector:  ".navigation"
  className: "navigation"
  initialize: (options) -> @selector = options.selector if options?.selector
  render: () ->
    this.$el.html """
    <p class="title">Total TV Ad Spending</p>
    <div class="facets">
      <span class="candidates active">Candidate</span>
      <span class="committees">Committee</span>
      <span class="offices">Office</span>
    </div>
    <div class="pagination">
      <div class="next">Next</div>
      <div class="previous">Previous</div>
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
      #office:    offices
    @current_collection = @modes[@current_mode].collection
    @current_page = 0
  render: () ->
    this.$el.html """
    <div class="badges">
      #{@renderViews()}
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

POV.views.CandidateBadge = Backbone.View.extend
  render: ->
    """
    <div class="badge">
      <img src="#{POV.host}/assets/candidates/#{this.model.get('slug')}_headshot.jpg"}></img>
      <div class="info">
        <p class="name">#{this.model.get('name')}</p>
        <p class="office">for #{this.model.get('office') || ''}</p>
        <p class="dollars-spent">$#{POV.formatDollars(this.model.get('total_spent') || 0)}</p>
      </div>
    </div>
    """
  attach: -> this.$el.html @render()

POV.views.CommitteeBadge = Backbone.View.extend
  render: ->
    """
    <div class="badge">
      <img src="#{POV.host}/assets/committees/#{this.model.get('slug')}.jpg"}></img>
      <div class="info">
        <p class="name">#{this.model.get('name')}</p>
        <p class="dollars-spent">$#{POV.formatDollars(this.model.get('total_spent') || 0)}</p>
      </div>
    </div>
    """
  attach: -> this.$el.html @render()
