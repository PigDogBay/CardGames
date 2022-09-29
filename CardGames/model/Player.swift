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
    let ai : AI
    
    init(name : String, ai : AI){
        self.name = name
        self.ai = ai
    }
    
    func play(middle : PlayerHand) -> Turn{
        let turn = ai.play(player: self, middle: middle)
        hand.play(turn: turn, middle: middle)
        return turn
    }
    
    func resolveHand(){
        score = hand.score
    }
    
    ///Equatable, each player must have an unique seat
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.seat == rhs.seat
    }
}

let PLAYER_BOMBER = Player(name: "Bomber", ai: BestAI())
let PLAYER_HOWE = Player(name: "Howe", ai: BestAI())
let PLAYER_CHRIS = Player(name: "Chris", ai: BestAI())
let PLAYER_LEON = Player(name: "Leon", ai: BestAI())
let PLAYER_MARK = Player(name: "Mark", ai: BestAI())
