$(document).ready () ->
  #window.buys = new POV.models.Buys
  #buys.fetch()
  window.candidates = new POV.models.Candidates
  candidates.fetch()#( buys: buys )
  window.interactives = new POV.views.Interactives
    el: "#interactives"
  interactives.render()
