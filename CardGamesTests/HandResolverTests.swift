//
//  HandResolverTests.swift
//  CardGamesTests
//
//  Created by Mark Bailey on 11/09/2022.
//

import XCTest
@testable import CardGames

class HandResolverTests: XCTestCase {
    let PrialOfAces = [PlayingCard(suit: .clubs, rank: .ace),
                PlayingCard(suit: .hearts, rank: .ace),
                PlayingCard(suit: .spades, rank: .ace)]

    let JQKTrotter = [PlayingCard(suit: .diamonds, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .jack),
                PlayingCard(suit: .diamonds, rank: .king)]
    
    let JQK = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .jack),
                PlayingCard(suit: .diamonds, rank: .king)]

    let A23 = [PlayingCard(suit: .clubs, rank: .two),
                PlayingCard(suit: .diamonds, rank: .three),
                PlayingCard(suit: .diamonds, rank: .ace)]

    let AKQ = [PlayingCard(suit: .clubs, rank: .king),
                PlayingCard(suit: .diamonds, rank: .ace),
                PlayingCard(suit: .diamonds, rank: .queen)]

    let KJTFlush = [PlayingCard(suit: .diamonds, rank: .ten),
                PlayingCard(suit: .diamonds, rank: .jack),
                PlayingCard(suit: .diamonds, rank: .king)]

    let QQKPair = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .king)]
    
    let KQ2High = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .two),
                PlayingCard(suit: .diamonds, rank: .king)]


    func testPrial1() throws {
        let resolver = HandResolver(hand: PrialOfAces)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .prial)
    }

    func testTrotter1() throws {
        let resolver = HandResolver(hand: JQKTrotter)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .trotter)
    }

    func testRun1() throws {
        let resolver = HandResolver(hand: JQK)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .run)
    }
    
    func testRun2() throws {
        let resolver = HandResolver(hand: A23)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .run)
    }
    
    func testRun3() throws {
        let resolver = HandResolver(hand: AKQ)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .run)
    }

    func testFlush1() throws {
        let resolver = HandResolver(hand: KJTFlush)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .flush)
    }
    
    func testPair1() throws {
        let resolver = HandResolver(hand: QQKPair)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .pair)
    }
    
    func testHigh1() throws {
        let resolver = HandResolver(hand: KQ2High)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .high)
    }


}
