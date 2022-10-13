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
                CardView(playingCard: card)
            } else {
                EmptyCardView()
            }
            if let card = viewModel.card2 {
                CardView(playingCard: card)
            } else {
                EmptyCardView()
            }
            if let card = viewModel.card3 {
                CardView(playingCard: card)
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
