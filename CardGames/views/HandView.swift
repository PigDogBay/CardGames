//
//  MiddleView.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import SwiftUI

struct HandView: View {
    @ObservedObject var viewModel : HandVM
    
    var body: some View {
        HStack {
            if let card = viewModel.card1 {
                SelectableCardView(playingCard: card, isSelected: $viewModel.isCardOneSelected)
            } else {
                EmptyCardView()
            }
            if let card = viewModel.card2 {
                SelectableCardView(playingCard: card, isSelected: $viewModel.isCardTwoSelected)
            } else {
                EmptyCardView()
            }
            if let card = viewModel.card3 {
                SelectableCardView(playingCard: card, isSelected: $viewModel.isCardThreeSelected)
            } else {
                EmptyCardView()
            }
        }
    }
}


struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView(viewModel: HandVM())
    }
}
