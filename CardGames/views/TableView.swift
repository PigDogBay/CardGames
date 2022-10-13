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
        HStack{
            VStack {
                PlayerView(viewModel: viewModel.players[2])
                    .padding()
                PlayerView(viewModel: viewModel.players[1])
                    .padding()
            }
            VStack {
                Text(viewModel.status)
                PlayerView(viewModel: viewModel.players[3])
                    .padding()
                HandView(viewModel: viewModel.middleVM)
                    .padding()
                PlayerView(viewModel: viewModel.players[0])
                    .padding()
                Button(action: viewModel.action){
                    Text("ACTION")
                }
            }
            VStack {
                PlayerView(viewModel: viewModel.players[4])
                    .padding()
                PlayerView(viewModel: viewModel.players[5])
                    .padding()
            }
        }.onReceive(viewModel.timer){_ in viewModel.action()}
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}
