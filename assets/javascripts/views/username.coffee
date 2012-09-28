POV.views.Byline = Backbone.View.extend
  tagName:   "span"
  className: "byline"
  fullNames:       
    knowtheory:    "Ted Han"
    davidherzog:   "David Herzog"
    janetsaidi:    "Janet Saidi"
    joyandstuff:   "Joy Mayer"
    mfpatane:      "Matthew Patane"
    ryanfamuliner: "Ryan Famuliner"
    scottphamkbia: "Scott Pham"
    swaffords:     "Scott Swafford"
    jenleereeves:  "Jen Lee Reeves"
    projectopenvault: "Project OpenVault Team"
  
  affiliations:
    knowtheory:    "Project Open Vault"
    davidherzog:   "Project Open Vault"
    janetsaidi:    "KBIA Radio"
    joyandstuff:   "The Columbia Missourian"
    mfpatane:      "Project Open Vault"
    ryanfamuliner: "KBIA Radio"
    scottphamkbia: "KBIA Radio"
    swaffords:     "The Columbia Missourian"
    jenleereeves:  "KOMU8"

  initialize: (options) ->
    @username = (options.username || options.el.html() || "").toLowerCase()
  
  render: () ->
    """#{@fullNames[@username]} <span class="affiliation">(#{@affiliations[@username]})</span>"""

  attach: -> this.$el.html @render()
