//
//  GameUpdateLogger.swift
//  CardGames
//
//  Created by Mark Bailey on 26/09/2022.
//

import Foundation

class GameUpdateLogger : GameListener {

    func dealerSelected(dealer: Player) {
        print("\n\(dealer.name) is Dealing")
    }
    
    func turnStarted(player: Player, middle: PlayerHand) {
        print("Turn: \(player.name)(\(player.lives)): \t\(player.hand.display()).    Middle: \(middle.display())")
    }
    
    func turnEnded(player: Player, middle: PlayerHand) {
        print("TEnd: \(player.name)(\(player.lives)): \t\(player.hand.display()).    Middle: \(middle.display())")
    }
    
    func roundEnded(losingPlayers: [Player]) {
        print("End of Round, losing players: \(concatenatePlayerNames(players: losingPlayers))")
    }
    
    func pullThePeg(outPlayers: [Player]) {
        if !outPlayers.isEmpty {
            print("Pull the peg!: \(concatenatePlayerNames(players: outPlayers))")
        }
    }
    
    func everyoneOutSoReplayRound() {
        print("There can only be one! Have another round")
    }
    
    func gameOver(winner: Player) {
        print("Winner is \(winner.name) with \(winner.lives) lives remaining")
    }
    
    func concatenatePlayerNames(players : [Player]) -> String {
        return players.reduce(""){ acc, next in
            acc + next.name + ", "
        }
    }
}
