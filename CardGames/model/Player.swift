//
//  Player.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import Foundation



class Player : Equatable {
    let name : String
    let hand = PlayerHand()
    var lives = 3
    var score = BragHandScore(type: .high, score: 0)
    var seat = 0
    
    init(name : String){
        self.name = name
    }
    
    func play(middle : PlayerHand){
        //Swap First cards
        let myCard = hand.hand.removeFirst()
        let middleCard = middle.hand.removeFirst()
        hand.receive(card: middleCard)
        middle.receive(card: myCard)
    }
    
    func resolveHand(){
        score = hand.score
    }
    
    ///Equatable, each player must have an unique seat
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.seat == rhs.seat
    }
}

let PLAYER_BOMBER = Player(name: "Bomber")
let PLAYER_HOWE = Player(name: "Howe")
let PLAYER_CHRIS = Player(name: "Chris")
let PLAYER_LEON = Player(name: "Leon")
let PLAYER_MARK = Player(name: "Mark")
