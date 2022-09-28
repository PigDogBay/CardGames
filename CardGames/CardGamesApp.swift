//
//  CardGamesApp.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import SwiftUI

@main
struct CardGamesApp: App {
    
    func startGame(){
        let model = Model()
        let listener = GameUpdateLogger()
        model.gameListener = listener
        model.computerMakeGame()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: startGame)
        }
    }
}
