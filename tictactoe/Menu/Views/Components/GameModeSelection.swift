//
//  GameModeSelectionView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct GameModeSelection: View {
    
    @Binding var isCoop: Bool
    @Binding var displayedView: Int
    
    var body: some View {
        VStack {
            Button(action: {
                isCoop = true
                displayedView = 1
            }, label: {
                BorderedText("Co-op Multiplayer")
            })
            
            Button(action: {
                isCoop = false
                displayedView = 1
            }, label: {
                BorderedText(" Local Multiplayer ")
            })
        }
    }
}
