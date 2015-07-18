# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @newHand()


    @get('playerHand').on('playerHit', -> 
      @get('game').playerTurn()
    @)

    @get('playerHand').on('stand', ->
      @get('game').dealerTurn()
    @)

    @get('game').on('dealerWin', ->
      @set('winner', 'dealer')
      @set('stillPlaying', false)
    @)    

    @get('game').on('playerWin', ->
      @set('winner', 'player')
      @set('stillPlaying', false)
    @)

  # Reset all most of our game state to play another hand
  newHand: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'winner', 'none'
    @set 'stillPlaying', true

    @set 'game', game = new GameModel({playerHand: @get('playerHand'), dealerHand: @get("dealerHand")})

