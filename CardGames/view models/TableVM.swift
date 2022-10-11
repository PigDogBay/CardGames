//
//  TableVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation

class TableVM : ObservableObject {
    let player1VM = PlayerVM(name: "Howie")
    let player2VM = PlayerVM(name: "Bomber")
    let middleVM = HandVM()
    
    @Published var status : String = "Welcome!"

    func action(){
    }
}
