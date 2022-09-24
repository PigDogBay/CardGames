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
    let PrialOfKings = [PlayingCard(suit: .diamonds, rank: .king),
                PlayingCard(suit: .hearts, rank: .king),
                PlayingCard(suit: .spades, rank: .king)]
    let PrialOfThrees = [PlayingCard(suit: .clubs, rank: .three),
                PlayingCard(suit: .diamonds, rank: .three),
                PlayingCard(suit: .spades, rank: .three)]
    let StateExpress = [PlayingCard(suit: .clubs, rank: .five),
                PlayingCard(suit: .diamonds, rank: .five),
                PlayingCard(suit: .spades, rank: .five)]

    let JQKTrotter = [PlayingCard(suit: .spades, rank: .queen),
                PlayingCard(suit: .spades, rank: .jack),
                PlayingCard(suit: .spades, rank: .king)]
    let A23Trotter = [PlayingCard(suit: .diamonds, rank: .two),
                PlayingCard(suit: .diamonds, rank: .ace),
                PlayingCard(suit: .diamonds, rank: .three)]

    let JQKRun = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .jack),
                PlayingCard(suit: .diamonds, rank: .king)]
    let A23Run = [PlayingCard(suit: .clubs, rank: .two),
                PlayingCard(suit: .diamonds, rank: .three),
                PlayingCard(suit: .diamonds, rank: .ace)]
    let AKQRun = [PlayingCard(suit: .clubs, rank: .king),
                PlayingCard(suit: .diamonds, rank: .ace),
                PlayingCard(suit: .diamonds, rank: .queen)]
    let Weetabix456Run = [PlayingCard(suit: .clubs, rank: .two),
                PlayingCard(suit: .spades, rank: .three),
                PlayingCard(suit: .hearts, rank: .four)]
    let Beehive345Run = [PlayingCard(suit: .clubs, rank: .two),
                PlayingCard(suit: .spades, rank: .three),
                PlayingCard(suit: .hearts, rank: .four)]

    let AKJFlush = [PlayingCard(suit: .diamonds, rank: .ace),
                PlayingCard(suit: .diamonds, rank: .jack),
                PlayingCard(suit: .diamonds, rank: .king)]
    let KJTFlush = [PlayingCard(suit: .diamonds, rank: .ten),
                PlayingCard(suit: .diamonds, rank: .jack),
                PlayingCard(suit: .diamonds, rank: .king)]
    let KQTFlush = [PlayingCard(suit: .hearts, rank: .ten),
                PlayingCard(suit: .hearts, rank: .queen),
                PlayingCard(suit: .hearts, rank: .king)]
    let KJ9Flush = [PlayingCard(suit: .spades, rank: .nine),
                PlayingCard(suit: .spades, rank: .jack),
                PlayingCard(suit: .spades, rank: .king)]

    let QQKPair = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .spades, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .king)]
    let QQAPair = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .ace)]
    let AAQPair = [PlayingCard(suit: .clubs, rank: .ace),
                PlayingCard(suit: .diamonds, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .ace)]

    let KQ2High = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .diamonds, rank: .two),
                PlayingCard(suit: .diamonds, rank: .king)]
    let KQ3High = [PlayingCard(suit: .clubs, rank: .queen),
                PlayingCard(suit: .hearts, rank: .three),
                PlayingCard(suit: .diamonds, rank: .king)]
    let A42High = [PlayingCard(suit: .clubs, rank: .two),
                PlayingCard(suit: .diamonds, rank: .ace),
                PlayingCard(suit: .diamonds, rank: .four)]
    
    func testScoringPrial1(){
        XCTAssertGreaterThan(
            HandResolver(hand: PrialOfThrees).createScore(),
            HandResolver(hand: PrialOfAces).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: PrialOfAces).createScore(),
            HandResolver(hand: PrialOfKings).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: PrialOfKings).createScore(),
            HandResolver(hand: StateExpress).createScore())
    }


    func testScoringTrotter1(){
        XCTAssertGreaterThan(
            HandResolver(hand: A23Trotter).createScore(),
            HandResolver(hand: JQKTrotter).createScore())
    }

    func testScoringRun1(){
        XCTAssertGreaterThan(
            HandResolver(hand: A23Run).createScore(),
            HandResolver(hand: AKQRun).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: AKQRun).createScore(),
            HandResolver(hand: JQKRun).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: Weetabix456Run).createScore(),
            HandResolver(hand: Beehive345Run).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: JQKRun).createScore(),
            HandResolver(hand: Beehive345Run).createScore())
    }

    func testScoringFlush1(){
        XCTAssertGreaterThan(
            HandResolver(hand: AKJFlush).createScore(),
            HandResolver(hand: KJTFlush).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: KQTFlush).createScore(),
            HandResolver(hand: KJTFlush).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: KJTFlush).createScore(),
            HandResolver(hand: KJ9Flush).createScore())
    }

    func testScoringPair1(){
        XCTAssertGreaterThan(
            HandResolver(hand: AAQPair).createScore(),
            HandResolver(hand: QQAPair).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: QQAPair).createScore(),
            HandResolver(hand: QQKPair).createScore())
    }
    
    func testScoringHigh1() {
        XCTAssertGreaterThan(
            HandResolver(hand: A42High).createScore(),
            HandResolver(hand: KQ3High).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: KQ3High).createScore(),
            HandResolver(hand: KQ2High).createScore())
    }
    
    func testScoringHandTypes1() {
        XCTAssertGreaterThan(
            HandResolver(hand: PrialOfAces).createScore(),
            HandResolver(hand: JQKTrotter).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: JQKTrotter).createScore(),
            HandResolver(hand: JQKRun).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: A23Run).createScore(),
            HandResolver(hand: KJTFlush).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: KJTFlush).createScore(),
            HandResolver(hand: QQKPair).createScore())
        XCTAssertGreaterThan(
            HandResolver(hand: QQKPair).createScore(),
            HandResolver(hand: KQ2High).createScore())
    }

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
        let resolver = HandResolver(hand: JQKRun)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .run)
    }
    
    func testRun2() throws {
        let resolver = HandResolver(hand: A23Run)
        let score = resolver.createScore()
        XCTAssertEqual(score.type, .run)
    }
    
    func testRun3() throws {
        let resolver = HandResolver(hand: AKQRun)
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
