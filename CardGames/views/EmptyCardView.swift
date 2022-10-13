//
//  EmptyCardView.swift
//  CardGames
//
//  Created by Mark Bailey on 13/10/2022.
//

import SwiftUI

struct EmptyCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(.gray, lineWidth: 1)
            .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
    }
}

struct EmptyCardView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCardView()
    }
}
