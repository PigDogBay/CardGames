//
//  OneDownAI.swift
//  CardGames
//
//  Created by Mark Bailey on 06/10/2022.
//

import Foundation
/*
class OneDownAI : AI {

    private func createdScoredTurn(_ middle : PlayerHand, _ playerCard : PlayingCard,_ middleCard : PlayingCard) -> ScoredTurn {
        let possibleHand = PlayerHand(hand: playerHand.hand)
        possibleHand.replace(cardInHand: playerCard, with: middleCard)
        
        let possibleMiddle = PlayerHand(hand: middle.hand)
        possibleMiddle.replace(cardInHand: middleCard, with: playerCard)
        
        return ScoredTurn(turn: .swap(hand: playerCard, middle: middleCard),
                          score: possibleHand.score, middleScore: possibleMiddle.score)
    }

    private func generatePossibleTurns(hand : PlayerHand, middleCards : PlayerHand) -> [ScoredTurn] {
        var turns = [ScoredTurn]()
        hand.hand.forEach{ playerCard in
            middleCards.hand.forEach{middleCard in
                turns.append(createdScoredTurn(middleCards, playerCard, middleCard))
            }
        }
        return turns
    }

    func play(player : Player, middle: PlayerHand) -> ScoredTurn {
        return HandGenerator(playerHand: player.hand)
            .generatePossibleTurns(middle: middle)
            .max(by: {$0.score < $1.score})!
    }
}
*/
