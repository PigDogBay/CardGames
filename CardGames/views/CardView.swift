//
//  CardView.swift
//  CardGames
//
//  Created by Mark Bailey on 10/10/2022.
//

import SwiftUI

let CARD_WIDTH : CGFloat = 60
let CARD_HEIGHT : CGFloat = 100

struct CardView: View {
    let playingCard : PlayingCard
    var textColor : Color {
        if playingCard.isRed {
            return .red
        }
        return .black
    }
    var backColor : Color {
        if playingCard.isDown {
            return .blue
        }
        return .white
    }

    var body: some View {
        VStack {
            if !playingCard.isDown {
                Text(playingCard.rank.display())
                    .font(.title)
                    .foregroundColor(textColor)
                Text(playingCard.suit.display())
                    .font(.title)
            }
        }
        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
        .background(backColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 1)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.green).edgesIgnoringSafeArea(.all)
            HStack {
                CardView(playingCard: PlayingCard(suit: .spades, rank: .jack, isDown: false))
                CardView(playingCard: PlayingCard(suit: .hearts, rank: .queen, isDown: false))
                CardView(playingCard: PlayingCard(suit: .diamonds, rank: .king))
            }
        }
    }
}
