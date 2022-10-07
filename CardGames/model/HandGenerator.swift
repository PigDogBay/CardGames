//
//  HandGenerator.swift
//  CardGames
//
//  Created by Mark Bailey on 06/10/2022.
//

import Foundation

struct HandGenerator {
    let playerHand : PlayerHand

    private func createdScoredTurn(_ middle : PlayerHand, _ playerCard : PlayingCard,_ middleCard : PlayingCard) -> ScoredTurn {
        let possibleHand = PlayerHand(hand: playerHand.hand)
        possibleHand.replace(cardInHand: playerCard, with: middleCard)
        
        let possibleMiddle = PlayerHand(hand: middle.hand)
        possibleMiddle.replace(cardInHand: middleCard, with: playerCard)
        
        return ScoredTurn(turn: .swap(hand: playerCard, middle: middleCard),
                          score: possibleHand.score, middleScore: possibleMiddle.score)
    }
    
    func generatePossibleTurns(middle : PlayerHand) -> [ScoredTurn] {
        var turns = [ScoredTurn]()
        playerHand.hand.forEach{ playerCard in
            middle.hand.forEach{middleCard in
                turns.append(createdScoredTurn(middle, playerCard, middleCard))
            }
        }
        //Finally swap all 3
        turns.append(ScoredTurn(turn: .all, score: middle.score, middleScore: playerHand.score))
        return turns
    }
    
    ///Hand generator for the 1 down in middle variation
    ///This will not consider the unknown card in the middle that is facedown
    func generatePossibleTurnsFaceUpOnly(middle : PlayerHand) -> [ScoredTurn] {
        var turns = [ScoredTurn]()
        playerHand.hand.forEach{ playerCard in
            middle.hand
            .filter{!$0.isDown}
            .forEach{ middleCard in
                //No peeping at middle score!
                turns.append(createdScoredTurn(middle, playerCard, middleCard))
            }
        }
        return turns
    }
}
