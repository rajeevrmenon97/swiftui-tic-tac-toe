//
//  Instructions.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct Instructions: View {
    @Binding var showInstructions: Bool
    
    var body: some View {
        VStack {
            Text("Tic-Tac-Toe Instructions")
                .font(.largeTitle)
                .padding()
            
            Text("Tic-Tac-Toe is a two-player game where you take turns marking a 3x3 grid with your symbol (either X or O). The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.")
                .padding()
        }.padding()
        
    }
}
