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

protocol GameUpdateListener {
    func update(gameState : GameState)
}

class Model {
    
    let deck = Deck()
    let middle = PlayerHand()
    let school = School()
    var gameState : GameState = .setUp
    var listener : GameUpdateListener? = nil
    
    func computerMakeGame(){
        while(gameState != .gameOver){
            listener?.update(gameState: gameState)
            updateState()
        }
        if let winner = school.players.first {
            print("Winner is \(winner.name) with \(winner.lives) lives remaining")
        }
    }
    
    func updateState(){
        switch gameState {
        case .setUp:
            setUpGame()
            gameState = .selectDealer
        case .selectDealer:
            school.nextDealer()
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
            updateLives()
            gameState = isGameWon() ? .gameOver : .selectDealer
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
        school.stashCards(deck: deck)
        deck.receive(cards: middle.stash())
    }
    
    func deal(){
        //Deal 3 cards each and 3 in the middle
        for _ in 1...3 {
            school.players.forEach{
                $0.hand.receive(card: deck.deal())
            }
            middle.receive(card: deck.deal())
        }
    }
    
    func playRound(){
        //dealer goes last
        var nextPlayer = school.dealer
        repeat {
            nextPlayer = school.nextPlayer(current: nextPlayer!)
            nextPlayer?.play(middle: middle)
        } while nextPlayer != school.dealer
    }
    
    /// Find losing hand and lose player a life
    func scoreRound(){
        school.resolveHands()
        school.determineLosingHands()?.forEach{
            $0.lives = $0.lives - 1
        }
    }
    func updateLives(){
        school.removePlayersWithNoLivesLeft()
        if school.areAllPlayersOut() {
            //Oops no one won, so play another round
            school.reinstatePlayers()
        }
    }
    
    func isGameWon() -> Bool{
        return school.players.count < 2
    }
}
