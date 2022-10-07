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
            .generatePossibleTurns(middle: middle)
            .max(by: {$0.score < $1.score})!
            .turn
    }
}
