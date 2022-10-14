//
//  SelectableCard.swift
//  CardGames
//
//  Created by Mark Bailey on 13/10/2022.
//

import SwiftUI

struct SelectableCardView: View {
    @ObservedObject var viewModel : SelectableCardVM
    @State private var offset : CGFloat = 0
    
    var body: some View {
        if let card = viewModel.card {
            CardView(playingCard: card)
                .offset(x: 0, y: offset)
                .onReceive(viewModel.$offset){newOffset in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        offset = newOffset
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if viewModel.isSelected{
                            offset += 30
                        } else {
                            offset -= 30
                        }
                        viewModel.isSelected.toggle()
                    }
                }
        } else {
            EmptyCardView()
        }
    }
}

struct SelectableCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableCardView(viewModel: SelectableCardVM())
    }
}
