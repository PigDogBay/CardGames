//
//  Hand.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import Foundation


class PlayerHand {
    var hand = [PlayingCard]()
    
    var score : BragHandScore {
        let resolver = HandResolver(hand: hand)
        return resolver.createScore()
    }
    
    func receive(card : PlayingCard){
        hand.append(card)
    }
    
    func display() -> String {
        return hand.reduce(""){ acc, next in
            acc + next.display()
        }
    }
    
    func stash() -> [PlayingCard] {
        let stash = hand
        hand.removeAll()
        return stash
    }
}
