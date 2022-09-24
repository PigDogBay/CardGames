//
//  HandResolver.swift
//  CardGames
//
//  Created by Mark Bailey on 10/09/2022.
//

import Foundation

enum BragHandTypes : Int32 {
    case high, pair, flush, run, trotter, prial
}

struct BragHandScore {
    let type : BragHandTypes
    let score : Int
}

struct HandResolver {
    let hand : [PlayingCard]
    let scoreSortedHand : [PlayingCard]
    
    var highestCard : PlayingCard {
        scoreSortedHand[2]
    }

    init(hand : [PlayingCard]){
        self.hand = hand.sorted{$0.rank.rawValue < $1.rank.rawValue}
        self.scoreSortedHand = hand.sorted{$0.rank.score() < $1.rank.score()}
    }
    
    func createScore() -> BragHandScore{
        let type = resolveHandType()
        let score = calculateScore(type: type)
        return BragHandScore(type: type, score: score)
    }
    
    private var isPrial : Bool {
        return hand[0].rank==hand[1].rank && hand[1].rank==hand[2].rank
    }
    private var isFlush : Bool {
        return hand[0].suit == hand[1].suit && hand[1].suit == hand[2].suit
    }
    private var isRun : Bool {
        //Check for QKA
        if hand[0].rank == .ace && hand[1].rank == .queen && hand[2].rank == .king {
            return true
        }

        let rank1 = hand[0].rank.rawValue + 2
        let rank2 = hand[1].rank.rawValue + 1
        let rank3 = hand[2].rank.rawValue
        return  rank1 == rank2 && rank2 == rank3
    }
    private var isPair : Bool {
        return hand[0].rank==hand[1].rank || hand[1].rank==hand[2].rank || hand[0].rank==hand[2].rank
    }

    private func resolveHandType() -> BragHandTypes {
        if isPrial {
            return .prial
        }
        if isRun && isFlush {
            return .trotter
        }
        if isRun {
            return .run
        }
        if isFlush {
            return .flush
        }
        if isPair {
            return .pair
        }
        return .high
    }
    
    private func scorePrial() -> Int {
        return 0x05000000 + highestCard.rank.score()
    }
    private func scoreTrotter() -> Int {
        return 0x04000000
    }
    private func scoreRun() -> Int {
        return 0x03000000
    }
    private func scoreFlush() -> Int {
        return 0x02000000
    }
    private func scorePair() -> Int {
        return 0x01000000
    }
    private func scoreHigh() -> Int {
        return scoreSortedHand[0].rank.score()  +
        scoreSortedHand[1].rank.score()<<8 +
        scoreSortedHand[2].rank.score()<<16
    }

    private func calculateScore(type : BragHandTypes) -> Int {
        switch type {
        case .high:
            return scoreHigh()
        case .pair:
            return scorePair()
        case .flush:
            return scoreFlush()
        case .run:
            return scoreRun()
        case .trotter:
            return scoreTrotter()
        case .prial:
            return scorePrial()
        }
    }
}
