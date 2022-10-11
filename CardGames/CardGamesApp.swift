//
//  CardGamesApp.swift
//  CardGames
//
//  Created by Mark Bailey on 09/09/2022.
//

import SwiftUI

@main
struct CardGamesApp: App {
    
    let viewModel = TableVM()
    func startGame(){
        let model = Model()
        //let listener = GameUpdateLogger()
        let listener = NullLogger()
        model.gameListener = listener
//        model.computerMakeGame()
    }
    
    var body: some Scene {
        WindowGroup {
            TableView(viewModel: viewModel)
                .onAppear(perform: startGame)
        }
    }
}
