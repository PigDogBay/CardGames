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
        school.playerHowe.hand.hand = A23Trotter
        school.playerBomber.hand.hand = AKQRun
        school.playerLeon.hand.hand = AKJFlush
        school.playerChris.hand.hand = QQKPair
        school.resolveHands()
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 1)
        XCTAssertEqual(losers?.first?.name, school.playerChris.name)
        XCTAssertFalse(school.isPrialOut())
        XCTAssertEqual(school.highestScoringPlayer()?.name, school.playerHowe.name)
    }
    
    func testDetermineLosingHands2() throws {
        let school = School()
        school.setUpPlayers()
        school.playerHowe.hand.hand = AKQRun
        school.playerBomber.hand.hand = A23Trotter
        school.playerLeon.hand.hand = AKJFlush
        school.playerChris.hand.hand = AKJFlush
        school.resolveHands()
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 2)
        XCTAssertTrue(losers?.contains(where: {$0.name == school.playerChris.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == school.playerLeon.name}) ?? false)
        XCTAssertFalse(school.isPrialOut())
        XCTAssertEqual(school.highestScoringPlayer()?.name, school.playerBomber.name)
    }

    //Prial out, everyone off
    func testDetermineLosingHands3() throws {
        let school = School()
        school.setUpPlayers()
        school.playerHowe.hand.hand = A23Trotter
        school.playerBomber.hand.hand = AKQRun
        school.playerLeon.hand.hand = AKJFlush
        school.playerChris.hand.hand = PrialOfAces
        school.resolveHands()
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 3)
        XCTAssertTrue(losers?.contains(where: {$0.name == school.playerHowe.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == school.playerLeon.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == school.playerBomber.name}) ?? false)
        XCTAssertTrue(school.isPrialOut())
        XCTAssertEqual(school.highestScoringPlayer()?.name, school.playerChris.name)
    }
    
    func testareAllPlayersOut1() throws {
        let school = School()
        school.setUpPlayers()
        school.players.forEach{$0.lives = 0}
        XCTAssertTrue(school.areAllPlayersOut())
    }
}
