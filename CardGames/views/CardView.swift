//
//  CardView.swift
//  CardGames
//
//  Created by Mark Bailey on 10/10/2022.
//

import SwiftUI

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
            if playingCard.isDown {
                Text(playingCard.rank.display())
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.top, 8)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                Text("__")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.top, 0)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .padding(.bottom, 8)
            } else {
                Text(playingCard.rank.display())
                    .font(.title)
                    .foregroundColor(textColor)
                    .padding(.top, 8)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                Text(playingCard.suit.display())
                    .font(.title)
                    .padding(.top, 0)
                    .padding(.leading,8)
                    .padding(.trailing,8)
                    .padding(.bottom, 8)
            }
        }
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
