//
//  DeckTests.swift
//  CardGamesTests
//
//  Created by Mark Bailey on 05/10/2022.
//

import XCTest
@testable import CardGames

class DeckTests: XCTestCase {
    
    func testCreateDeck1() throws {
        let deck = Deck()
        deck.createDeck()
        XCTAssertEqual(deck.count, 52)
    }
    
    func testDeal1() throws {
        let deck = Deck()
        deck.createDeck()
        let card = deck.deal()
        XCTAssertEqual(deck.count, 51)
        XCTAssertTrue(card.isDown)
    }
    
    func testDeal2() throws {
        let deck = Deck()
        deck.createDeck()
        deck.shuffle()
        let card = deck.deal(dealUp: true)
        XCTAssertTrue(!card.isDown)
    }

    func testReceive1() throws {
        let deck = Deck()
        deck.createDeck()
        let card = deck.deal()
        deck.receive(cards: [card])
        XCTAssertEqual(deck.count, 52)
    }

}
