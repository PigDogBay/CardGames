//
//  Defines.swift
//  CardGames
//
//  Created by Mark Bailey on 05/10/2022.
//

import Foundation

enum CardErrors : Error {
    case CardAlreadyInThePack(card : PlayingCard)
}

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
