//
//  TableVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation

class TableVM : ObservableObject, GameListener {
    let player1VM : PlayerVM
    let player2VM : PlayerVM
    let middleVM = HandVM()
    let model = Model()
    
    @Published var status : String = "Welcome!"
    
    init(){
        model.setUpGame()
        player1VM = PlayerVM(player: model.school.players[0])
        player2VM = PlayerVM(player: model.school.players[1])
        model.gameListener = self
    }
    
    private func updateHands(){
        middleVM.update(hand: model.middle)
        player1VM.updateHand()
        player2VM.updateHand()
    }
    
    func action(){
        model.updateState()
    }
    
    func dealerSelected(dealer: Player) {
        status = "Dealer is \(dealer.name)"
        updateHands()
    }
    func dealingDone() {
        status = "Dealing Done"
        updateHands()
    }

    func turnStarted(player: Player, middle: PlayerHand) {
        status = "\(player.name) to play: \(player.hand.display())"
    }
    
    func turnEnded(player: Player, middle: PlayerHand, turn: Turn) {
        status = "\(player.name) \(turn.display())"
        updateHands()
    }
    
    func showHands(players: [Player]) {
        status = "Show Hands"
        updateHands()
    }
    
    func roundEnded(losingPlayers: [Player]) {
        let losers = losingPlayers.map{$0.name}
            .joined(separator: ", ")
        status = "\(losers) loses a life"
        player1VM.updateLives()
        player2VM.updateLives()
                    
    }
    
    func pullThePeg(outPlayers: [Player]) {
        if outPlayers.count == 0 {
            status = "No players out"
        } else if outPlayers.count == 1 {
            status = "\(outPlayers[0].name) is out"
        } else {
            let losers = outPlayers.map{$0.name}
                .joined(separator: ", ")
            status = "\(losers) are all out"
        }
    }
    
    func everyoneOutSoReplayRound() {
        status = "Everyone out, replay!"
    }
    
    func gameOver(winner: Player) {
        status = "\(winner.name) is the Winner!"
    }
}
