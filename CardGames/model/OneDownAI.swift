//
//  OneDownAI.swift
//  CardGames
//
//  Created by Mark Bailey on 06/10/2022.
//

import Foundation
class OneDownAI : AI {
    weak var player: Player?

    func play(middle: PlayerHand) -> Turn {
        return HandGenerator(playerHand: player!.hand)
            .generatePossibleTurnsFaceUpOnly(middle: middle)
            .max(by: {$0.score < $1.score})!
            .turn
    }
}

class ChancerAI : AI {
    weak var player: Player?

    func play(middle: PlayerHand) -> Turn {
       let turn = HandGenerator(playerHand: player!.hand)
            .generatePossibleTurnsFaceUpOnly(middle: middle)
            .max(by: {$0.score < $1.score})!
            .turn
        
        return turn
    }
}
