//
//  CardVM.swift
//  CardGames
//
//  Created by Mark Bailey on 14/10/2022.
//

import Foundation

class SelectableCardVM : ObservableObject {

    @Published var offset = 0
    @Published var card : PlayingCard? = nil
    @Published var isSelected = false
    
    func reset(){
        offset = 0
    }
}
