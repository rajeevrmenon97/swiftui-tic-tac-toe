//
//  ContentView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var grid: [[GridState]] = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
    
    @State private var turn: GridState = .cross
    
    @State private var currentPlayer: String = "X"
    
    @State private var gameOver: Bool = false
    
    var body: some View {
        VStack{
            // Header
            Text("Tic-Tac-Toe")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title)
                .padding()
            Spacer()
            
            // Player Info
            Text("Player 1: X")
                .foregroundColor(.black)
            Spacer()
            Text("Player 2: O")
                .foregroundColor(.black)
            Spacer()
            
            // Current Player Info
            Text("Current Player: " + currentPlayer)
                .foregroundColor(.black)
            
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
                    .background(.black)
                    .foregroundColor(.white)
                    .padding(10)
                    .border(.black, width: 5)
            }
        }.padding()
    }
    
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
            dismissButton: .default(Text("Get prize!")) {
                resetGrid()
                openYouTube()
            }
        )
    }
    
    func checkGameOver() -> GridState? {
        // Check rows, columns, and diagonals for a winner
        
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
    
    func resetGrid() {
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                grid[i][j] = .empty
            }
        }
        currentPlayer = "X"
        turn = .cross
    }
    
    func openYouTube() {
        if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") {
            UIApplication.shared.open(youtubeURL)
        }
    }
    
}

enum GridState {
    case empty, circle, cross
}

struct GridSquare: View {
    let size: CGFloat
    let xIndex: Int
    let yIndex: Int
    
    @Binding var currentState: GridState
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.black)
                .frame(width: size, height: size)
            if currentState == .circle {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: size * 0.5)
            } else if currentState == .cross {
                Image(systemName: "multiply")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: size * 0.5)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
