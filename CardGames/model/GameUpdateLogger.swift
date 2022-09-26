//
//  GameUpdateLogger.swift
//  CardGames
//
//  Created by Mark Bailey on 26/09/2022.
//

import Foundation

class GameUpdateLogger : GameUpdateListener {
    let model : Model
    init (model : Model){
        self.model = model
    }
    func update(gameState: GameState) {
        switch gameState {
        case .setUp:
            print("Setting up")
        case .selectDealer:
            print("Selecting the dealar")
        case .deal:
            print("Dealing")
        case .play:
            print("Playing")
        case .scoreRound:
            displayHands()
            print("End of Round")
        case .updateLives:
            print("Updating lives")
        case .gameOver:
            print("GAME OVER")
        }
    }
    
    func displayHands(){
        print("Middle: \t\(model.middle.display())")
        model.players.forEach{
            print("\($0.name): \t\($0.hand.display()) \tLives:\($0.lives)")
        }
    }
}
