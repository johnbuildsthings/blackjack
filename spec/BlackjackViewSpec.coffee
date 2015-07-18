assert = chai.assert
expect = chai.expect

  
app = new App();
appView = new AppView(model: app)
appView.$el.appendTo 'body'
console.log(appView)

describe 'Black Jack View', ->
  it 'should be an instanceof AppView', ->
    expect(appView).to.be.instanceof(AppView);

  it 'should have three buttons', -> 
    buttons = appView.$('button');
    console.log(buttons);
    assert.strictEqual buttons.length, 3

  it 'should have two handViews', ->
    playerhand = appView.$('.player-hand-container')
    dealerhand = appView.$('.dealer-hand-container')

    assert.strictEqual playerhand.length, 1
    assert.strictEqual dealerhand.length, 1