//
//  PlayerHandTests.swift
//  CardGamesTests
//
//  Created by Mark Bailey on 29/09/2022.
//

import XCTest
@testable import CardGames

final class PlayerHandTests: XCTestCase {
    
    func testShowHide1() throws {
        let playerHand = PlayerHand(hand: QQKPair)
        playerHand.show()
        XCTAssertFalse(playerHand.hand[0].isDown)
        XCTAssertFalse(playerHand.hand[1].isDown)
        XCTAssertFalse(playerHand.hand[2].isDown)
        playerHand.hide()
        XCTAssertTrue(playerHand.hand[0].isDown)
        XCTAssertTrue(playerHand.hand[1].isDown)
        XCTAssertTrue(playerHand.hand[2].isDown)
    }
    
    ///Check that all 3 is a possibility
    func testGeneratePossibleTurns1() throws {
        let playerHand = PlayerHand(hand: QQKPair)
        let middle = PlayerHand(hand: KQTFlush)
        let scoredTurns = playerHand.generatePossibleTurns(middle: middle)
        XCTAssertEqual(scoredTurns.count, 10)
        let count = scoredTurns.filter{$0.turn == Turn.all}.count
        XCTAssertEqual(count, 1)
        let score = scoredTurns.filter{$0.turn == Turn.all}.first?.score
        XCTAssertEqual(score, middle.score)
        let middleScore = scoredTurns.filter{$0.turn == Turn.all}.first?.middleScore
        XCTAssertEqual(middleScore, playerHand.score)
    }

    ///Check that the prial has been found
    func testGeneratePossibleTurns2() throws {
        let playerHand = PlayerHand(hand: QQKPair)
        let middle = PlayerHand(hand: KQTFlush)
        let scoredTurns = playerHand.generatePossibleTurns(middle: middle)
        let count = scoredTurns.filter{$0.turn == Turn.swap(hand: playerHand.hand[2], middle: middle.hand[1])}.count
        XCTAssertEqual(count, 1)
        let score = scoredTurns.filter{$0.turn == Turn.swap(hand: playerHand.hand[2], middle: middle.hand[1])}.first?.score
        XCTAssertEqual(score?.type, .prial)
        let middleScore = scoredTurns.filter{$0.turn == Turn.swap(hand: playerHand.hand[2], middle: middle.hand[1])}.first?.middleScore
        XCTAssertEqual(middleScore?.type, .pair)
    }
}
