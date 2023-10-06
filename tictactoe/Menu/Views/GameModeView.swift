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
    
    var body: some View {
        switch (displayedView) {
        case 1:
            PlayerDetails(
                isCoop: $isCoop,
                player1Name: $player1Name,
                player2Name: $player2Name,
                displayedView: $displayedView)
        case 2:
            GameView(
                gameViewModel: GameViewModel(
                    player1: Player(
                        name: player1Name == "" ? "Player 1": player1Name,
                        symbol: .cross),
                    player2: Player(
                        name: player2Name == "" ? "Player 2": player2Name,
                        symbol: .circle)))
        case 3:
            PairingView(
                peerService: MultiPeerService(playerName: player1Name),
                displayedView: $displayedView)
        default:
            GameModeSelection(
                isCoop: $isCoop,
                displayedView: $displayedView)
        }
    }
}

#Preview {
    GameModeView()
}
