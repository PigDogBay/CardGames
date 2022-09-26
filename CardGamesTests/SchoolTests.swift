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
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 1)
        XCTAssertEqual(losers?.first?.name, PLAYER_CHRIS.name)
    }
    
    func testDetermineLosingHands2() throws {
        let school = School()
        school.setUpPlayers()
        PLAYER_HOWE.hand.hand = A23Trotter
        PLAYER_BOMBER.hand.hand = AKQRun
        PLAYER_LEON.hand.hand = AKJFlush
        PLAYER_CHRIS.hand.hand = AKJFlush
        let losers = school.determineLosingHands()
        XCTAssertEqual(losers?.count, 2)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_CHRIS.name}) ?? false)
        XCTAssertTrue(losers?.contains(where: {$0.name == PLAYER_LEON.name}) ?? false)
    }


}
