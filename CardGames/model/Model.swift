//
//  Model.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import Foundation


enum GameState {
    case setUp, selectDealer, deal, play, scoreRound, updateLives, gameOver
}

class Model {
    
    let deck = Deck()
    let middle = PlayerHand()
    let school = School()
    var gameState : GameState = .setUp
    var gameListener : GameListener? = nil
    var nextPlayer : Player? = nil
//    var rules : GameVariation = VariationAllUp()
    var rules : GameVariation = VariationOneDown()

    func computerMakeGame(){
        for _ in 1...1000 {
            while(gameState != .gameOver){
                updateState()
            }
            if let winner = school.players.first {
                winner.gamesWon += 1
                gameListener?.gameOver(winner: winner)
            }
            gameState = .setUp
        }
        school.getAllPlayers
            .sorted(by: {$0.gamesWon < $1.gamesWon})
            .forEach{printStats($0)}
    }
    
    func printStats(_ player : Player){
        print("\(player.name) \(player.gamesWon)")
    }
    
    
    func updateState(){
        switch gameState {
        case .setUp:
            setUpGame()
            gameState = .selectDealer
        case .selectDealer:
            school.nextDealer()
            deck.shuffle()
            gameListener?.dealerSelected(dealer: school.dealer!)
            gameState = .deal
        case .deal:
            deal()
            gameState = .play
            nextPlayer = school.dealer
        case .play:
            playRound()
        case .scoreRound:
            scoreRound()
            gameState = .updateLives
        case .updateLives:
            stashAll()
            updateLives()
        case .gameOver:
            break
        }
    }
    
    func setUpGame(){
        deck.createDeck()
        deck.shuffle()
        school.setUpPlayers()
    }
    
    func stashAll(){
        do {
            try school.stashCards(deck: deck)
            try deck.receive(cards: middle.stash())
            assert(deck.count==52, "Dropped a card")
        } catch CardErrors.CardAlreadyInThePack(let card){
            print("ERROR: Card already in the pack \(card)")
            assertionFailure("Duplicate card")
        } catch {
            print(error)
            assertionFailure(error.localizedDescription)
        }
    }
    
    func deal(){
        //Deal 3 cards each and 3 in the middle
        for i in 1...3 {
            school.players.forEach{
                $0.hand.receive(card: deck.deal())
            }
            middle.receive(card: deck.deal(dealUp: rules.isMiddleCardFaceUp(dealIndex: i)))
        }
    }
    
    func playRound(){
        nextPlayer = school.nextPlayer(current: nextPlayer!)
        gameListener?.turnStarted(player: nextPlayer!, middle: middle)
        let turn = nextPlayer?.play(middle: middle)
        rules.arrangeMiddle(middle: middle, turn: turn!)
        gameListener?.turnEnded(player: nextPlayer!, middle: middle, turn: turn!)
        if nextPlayer == school.dealer {
            //dealer is last player
            gameState = .scoreRound
        }
    }
    
    /// Find losing hand and lose player a life
    func scoreRound(){
        school.showAllHands()
        gameListener?.showHands(players: school.players)
        school.resolveHands()
        if let losingPlayers = school.determineLosingHands(){
            losingPlayers.forEach{
                $0.lives = $0.lives - 1
            }
            gameListener?.roundEnded(losingPlayers: losingPlayers)
        }
    }
    func updateLives(){
        let pegPullers = school.playersWithNoLivesLeft()
        gameListener?.pullThePeg(outPlayers: pegPullers)
        school.removePlayersWithNoLivesLeft()
        if school.areAllPlayersOut() {
            //Oops no one won, so play another round
            school.reinstatePlayers()
            gameListener?.everyoneOutSoReplayRound()
        }
        gameState = isGameWon() ? .gameOver : .selectDealer
    }
    
    func isGameWon() -> Bool{
        return school.players.count < 2
    }
}
