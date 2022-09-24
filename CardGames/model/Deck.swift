//
//  Deck.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import Foundation

class Deck {
    private var deck = [PlayingCard]()
    
    func createDeck(){
        deck.removeAll()
        Suit.allCases.forEach{ suit in
            Rank.allCases.forEach {rank in
                deck.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    var count : Int {
        deck.count
    }
    
    func printDeck(){
        deck.forEach {
            print($0.display())
        }
    }
    
    func shuffle(){
        deck.shuffle()
        deck.shuffle()
    }
    
    func deal() -> PlayingCard {
        return deck.removeFirst()
    }
    
    func receive(cards : [PlayingCard]){
        deck.append(contentsOf: cards)
    }
    

}
