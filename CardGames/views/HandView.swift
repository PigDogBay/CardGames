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
            SelectableCardView(viewModel: viewModel.card1VM)
            SelectableCardView(viewModel: viewModel.card2VM)
            SelectableCardView(viewModel: viewModel.card3VM)
        }
    }
}


struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView(viewModel: HandVM())
    }
}
