# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', 'none'
    @set 'stillPlaying', true

    @set 'game', game = new GameModel({playerHand: @get('playerHand'), dealerHand: @get("dealerHand")})


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