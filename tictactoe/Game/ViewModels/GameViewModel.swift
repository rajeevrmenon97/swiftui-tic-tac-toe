//
//  GameViewModel.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    // Array holding the state of each square in the grid
    @Published var grid: [[GridState]] = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
    
    // Player who's turn it is now
    @Published var currentPlayer: Player
    
    // Is the game over?
    @Published var isGameOver = false
    
    // Is it a multipeer game?
    let isMultiPeer: Bool
    
    // Is this device the host of the game?
    let isHost: Bool
    
    // Player 1: In multipeer sessions, this player is the host
    private let player1: Player
    
    // Player 2
    private let player2: Player
    
    // Multipeer connection service
    private let peerService: MultiPeerService?
    
    // Cancellables
    private var cancellables: Set<AnyCancellable> = []
    
    init(player1: Player, player2: Player, isMultiPeer: Bool = false, peerService: MultiPeerService? = nil, isHost: Bool = true) {
        self.player1 = player1
        self.player2 = player2
        self.currentPlayer = player1
        self.isMultiPeer = isMultiPeer
        self.peerService = peerService
        self.isHost = isHost
        
        // Register observers for receiving moves from multipeer service
        if isMultiPeer {
            self.peerService!.receivedMove
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { move in
                    self.updateGridState(xIndex: move.xIndex, yIndex: move.yIndex)
                }).store(in: &cancellables)
        }
    }
    
    // Function to check if the game is over, returns the winner or nil
    func checkGameOver() -> Player? {
        // Check rows
        for row in grid {
            if row.allSatisfy({ $0 == player1.symbol }) {
                return player1
            } else if row.allSatisfy({ $0 == player2.symbol }) {
                return player2
            }
        }
        
        // Check columns
        for col in 0..<3 {
            let column = grid.map { $0[col] }
            if column.allSatisfy({ $0 == player1.symbol }) {
                return player1
            } else if column.allSatisfy({ $0 == player2.symbol }) {
                return player2
            }
        }
        
        // Check diagonals
        let leftToRightDiagonal = [grid[0][0], grid[1][1], grid[2][2]]
        let rightToLeftDiagonal = [grid[0][2], grid[1][1], grid[2][0]]
        
        if leftToRightDiagonal.allSatisfy({ $0 == player1.symbol }) || rightToLeftDiagonal.allSatisfy({ $0 == player1.symbol }) {
            return player1
        } else if leftToRightDiagonal.allSatisfy({ $0 == player2.symbol }) || rightToLeftDiagonal.allSatisfy({ $0 == player2.symbol }) {
            return player2
        }
        
        // The game is still ongoing
        return nil
    }
    
    // This function returns true if the current player is the
    // player on this device in a multipeer session
    func isPlayersTurn() -> Bool {
        return isMultiPeer && ((isHost && currentPlayer.id == player1.id) || (!isHost && currentPlayer.id == player2.id))
    }
    
    // Function which plays a turn for the current player
    func playTurn(xIndex: Int, yIndex: Int) {
        // Multipeer session and
        // The turn of the player on this device
        if isPlayersTurn() && grid[xIndex][yIndex] == .empty {
            peerService!.send(move: GameMove(xIndex: xIndex, yIndex: yIndex))
        } else {
            return // Do nothing, other player's turn
        }
        
        // Update the grid
        updateGridState(xIndex: xIndex, yIndex: yIndex)
    }
    
    // Function to update a particular grid square
    func updateGridState(xIndex: Int, yIndex: Int) {
        // Only update if grid is empty
        if grid[xIndex][yIndex] == .empty {
            grid[xIndex][yIndex] = currentPlayer.symbol
            if currentPlayer.id == player1.id {
                currentPlayer = player2
            } else {
                currentPlayer = player1
            }
        }
        
        // Check if the game is over
        if let winner = checkGameOver() {
            currentPlayer = winner
            isGameOver = true
        }
    }
}
