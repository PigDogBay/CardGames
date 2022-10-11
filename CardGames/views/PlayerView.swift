//
//  PlayerView.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel : PlayerVM
    var body: some View {
        VStack {
            Text(viewModel.name)
            HandView(viewModel: viewModel.handVM)
            LivesView(lives: $viewModel.lives)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(viewModel: PlayerVM(name: "Howie"))
    }
}
