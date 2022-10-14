//
//  TableVM.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import Foundation
import Combine

class TableVM : ObservableObject, GameListener {
    let players : [PlayerVM]
    let middleVM = HandVM()
    let model = Model()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var status : String = "Welcome!"
    
    private var canUpdateGame = true
    private var isHumanPlayersGo = false
    private var disposables = Set<AnyCancellable>()

    init(){
        model.setUpGame()
        players = model.school.players
            .map{PlayerVM(player: $0)}
        
        //Listener for player selections
        Publishers
            .MergeMany(players[0].handVM.card1VM.$isSelected,
                       players[0].handVM.card2VM.$isSelected,
                       players[0].handVM.card3VM.$isSelected,
                       middleVM.card1VM.$isSelected,
                       middleVM.card2VM.$isSelected,
                       middleVM.card3VM.$isSelected)
            .eraseToAnyPublisher()
            .dropFirst(6)
            .filter{_ in self.isHumanPlayersGo == true}
            .delay(for: 0.5, scheduler: DispatchQueue.main)  //willSet event, need to wait for var to be set
            .sink(receiveValue: {_ in self.playerMadeAMove()})
            .store(in: &disposables)
        
        model.gameListener = self
        //Move cards down when selected
        middleVM.setSelectionOffset(offsetAmount: 30)
    }
    
    private func playerMadeAMove(){
        if (middleVM.selectedCount == 1 && players[0].handVM.selectedCount == 1){
            let turn = Turn.swap(hand: players[0].handVM.selectedCard!, middle: middleVM.selectedCard!)
            model.school.humanAI.turn = turn
            isHumanPlayersGo = false
            canUpdateGame = true
            middleVM.unselectCards()
            players[0].handVM.unselectCards()
        } else if (middleVM.selectedCount == 3 || players[0].handVM.selectedCount == 3){
            model.school.humanAI.turn = Turn.all()
            isHumanPlayersGo = false
            canUpdateGame = true
            middleVM.unselectCards()
            players[0].handVM.unselectCards()
        }
    }
    
    private func updateHands(){
        middleVM.update(hand: model.middle)
        players.forEach{
            $0.updateHand()
        }
    }
    
    func autoUpdate(){
        if canUpdateGame {
            model.updateState()
        }
    }
    
    func action(){
        //Human player has taken turn
        canUpdateGame = true
    }
    
    func dealerSelected(dealer: Player) {
        status = "Dealer is \(dealer.name)"
        players.forEach{
            $0.isDealer = dealer == $0.player
        }
        updateHands()
    }
    
    func dealingDone() {
        status = "Dealing Done"
        updateHands()
    }

    func turnStarted(player: Player, middle: PlayerHand) {
        players.forEach{
            $0.isPlayingTurn = player == $0.player
        }
        status = "\(player.name) to play: \(player.hand.display())"
        if player.seat == 0 {
            isHumanPlayersGo = true
            //Human player wait for input
            canUpdateGame = false
            model.school.humanAI.turn = Turn.all()
        }
    }
    
    func turnEnded(player: Player, middle: PlayerHand, turn: Turn) {
        status = "\(player.name) \(turn.display())"
        updateHands()
    }
    
    func showHands(players: [Player]) {
        self.players.forEach{
            $0.isPlayingTurn = false
        }
        status = "Show Hands"
        updateHands()
    }
    
    func roundEnded(losingPlayers: [Player]) {
        let losers = losingPlayers.map{$0.name}
            .joined(separator: ", ")
        status = "\(losers) loses a life"
        players.forEach{
            $0.updateLives()
        }
        canUpdateGame = false
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
