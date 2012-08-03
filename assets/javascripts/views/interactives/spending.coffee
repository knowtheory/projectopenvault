POV.views.Spending = Backbone.View.extend
  id: 'spending'
  initialize: (options) ->
    this.navigation = new POV.views.SpendingNavigation()
    this.content    = new POV.views.SpendingContent()
  render: () ->
    this.navigation.render()
    this.content.render()
    """
    <div class="content">
    </div>
    """

POV.views.SpendingNavigation = Backbone.View.extend
  events: 
    ".facets span"
  render: () ->
    """
    <div class="navigation">
      <p class="title">Total Spending</p>
      <div class="facets">
        <span class="candidates active">Candidates</span>
        <span class="committee">Committee</span>
        <span class="office">Office</span>
      </div>
    </div>
    """