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
    
    init(){
        card1 = PlayingCard(suit: .clubs, rank: .ten, isDown: false)
        card2 = PlayingCard(suit: .diamonds, rank: .eight, isDown: false)
        card3 = PlayingCard(suit: .hearts, rank: .eight, isDown: false)
    }
}
