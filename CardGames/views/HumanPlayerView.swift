//
//  HumanPlayerView.swift
//  CardGames
//
//  Created by Mark Bailey on 13/10/2022.
//

import SwiftUI

struct HumanPlayerView: View {
    @ObservedObject var viewModel : PlayerVM
    var body: some View {
        VStack {
            HumanHandView(viewModel: viewModel.handVM)
            HStack{
                if (viewModel.isDealer){
                    Text("⭐️")
                }
                Text(viewModel.player.name)
                Spacer()
                LivesView(lives: $viewModel.lives)
            }
        }
        .modifier(HighlightPlayerMod(isPlaying: viewModel.isPlayingTurn))
        .frame(width: 200, height: 120)

    }
}

struct HumanPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        HumanPlayerView(viewModel: PlayerVM(player: Player(name: "", ai: BestAI())))
    }
}
