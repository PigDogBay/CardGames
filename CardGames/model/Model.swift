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
    var players = [Player]()
    var gameState : GameState = .setUp
    
    func computerMakeGame(){
        while(gameState != .gameOver){
            updateDisplay()
            updateState()
        }
        if let winner = players.first {
            print("Winner is \(winner.name) with \(winner.lives) lives remaining")
        }
    }

    
    func updateState(){
        switch gameState {
        case .setUp:
            setUpGame()
            gameState = .selectDealer
        case .selectDealer:
            stashAll()
            deck.shuffle()
            gameState = .deal
        case .deal:
            deal()
            gameState = .play
        case .play:
            playRound()
            gameState = .scoreRound
        case .scoreRound:
            scoreRound()
            gameState = .updateLives
        case .updateLives:
            removeLosers()
            gameState = isGameWon() ? .gameOver : .selectDealer
        case .gameOver:
            break
        }
    }
    
    func updateDisplay(){
        switch gameState {
        case .setUp:
            print("Setting up")
        case .selectDealer:
            print("Selecting the dealar")

        case .deal:
            print("Dealing")

        case .play:
            print("Playing")

        case .scoreRound:
            displayHands()
            print("End of Round")

        case .updateLives:
            print("Updating lives")

        case .gameOver:
            print("GAME OVER")

        }
    }
    
    func setUpGame(){
        deck.createDeck()
        deck.shuffle()
        players.removeAll()
        players.append(contentsOf: [PLAYER_CHRIS,PLAYER_LEON, PLAYER_BOMBER, PLAYER_HOWE])
        //Set up lives
        players.forEach{
            $0.lives = 3
        }

    }
    
    func stashAll(){
        players.forEach{
            deck.receive(cards: $0.hand.stash())
        }
        deck.receive(cards: middle.stash())
    }
    
    func deal(){
        for _ in 1...3 {
            players.forEach{
                $0.hand.receive(card: deck.deal())
            }
            middle.receive(card: deck.deal())
        }
    }
    
    func playRound(){
        players.forEach{
            $0.play(middle: middle)
        }
    }
    
    func displayHands(){
        print("Middle: \t\(middle.display())")
        players.forEach{
            print("\($0.name): \t\($0.hand.display()) \tScore: \($0.hand.score) \tLives:\($0.lives)")
        }
    }
    
    /// Find losing hand and lose player a life
    func scoreRound(){
        if let loser = players.min(by: {a,b in a.hand.score < b.hand.score}) {
            loser.lives = loser.lives - 1
        }
    }
    
    func removeLosers(){
        let remaining = players.filter{$0.lives>0}
        players.removeAll()
        players.append(contentsOf: remaining)
    }
    
    func isGameWon() -> Bool{
        return players.count < 2
    }
}
