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
    
    @Published var currentPlayer: Player
    
    @Published var isGameOver = false
    
    let isMultiPeer: Bool
    let isHost: Bool
    
    private let player1: Player
    private let player2: Player
    private let peerService: MultiPeerService?
    private var cancellables: Set<AnyCancellable> = []
    
    init(player1: Player, player2: Player, isMultiPeer: Bool = false, peerService: MultiPeerService? = nil, isHost: Bool = true) {
        self.player1 = player1
        self.player2 = player2
        self.currentPlayer = player1
        self.isMultiPeer = isMultiPeer
        self.peerService = peerService
        self.isHost = isHost
        
        if isMultiPeer {
            self.peerService!.receivedMove
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { move in
                    self.updateGridState(xIndex: move.xIndex, yIndex: move.yIndex)
                }).store(in: &cancellables)
        }
    }
    
    // Function to clear the grid
    func resetGrid() {
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                grid[i][j] = .empty
            }
        }
        currentPlayer = player1
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
    
    func isPlayersTurn() -> Bool {
        return isMultiPeer && ((isHost && currentPlayer.id == player1.id) || (!isHost && currentPlayer.id == player2.id))
    }
    
    func playTurn(xIndex: Int, yIndex: Int) {
        if isPlayersTurn() {
            peerService!.send(move: GameMove(xIndex: xIndex, yIndex: yIndex))
        } else {
            return
        }
        updateGridState(xIndex: xIndex, yIndex: yIndex)
    }
    
    // Function to update a particular grid with current turn value
    func updateGridState(xIndex: Int, yIndex: Int) {
        if grid[xIndex][yIndex] == .empty {
            grid[xIndex][yIndex] = currentPlayer.symbol
            if currentPlayer.id == player1.id {
                currentPlayer = player2
            } else {
                currentPlayer = player1
            }
        }
        
        if let winner = checkGameOver() {
            currentPlayer = winner
            isGameOver = true
        }
    }
}
