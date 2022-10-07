//
//  GameVariation.swift
//  CardGames
//
//  Created by Mark Bailey on 07/10/2022.
//

import Foundation

protocol GameVariation : AnyObject {
    func arrangeMiddle(middle : PlayerHand, turn : Turn)
    func isMiddleCardFaceUp(dealIndex : Int) -> Bool
}

class VariationAllUp : GameVariation {
    func arrangeMiddle(middle : PlayerHand, turn : Turn) {
        //Easy for all up, just make sure they are all shown
        middle.show()
    }
    func isMiddleCardFaceUp(dealIndex : Int) -> Bool {
        //all cards up
        return true
    }
}
