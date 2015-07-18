class window.GameModel extends Backbone.Model

  initialize: (params) ->

    @on 'playerHit', =>
      #test for bust 
      #end turn if bust - dealer wins
      console.log('playerHit')
      if bust(@.scores())
        @get 'dealerHand'.win()
        console.log('dealer wins')

      # handle stand event
      # eventually trigger the dealer to get more cards if necessary
      #     dealer reveals first card, then draws till 17+
      # retrieve scores, decide who won ... flow to View to declare a winner
    @on 'stand', =>
      @dealerTurn()
      @endOfGame()

  bust: (scores) ->
    (scores[0] > 21) ? true : false

  playerTurn: ->
    console.log('playerTurn')
    if @bust(@get('playerHand').scores())
      # @get('dealerHand').win()
      @trigger('dealerWin', @)
      console.log('dealer wins')

  dealerTurn: ->
    @get('dealerHand').at(0).flip()
    scores = @get('dealerHand').scores()
    while scores[0] < 17
      @get('dealerHand').hit()
      scores = @get('dealerHand').scores()
    @endOfGame()

  bestScore: (scores) ->
    if (scores[1] > scores[0] && scores[1] < 22)
      scores[1] 
    else 
      scores[0]


  endOfGame: ->
    playerScore = @bestScore (@get('playerHand').scores())
    dealerScore = @bestScore (@get('dealerHand').scores())
    if(@bust(@get('dealerHand').scores()) || playerScore > dealerScore)
      @trigger('playerWin', @)
    else 
      @trigger('dealerWin', @)

