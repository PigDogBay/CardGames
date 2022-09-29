//
//  AI.swift
//  CardGames
//
//  Created by Mark Bailey on 29/09/2022.
//

import Foundation

protocol AI {
    func play(player : Player, middle : PlayerHand) -> Turn
}

class RandomAI : AI{
    func play(player : Player, middle: PlayerHand) -> Turn {
        return player
            .hand
            .generatePossibleTurns(middle: middle)
            .map{$0.turn}
            .randomElement()!
    }
}

class BestAI : AI {
    func play(player : Player, middle: PlayerHand) -> Turn {
        return player
            .hand
            .generatePossibleTurns(middle: middle)
            .max(by: {$0.score < $1.score})!
            .turn
    }
}

class PrialChuckerAI : AI {
    
    let bestAI = BestAI()
    
    func play(player : Player, middle: PlayerHand) -> Turn {
        let prialInMiddle = player.hand
            .generatePossibleTurns(middle: middle)
            .filter{$0.middleScore.type == .prial}
            .first
        if let prialInMiddle = prialInMiddle {
            print("Heehee chucking a prial in")
            return prialInMiddle.turn
        }
        return bestAI.play(player: player, middle: middle)
    }

}

class CheckMiddleAI : AI {
    let bestAI = BestAI()
    func play(player : Player, middle: PlayerHand) -> Turn {
        let worseMiddle = player
            .hand
            .generatePossibleTurns(middle: middle)
            .filter{$0.score > $0.middleScore}
        if !worseMiddle.isEmpty {
            return worseMiddle
                .max(by: {$0.score < $1.score})!
                .turn
        }
        return bestAI.play(player: player, middle: middle)
    }
}
