//
//  Player.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import Foundation

class Player {
    
    init(name: String, symbol: GridState) {
        self.name = name
        self.symbol = symbol
        self.id = UUID()
    }
    
    let id: UUID
    
    let name: String
    
    let symbol: GridState
    
}
