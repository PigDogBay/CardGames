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
