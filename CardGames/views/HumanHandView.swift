//
//  HumanHandView.swift
//  CardGames
//
//  Created by Mark Bailey on 13/10/2022.
//

import SwiftUI

struct HumanHandView: View {
    @ObservedObject var viewModel : HandVM
    
    var body: some View {
        HStack {
            if let card = viewModel.card1 {
                SelectableCardView(playingCard: card)
            } else {
                EmptyCardView()
            }
            if let card = viewModel.card2 {
                SelectableCardView(playingCard: card)
            } else {
                EmptyCardView()
            }
            if let card = viewModel.card3 {
                SelectableCardView(playingCard: card)
            } else {
                EmptyCardView()
            }
        }
    }
}

struct HumanHandView_Previews: PreviewProvider {
    static var previews: some View {
        HumanHandView(viewModel: HandVM())
    }
}
