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
        case 1:
            Text("🔴")
        case 2:
            Text("🔴🔴")
        default:
            Text("🔴🔴🔴")
        }
    }
}

struct LivesView_Previews: PreviewProvider {
    static var previews: some View {
        LivesView(lives: .constant(3))
    }
}
