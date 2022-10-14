//
//  CardVM.swift
//  CardGames
//
//  Created by Mark Bailey on 14/10/2022.
//

import Foundation

class SelectableCardVM : ObservableObject {

    @Published var offset = 0
    let playingCard : PlayingCard

    init(playingCard : PlayingCard){
        self.playingCard = playingCard
    }
    
    func reset(){
        offset = 0
    }
    
}
