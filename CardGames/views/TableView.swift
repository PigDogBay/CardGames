//
//  TableView.swift
//  CardGames
//
//  Created by Mark Bailey on 11/10/2022.
//

import SwiftUI

struct TableView: View {
    @ObservedObject var viewModel = TableVM()
    var body: some View {
        VStack {
            Text(viewModel.status)
            PlayerView(viewModel: viewModel.player1VM)
                .padding()
            HandView(viewModel: viewModel.middleVM)
                .padding()
            PlayerView(viewModel: viewModel.player2VM)
                .padding()
            Button(action: viewModel.action){
                Text("ACTION")
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}
