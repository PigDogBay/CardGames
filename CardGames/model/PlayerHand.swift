//
//  Hand.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import Foundation

///Player can swap one card with the middle or all 3
enum Turn : Equatable {
    case swap(hand : PlayingCard, middle : PlayingCard)
    case all
    
    func display() -> String {
        switch self {
        case .swap(hand: let hand, middle: let middle):
            return "Swap \(hand.display()) for \(middle.display())"
        case .all:
            return "All"
        }
    }
}

struct ScoredTurn {
    let turn : Turn
    let score : BragHandScore
    let middleScore : BragHandScore
    func display() -> String {
        return "\(turn.display()) score: \(score.display()), middle: \(middleScore.display())"
    }
}

class PlayerHand {
    var hand : [PlayingCard]
    
    var score : BragHandScore {
        let resolver = HandResolver(hand: hand)
        return resolver.createScore()
    }
    
    init(hand : [PlayingCard]){
        self.hand = hand
    }
    
    convenience init(){
        self.init(hand: [PlayingCard]())
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
    
    func replace(cardInHand : PlayingCard,  with : PlayingCard) {
        if let index = hand.firstIndex(of: cardInHand) {
            hand.remove(at: index)
            hand.append(with)
        }
    }
    
    func play(turn : Turn, middle : PlayerHand){
        switch turn {
        case .swap(hand: let handCard, middle: let middleCard):
            replace(cardInHand: handCard, with: middleCard)
            middle.replace(cardInHand: middleCard, with: handCard)
        case .all:
            let tmp = self.hand
            self.hand = middle.hand
            middle.hand = self.hand
        }
    }
    
    
    private func createdScoredTurn(_ middle : PlayerHand, _ playerCard : PlayingCard,_ middleCard : PlayingCard) -> ScoredTurn {
        let possibleHand = PlayerHand(hand: self.hand)
        possibleHand.replace(cardInHand: playerCard, with: middleCard)
        
        let possibleMiddle = PlayerHand(hand: middle.hand)
        possibleMiddle.replace(cardInHand: middleCard, with: playerCard)
        
        return ScoredTurn(turn: .swap(hand: playerCard, middle: middleCard),
                          score: possibleHand.score, middleScore: possibleMiddle.score)
    }
    
    func generatePossibleTurns(middle : PlayerHand) -> [ScoredTurn] {
        var turns = [ScoredTurn]()
        hand.forEach{ playerCard in
            middle.hand.forEach{middleCard in
                turns.append(createdScoredTurn(middle, playerCard, middleCard))
            }
        }
        //Finally swap all 3
        turns.append(ScoredTurn(turn: .all, score: middle.score, middleScore: self.score))
        return turns
    }

}
