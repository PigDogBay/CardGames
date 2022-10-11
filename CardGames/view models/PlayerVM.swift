//
//  PlayerVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation

class PlayerVM : ObservableObject {
    let name : String
    let handVM = HandVM()
    @Published var lives = 3

    init(name : String){
        self.name = name
    }
}
