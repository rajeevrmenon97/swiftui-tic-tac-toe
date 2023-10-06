//
//  PlayerDetailsView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct PlayerDetails: View {
    @Binding var isMultiPeer: Bool
    @Binding var player1Name: String
    @Binding var player2Name: String
    @Binding var displayedView: Int
    
    var body: some View {
        VStack {
            TitleText("Player 1 Name:")
            TextField(
                "Player 1",
                text: $player1Name
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.bottom)
            
            if !isMultiPeer {
                TitleText("Player 2 Name:")
                TextField(
                    "Player 2",
                    text: $player2Name
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding(.bottom)
            }
            
            Button(action: {
                if isMultiPeer {
                    displayedView = 3
                } else {
                    displayedView = 2
                }
            }, label: {
                BorderedText(" Start Game ")
            })
            
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }
}
