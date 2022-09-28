//
//  Hand.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import Foundation

///Player can swap one card with the middle or all 3
enum Turn {
    case swap(hand : PlayingCard, middle : PlayingCard)
    case all
}

struct ScoredTurn {
    let turn : Turn
    let score : BragHandScore
}

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
    
    func createdScoredTurn(_ playerCard : PlayingCard,_ middleCard : PlayingCard) -> ScoredTurn {
        //TODO generate the hand
        return ScoredTurn(
            turn: .swap(hand: playerCard, middle: middleCard),
            score: BragHandScore(type: .prial, score: 0))
    }
    
    func generatePossibleTurns(middle : PlayerHand) -> [ScoredTurn] {
        var turns = [ScoredTurn]()
        hand.forEach{ playerCard in
            middle.hand.forEach{middleCard in
                turns.append(createdScoredTurn(playerCard, middleCard))
            }
        }
        //Finally swap all 3
        turns.append(ScoredTurn(turn: .all, score: middle.score))
        return turns
    }

}
