//
//  GameModeView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct GameModeView: View {
    
    @State private var displayedView = 0
    @State private var player1Name = ""
    @State private var player2Name = ""
    @State private var isCoop = true
    @State var multpeerSession: MultipeerSession?
    
    var gameModeSelectionView: some View {
        VStack {
            Button(action: {
                isCoop = true
                displayedView = 1
            }, label: {
                Text("Co-op Multiplayer")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color("SecondaryColor"))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(10)
                    .border(Color("SecondaryColor"), width: 5)
            })
            
            Button(action: {
                isCoop = false
                displayedView = 1
            }, label: {
                Text(" Local Multiplayer ")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color("SecondaryColor"))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(10)
                    .border(Color("SecondaryColor"), width: 5)
            })
        }
    }
    
    var playerDetailsView: some View {
        VStack {
            Text("Player 1 Name:")
                .fontWeight(.bold)
                .font(.title)
            TextField(
                "Player 1",
                text: $player1Name
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            .padding(.bottom)
            
            if isCoop {
                Text("Player 2 Name:")
                    .fontWeight(.bold)
                    .font(.title)
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
                if isCoop {
                    displayedView = 2
                } else {
                    displayedView = 3
                }
            }, label: {
                Text(" Start Game ")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color("SecondaryColor"))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(10)
                    .border(Color("SecondaryColor"), width: 5)
            })
            
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }
    
    var body: some View {
        switch (displayedView) {
        case 1:
            playerDetailsView
        case 2:
            GameView(gameViewModel: GameViewModel(
                player1: Player(name: player1Name == "" ? "Player 1": player1Name, symbol: .cross),
                player2: Player(name: player2Name == "" ? "Player 2": player2Name, symbol: .circle)
            ), displayedView: $displayedView)
        case 3:
            PairingView(session: MultipeerSession(username: player1Name), name: player1Name, displayedView: $displayedView)
        default:
            gameModeSelectionView
        }
    }
}

#Preview {
    GameModeView()
}
