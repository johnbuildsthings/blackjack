class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="newHand-button">New Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      if (@model.get('stillPlaying'))
        @model.get('playerHand').hit()
    'click .stand-button': -> 
      if (@model.get('stillPlaying'))
        @model.get('playerHand').stand()
    'click .newHand-button': ->
      @model.newHand()
      @render()

  initialize: ->
    @model.on 'change:winner', => 
      winner = @model.get('winner')
      if (winner != 'none')
        alert("#{winner} won")

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

# TODO: handle a 'change' event from the App Model.
