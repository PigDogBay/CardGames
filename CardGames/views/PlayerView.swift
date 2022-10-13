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
            HStack{
                if (viewModel.isDealer){
                    Text("⭐️")
                }
                Text(viewModel.player.name)
                Spacer()
                LivesView(lives: $viewModel.lives)
            }
            HandView(viewModel: viewModel.handVM)
        }
        .modifier(HighlightPlayerMod(isPlaying: viewModel.isPlayingTurn))
        .frame(width: 200, height: 120)

    }
}
struct HighlightPlayerMod : ViewModifier {
    let isPlaying : Bool
    func body(content: Content) -> some View {
        if isPlaying {
            content
                .padding()
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
