//
//  GameView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/14/23.
//

import SwiftUI

struct GameView: View {
    // Boolean state controlling the instructions modal
    @State private var showInstructions = false
    
    // View model for the game view
    @ObservedObject var gameViewModel: GameViewModel
    
    // Variable controlling the navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Function to open youtube link
    func openYouTube() {
        if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") {
            UIApplication.shared.open(youtubeURL)
        }
    }
    
    // Alert when the game is over
    var gameOverAlert: Alert {
        var msg: String
        var buttonMsg = "Get the prize!"
        
        // Local Multiplayer mode
        if gameViewModel.isMultiPeer {
            // Since the gameViewModel.currentPlayer is set as the winner when game is over
            // gameViewModel.isPlayersTurn can be used to check
            // if the player is the currentPlayer and thus the winner
            if gameViewModel.isPlayersTurn() {
                // If the player wins
                msg = "You win!"
            } else {
                // The opponent wins
                msg = "You lose!"
                buttonMsg = "Get consolation prize!"
            }
        } else { // When in Co-op mode
            msg = "\(gameViewModel.currentPlayer.name) wins!"
        }
        return Alert(
            title: Text("Game Over"),
            message: Text(msg),
            primaryButton: .default(Text(buttonMsg), action: {
                openYouTube()
                presentationMode.wrappedValue.dismiss()
            }),
            secondaryButton: .default(Text("Exit"), action: {
                presentationMode.wrappedValue.dismiss()
            })
        )
    }
    
    var body: some View {
        VStack{
            // Info about the current player
            Text("Current Player: " + gameViewModel.currentPlayer.name)
                .fontWeight(.bold)
                .foregroundColor(Color("SecondaryColor"))
                .font(.title)
                .padding()
            
            // The Grid
            GeometryReader{ geometry in
                VStack {
                    ForEach(0..<3) { i in
                        HStack {
                            ForEach(0..<3) { j in
                                GridSquare(size: geometry.size.width * 0.3, xIndex: i, yIndex: j, currentState: $gameViewModel.grid[i][j])
                                    .onTapGesture {
                                        gameViewModel.playTurn(xIndex: i, yIndex: j)
                                    }.alert(isPresented: $gameViewModel.isGameOver) {
                                        gameOverAlert
                                    }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width * 0.3)
                    }
                }
                .frame(height: geometry.size.height)
            }
            
            // Button to toggle the instructions modal
            Button(action: {
                showInstructions.toggle()
            }) {
                BorderedText("How to play?")
            }.sheet(isPresented: $showInstructions) {
                Instructions(showInstructions: $showInstructions)
            }
        }.padding()
    }
}
