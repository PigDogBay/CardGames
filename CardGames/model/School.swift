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
    
    func determineLosingHands() -> [Player]? {
        return Dictionary(grouping: players, by:  {$0.hand.score})
            .min(by: {$0.key < $1.key})
            .map{$0.value}
    }
}
