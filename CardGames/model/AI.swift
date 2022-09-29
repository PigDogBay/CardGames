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
