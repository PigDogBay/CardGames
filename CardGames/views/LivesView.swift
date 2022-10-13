//
//  LivesView.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import SwiftUI

struct LivesView: View {
    @Binding var lives : Int
    var body: some View {
        switch lives {
        case 0:
            Text("")
                .font(.caption)
        case 1:
            Text("🔴")
                .font(.caption)
        case 2:
            Text("🔴🔴")
                .font(.caption)
        default:
            Text("🔴🔴🔴")
                .font(.caption)
        }
    }
}

struct LivesView_Previews: PreviewProvider {
    static var previews: some View {
        LivesView(lives: .constant(3))
    }
}
