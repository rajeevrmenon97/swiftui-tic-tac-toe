//
//  GameView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/14/23.
//

import SwiftUI

struct GameView: View {
    
    @State private var showInstructions = false
    
    @ObservedObject var gameViewModel: GameViewModel
    
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
        if gameViewModel.isMultiPeer {
            if gameViewModel.isPlayersTurn() {
                msg = "You win!"
            } else {
                msg = "You lose!"
                buttonMsg = "Get consolation prize!"
            }
        } else {
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
            
            // Button to reset the grid
            Button(action: {
                showInstructions.toggle()
            }) {
                Text("How to play?")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color("SecondaryColor"))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(10)
                    .border(Color("SecondaryColor"), width: 5)
            }.sheet(isPresented: $showInstructions) {
                Instructions(showInstructions: $showInstructions)
            }
        }.padding()
    }
}
