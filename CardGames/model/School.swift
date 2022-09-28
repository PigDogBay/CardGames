//
//  School.swift
//  CardGames
//
//  Created by Mark Bailey on 26/09/2022.
//

import Foundation

class School {
    var players = [Player]()

    func setUpPlayers(){
        players.removeAll()
        players.append(contentsOf: [PLAYER_CHRIS, PLAYER_LEON, PLAYER_BOMBER, PLAYER_HOWE])
        //Set up lives
        players.forEach{
            $0.lives = 3
        }
    }
    
    func getPlayer(name : String) -> Player?{
        return players.first(where: {$0.name == name})
    }
    
    func stashCards(deck : Deck){
        players.forEach{
            deck.receive(cards: $0.hand.stash())
        }
    }
    
    func resolveHands(){
        players.forEach{
            $0.resolveHand()
        }
    }
    
    func isPrialOut() -> Bool{
        return !players.filter{$0.score.type == .prial}
            .isEmpty
    }
    
    ///Needed to find player with largest Prial
    func highestScoringPlayer() -> Player? {
        return players.max(by: {$0.score < $1.score})
    }
    
    func determineLosingHands() -> [Player]? {
        if isPrialOut(){
            let topPlayer = highestScoringPlayer()
            //"Prial out, everyone (else) out!" cries the top player
            return players.filter{$0.name != topPlayer?.name}
            
        }
        return Dictionary(grouping: players, by:  {$0.score.score})
            .min(by: {$0.key < $1.key})
            .map{$0.value}
    }
    
    func removePlayersWithNoLivesLeft() {
        let remaining = players.filter{$0.lives>0}
        players.removeAll()
        players.append(contentsOf: remaining)
    }
    
    func areAllPlayersOut() -> Bool {
        players.filter{$0.lives != 0}.count == 0
    }
    ///If all players had the same hand and so are all out
    ///then no one has won the game, so this round needs
    ///to be replayed, give the remaining players 1 life back.
    func reinstatePlayers() {
        players.forEach{$0.lives = 1}
    }
    
}
