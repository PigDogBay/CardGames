//
//  HandVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation

class HandVM : ObservableObject {
    @Published var card1 : PlayingCard? = nil
    @Published var card2 : PlayingCard? = nil
    @Published var card3 : PlayingCard? = nil
    @Published var isCardOneSelected = false
    @Published var isCardTwoSelected = false
    @Published var isCardThreeSelected = false

    init(){
//        card1 = PlayingCard(suit: .clubs, rank: .ten, isDown: false)
//        card2 = PlayingCard(suit: .diamonds, rank: .eight, isDown: false)
//        card3 = PlayingCard(suit: .hearts, rank: .eight, isDown: false)
    }
    
    func update(hand : PlayerHand){
        if (hand.hand.count == 3){
            card1 = hand.hand[0]
            card2 = hand.hand[1]
            card3 = hand.hand[2]
        } else {
            card1 = nil
            card2 = nil
            card3 = nil
        }
            
    }
}
