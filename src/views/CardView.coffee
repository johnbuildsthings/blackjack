class window.CardView extends Backbone.View
  className: 'card'
# <%= rankName %> of <%= suitName %>

  template: _.template '<img src="img/cards/<%=rankName%>-<%=suitName%>.png" />'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    if (@model.get 'revealed')
      @$el.html @template @model.attributes
    else
      @$el.html '<img src="img/card-back.png"/>'
    @$el.addClass 'covered' unless @model.get 'revealed'

