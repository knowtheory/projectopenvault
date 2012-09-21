POV.views.Buy.Table = Backbone.View.extend
  tagName: 'table'
  events:
    'click th': 'sort'

  initialize: (options) ->
    @filtered = @collection
    options.collection.on('reset', @prepare, this)
    options.collection.on('reset', @render, this)

  prepare: () ->
    column_data = [
      { name: "Station",          property: "station"       },
      { name: "Committee",        property: "committee"     },
      { name: "Run from date",    property: "start_date"    },
      { name: "Run to date",      property: "end_date"      },
      { name: "Run from hour",    property: "start_time"    },
      { name: "Run to hour",      property: "end_time"      },
      { name: "Ads run per week", property: "spots_per_week"},
      { name: "Ad length",        property: "length"        },
      { name: "Cost per ad",      property: "rate_per_spot" },
      { name: "Total spent",      property: "total_cost"    }
    ]
    @columns = new POV.models.BuyProperties(column_data)
    @header = new POV.views.Buy.TableHeader(collection: @columns)
    rows = @rows = []
    @filtered.each (model, index) -> 
      options = { model: model }
      options.className = "blue" if index % 2 == 0
      rows.push new POV.views.Buy.TableRow(options)

  render: () ->
    this.$el.empty()
    this.$el.append @header.render()
    table = this.$el
    _.each(@rows, (row) -> table.append row.render())

  sort: (click) ->
    property = this.$(click.srcElement).attr('class')
    @filtered = new Backbone.Collection(@collection.models)
    @filtered.comparator = @collection.sorter(property)
    @filtered.sort()
    this.prepare()
    this.render()
    

POV.views.Buy.TableHeader = Backbone.View.extend
  tagName: 'tr'
  render: () ->
    header_html = (html, header) -> html += "<th class=\"#{header.get('property')}\">#{header.get('name')}</th>"
    this.$el.html @collection.reduce(header_html, "")

POV.views.Buy.TableRow = Backbone.View.extend
  tagName: 'tr'
  render: () ->
    this.$el.html """
      <td><a href="#{POV.host}/stations/#{ @model.get('station') }.html">#{ @model.get('station') }</a></td>
      <td><a href="#{POV.host}/committees/#{ POV.Utilities.sluggify @model.get('committee') }.html">#{ @model.get('committee') }</a></td>
      <td>#{ @model.start_date() }</td>
      <td>#{ @model.end_date() }</td>
      <td>#{ @model.get('start_time') }</td>
      <td>#{ @model.get('end_time') }</td>
      <td>#{ @model.get('spots_per_week') }</td>
      <td>#{ @model.get('length') }</td>
      <td>#{ @model.get('rate_per_spot') }</td>
      <td>#{ @model.get('total_cost') }</td>
      """
