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
    @Binding var isSelected : Bool
    
    var body: some View {
        CardView(playingCard: viewModel.playingCard)
            .offset(x: 0, y: offset)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.1)) {
                    if isSelected{
                        offset += 30
                    } else {
                        offset -= 30
                    }
                    isSelected.toggle()
                }
            }
    }
}

struct SelectableCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableCardView(viewModel: SelectableCardVM(playingCard: PlayingCard(suit: .hearts, rank: .queen, isDown: false)), isSelected: .constant(true))
    }
}
