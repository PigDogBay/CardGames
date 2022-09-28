//
//  SchoolTests.swift
//  CardGamesTests
//
//  Created by Mark Bailey on 26/09/2022.
//

import XCTest
@testable import CardGames

final class SchoolTests: XCTestCase {

    func testDetermineLosingHands1() throws {
        let school = School()
        school.setUpPlayers()
        PLAYER_HOWE.hand.hand = A23Trotter
        PLAYER_BOMBER.hand.hand = AKQRun
        PLAYER_LEON.hand.hand = AKJFlush
        PLAYER_CHRIS.hand.hand = QQKPair
        school.resolveHands()
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 1)
        XCTAssertEqual(losers?.first?.name, PLAYER_CHRIS.name)
        XCTAssertFalse(school.isPrialOut())
        XCTAssertEqual(school.highestScoringPlayer()?.name, PLAYER_HOWE.name)
    }
    
    func testDetermineLosingHands2() throws {
        let school = School()
        school.setUpPlayers()
        PLAYER_HOWE.hand.hand = AKQRun
        PLAYER_BOMBER.hand.hand = A23Trotter
        PLAYER_LEON.hand.hand = AKJFlush
        PLAYER_CHRIS.hand.hand = AKJFlush
        school.resolveHands()
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 2)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_CHRIS.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_LEON.name}) ?? false)
        XCTAssertFalse(school.isPrialOut())
        XCTAssertEqual(school.highestScoringPlayer()?.name, PLAYER_BOMBER.name)
    }

    //Prial out, everyone off
    func testDetermineLosingHands3() throws {
        let school = School()
        school.setUpPlayers()
        PLAYER_HOWE.hand.hand = A23Trotter
        PLAYER_BOMBER.hand.hand = AKQRun
        PLAYER_LEON.hand.hand = AKJFlush
        PLAYER_CHRIS.hand.hand = PrialOfAces
        school.resolveHands()
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 3)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_HOWE.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_LEON.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_BOMBER.name}) ?? false)
        XCTAssertTrue(school.isPrialOut())
        XCTAssertEqual(school.highestScoringPlayer()?.name, PLAYER_CHRIS.name)
    }
    
    func testareAllPlayersOut1() throws {
        let school = School()
        school.setUpPlayers()
        school.players.forEach{$0.lives = 0}
        XCTAssertTrue(school.areAllPlayersOut())
    }

}
