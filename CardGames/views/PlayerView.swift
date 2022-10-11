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
            if viewModel.isDealer {
                Text("⭐️\(viewModel.player.name)")
            } else {
                Text(viewModel.player.name)
            }
            HandView(viewModel: viewModel.handVM)
            LivesView(lives: $viewModel.lives)
        }
        .padding()
        .modifier(HighlightPlayerMod(isPlaying: viewModel.isPlayingTurn))

    }
}
struct HighlightPlayerMod : ViewModifier {
    let isPlaying : Bool
    func body(content: Content) -> some View {
        if isPlaying {
            content
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
        } else {
            content
        }
    }
}
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(viewModel: PlayerVM(player: Player(name: "Howie", ai: BestAI())))
    }
}
