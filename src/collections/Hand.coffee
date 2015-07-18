class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer, @didWin) ->
    # @set('didWin', false)

  # defaults:
  #   { 'didWin' : false }

  # didWin : false

  hit: ->
    @add(@deck.pop())
    if (!@get('isDealer'))
      @trigger('playerHit', @)


  # TODO: handle stand() call from AppView
  stand: ->
    console.log "player stand"
    @trigger('stand', @)

  # win will be called on the winning hand at the end of a game
  # to trigger an update in the HandView
  win: ->
    @set('didWin', true)

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


