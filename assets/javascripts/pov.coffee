$(document).ready () ->
  window.buys = new POV.models.Buys
  buys.fetch()
  window.candidates = new POV.models.Candidates
  candidates.fetch 
    buys: buys
  window.spending_interactive = new POV.views.Spending
    candidates: candidates
    #committees: committees
    #offices: offices
  window.interactives = new POV.views.Interactives
    views: [spending_interactive]
    el: "#interactives"
