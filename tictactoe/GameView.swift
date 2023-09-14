//
//  GameView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/14/23.
//

import SwiftUI

// Enum to hold various states of the grid
enum GridState {
    case empty, circle, cross
}

// Single square in a grid
struct GridSquare: View {
    let size: CGFloat
    let xIndex: Int
    let yIndex: Int
    
    @Binding var currentState: GridState
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("SecondaryColor"))
                .frame(width: size, height: size)
            if currentState == .circle {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: size * 0.5)
            } else if currentState == .cross {
                Image(systemName: "multiply")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: size * 0.5)
            }
            
        }
    }
}

struct GameView: View {
    
    // Array holding the state of each square in the grid
    @State private var grid: [[GridState]] = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
    
    // Current turn
    @State private var turn: GridState = .cross
    
    // Current player's symbol
    @State private var currentPlayer: String = "X"
    
    // Game over or not? Used for triggering the alert
    @State private var gameOver: Bool = false
    
    // Function to clear the grid
    func resetGrid() {
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                grid[i][j] = .empty
            }
        }
        currentPlayer = "X"
        turn = .cross
    }
    
    // Function to open youtube link
    func openYouTube() {
        if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") {
            UIApplication.shared.open(youtubeURL)
        }
    }
    
    // Alert when the game is over
    var gameOverAlert: Alert {
        var msg: String
        if turn == .cross{
            msg = "Player 1 wins!"
        } else {
            msg = "Player 2 wins!"
        }
        return Alert(
            title: Text("Game Over"),
            message: Text(msg),
            dismissButton: .default(Text("Get the prize!")) {
                resetGrid()
                openYouTube()
            }
        )
    }
    
    // Function to check if the game is over, returns the winner or nil
    func checkGameOver() -> GridState? {
        // Check rows
        for row in grid {
            if row.allSatisfy({ $0 == .circle }) {
                return .circle
            } else if row.allSatisfy({ $0 == .cross }) {
                return .cross
            }
        }
        
        // Check columns
        for col in 0..<3 {
            let column = grid.map { $0[col] }
            if column.allSatisfy({ $0 == .circle }) {
                return .circle
            } else if column.allSatisfy({ $0 == .cross }) {
                return .cross
            }
        }
        
        // Check diagonals
        let leftToRightDiagonal = [grid[0][0], grid[1][1], grid[2][2]]
        let rightToLeftDiagonal = [grid[0][2], grid[1][1], grid[2][0]]
        
        if leftToRightDiagonal.allSatisfy({ $0 == .circle }) || rightToLeftDiagonal.allSatisfy({ $0 == .circle }) {
            return .circle
        } else if leftToRightDiagonal.allSatisfy({ $0 == .cross }) || rightToLeftDiagonal.allSatisfy({ $0 == .cross }) {
            return .cross
        }
        
        // The game is still ongoing
        return nil
    }
    
    // Function to update a particular grid with current turn value
    func updateGridState(xIndex: Int, yIndex: Int) {
        if grid[xIndex][yIndex] == .empty {
            grid[xIndex][yIndex] = turn
            if turn == .cross {
                turn = .circle
                currentPlayer = "O"
            } else {
                turn = .cross
                currentPlayer = "X"
            }
        }
        
        let winner = checkGameOver() ?? .empty
        if winner != .empty {
            turn = winner
            gameOver = true
        }
    }
    
    var body: some View {
        VStack{
            Text("Current Player: " + currentPlayer)
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
                                GridSquare(size: geometry.size.width * 0.3, xIndex: i, yIndex: j, currentState: $grid[i][j])
                                    .onTapGesture {
                                        updateGridState(xIndex: i, yIndex: j)
                                    }.alert(isPresented: $gameOver) {
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
            Button(action: resetGrid) {
                Text("Reset")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color("SecondaryColor"))
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(10)
                    .border(Color("SecondaryColor"), width: 5)
            }
        }.padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
