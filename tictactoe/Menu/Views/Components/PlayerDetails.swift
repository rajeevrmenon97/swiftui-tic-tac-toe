//
//  PlayerDetailsView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

// View to get player names
struct PlayerDetails: View {
    @Binding var isMultiPeer: Bool
    @Binding var player1Name: String
    @Binding var player2Name: String
    @Binding var displayedView: Int
    
    @FocusState private var player1FieldIsFocused: Bool
    @FocusState private var player2FieldIsFocused: Bool
    
    var body: some View {
        VStack {
            TitleText(isMultiPeer ? "Player Name:" : "Player 1 Name:")
            TextField(
                "Player 1",
                text: $player1Name
            )
            .focused($player1FieldIsFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.bottom)
            
            // Ask for second player's name in co-op mode
            if !isMultiPeer {
                TitleText("Player 2 Name:")
                TextField(
                    "Player 2",
                    text: $player2Name
                )
                .focused($player2FieldIsFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding(.bottom)
            }
            
            Button(action: {
                player1FieldIsFocused = false
                player2FieldIsFocused = false
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
