//
//  AI.swift
//  CardGames
//
//  Created by Mark Bailey on 29/09/2022.
//

import Foundation

protocol AI : AnyObject {
    var player : Player? { get set }
    func play(middle : PlayerHand) -> ScoredTurn
}

class RandomAI : AI{
    weak var player: Player?
    
    func play(middle: PlayerHand) -> ScoredTurn {
        return HandGenerator(playerHand: player!.hand)
            .generatePossibleTurns(middle: middle)
            .randomElement()!
    }
}

class BestAI : AI {
    weak var player: Player?

    func play(middle: PlayerHand) -> ScoredTurn {
        return HandGenerator(playerHand: player!.hand)
            .generatePossibleTurns(middle: middle)
            .max(by: {$0.score < $1.score})!
    }
}

class PrialChuckerAI : AI {
    weak var player: Player?{
        didSet {
            self.bestAI.player = player
        }
    }
    private let school : School
    private let bestAI : AI
    private let lowHand = [PlayingCard(suit: .clubs, rank: .two),
                           PlayingCard(suit: .diamonds, rank: .eight),
                           PlayingCard(suit: .hearts, rank: .eight)]

    private let lowestScoreToConsiderPrial : Int

    init(school : School){
        self.school = school
        self.bestAI = BestAI()
        lowestScoreToConsiderPrial = PlayerHand(hand: lowHand).score.score
    }
    
    func play(middle: PlayerHand) -> ScoredTurn {
        let best = bestAI.play(middle: middle)
        let prialInMiddle = HandGenerator(playerHand: player!.hand)
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

