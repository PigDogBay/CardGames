//
//  PlayerVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation

class PlayerVM : ObservableObject {
    let player : Player
    let handVM = HandVM()
    @Published var lives = 3
    @Published var isDealer = false
    @Published var isPlayingTurn = false

    init(player : Player){
        self.player = player
    }
    
    func updateHand(){
        handVM.update(hand: player.hand)
    }
    
    func updateLives(){
        lives = player.lives
    }
}
