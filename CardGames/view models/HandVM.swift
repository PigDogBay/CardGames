//
//  HandVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation

class HandVM : ObservableObject {
    let card1VM = SelectableCardVM()
    let card2VM = SelectableCardVM()
    let card3VM = SelectableCardVM()

    func update(hand : PlayerHand){
        if (hand.hand.count == 3){
            card1VM.card = hand.hand[0]
            card2VM.card = hand.hand[1]
            card3VM.card = hand.hand[2]
        } else {
            card1VM.card = nil
            card2VM.card = nil
            card3VM.card = nil
        }
    }
    
    func unselectCards(){
        card1VM.isSelected = false
        card2VM.isSelected = false
        card3VM.isSelected = false
    }
    
    var selectedCount : Int  {
        var count = 0
        if card1VM.isSelected {
            count += 1
        }
        if card2VM.isSelected {
            count += 1
        }
        if card3VM.isSelected {
            count += 1
        }
        return count
    }
}
