//
//  AI.swift
//  CardGames
//
//  Created by Mark Bailey on 29/09/2022.
//

import Foundation

protocol AI {
    func play(player : Player, middle : PlayerHand) -> ScoredTurn
}

class RandomAI : AI{
    func play(player : Player, middle: PlayerHand) -> ScoredTurn {
        return player
            .hand
            .generatePossibleTurns(middle: middle)
            .randomElement()!
    }
}

class BestAI : AI {
    func play(player : Player, middle: PlayerHand) -> ScoredTurn {
        return player
            .hand
            .generatePossibleTurns(middle: middle)
            .max(by: {$0.score < $1.score})!
    }
}

class PrialChuckerAI : AI {
    private let school : School
    private let bestAI = BestAI()
    private let lowHand = [PlayingCard(suit: .clubs, rank: .two),
                           PlayingCard(suit: .diamonds, rank: .jack),
                           PlayingCard(suit: .hearts, rank: .jack)]

    private let lowestScoreToConsiderPrial : Int
    
    init(school : School){
        self.school = school
        lowestScoreToConsiderPrial = PlayerHand(hand: lowHand).score.score
    }
    
    func play(player : Player, middle: PlayerHand) -> ScoredTurn {
        let best = bestAI.play(player: player, middle: middle)
        let prialInMiddle = player.hand
            .generatePossibleTurns(middle: middle)
            .filter{$0.middleScore.type == .prial}
            .first
        if let prialInMiddle = prialInMiddle {
            if school.players.count>2 && best.score.score < lowestScoreToConsiderPrial {
                return prialInMiddle
            }
        }
        return best
    }

}

class CheckMiddleAI : AI {
    let bestAI = BestAI()
    func play(player : Player, middle: PlayerHand) -> ScoredTurn {
        let worseMiddle = player
            .hand
            .generatePossibleTurns(middle: middle)
            .filter{$0.score > $0.middleScore}
        if !worseMiddle.isEmpty {
            return worseMiddle
                .max(by: {$0.score < $1.score})!
        }
        return bestAI.play(player: player, middle: middle)
    }
}
