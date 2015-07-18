assert = chai.assert
expect = chai.expect

# describe 'deck', ->
#   deck = null
#   hand = null

#   beforeEach ->
#     deck = new Deck()
#     hand = deck.dealPlayer()

#   describe 'hit', ->
#     it 'should give the last card from the deck', ->
#       assert.strictEqual deck.length, 50
#       assert.strictEqual deck.last(), hand.hit().last()
#       assert.strictEqual deck.length, 49

describe 'Game Model', ->
  deck = null
  playerHand = null
  dealerHand = null
  game = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()
    game = new GameModel({playerHand: playerHand, dealerHand: dealerHand})
    console.log(game)


  it 'bust should return true if score is over 21', ->
  
    bust = game.bust([22, 22])
    assert.strictEqual bust, true

  it 'player turn should trigger dealer win event if player is bust', ->
    dealerhasWon = false
    game.on('dealerWin', ->
      dealerhasWon = true
    @)

    for i in [1..21]
      playerHand.hit()

    game.playerTurn()

    assert.strictEqual dealerhasWon, true

  it 'dealer score should be at least 17', ->
    # startScore = dealerHand.scores()[0];
    game.dealerTurn()
    endScore = dealerHand.scores()[0];

    expect(endScore).to.be.at.least(17)

  it 'should determine whether the player wins or the dealer win at the end', ->
    game.dealerTurn()
    dealerWin = false
    playerWin = true

    game.on('dealerWin', ->
      dealerWin = true
    @)
    game.on('playerWin', ->
      playerWin = true
    @)

    game.endOfGame()

    expect(dealerWin || playerWin).to.be.true



