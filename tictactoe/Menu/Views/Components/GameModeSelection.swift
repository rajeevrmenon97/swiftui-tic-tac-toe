//
//  GameModeSelectionView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

// View to select between Co-op multiplayer
// and local multiplayer
struct GameModeSelection: View {
    
    @Binding var isMultiPeer: Bool
    @Binding var displayedView: Int
    
    var body: some View {
        VStack {
            Button(action: {
                isMultiPeer = false
                displayedView = 1
            }, label: {
                BorderedText("Co-op Multiplayer")
            })
            
            Button(action: {
                isMultiPeer = true
                displayedView = 1
            }, label: {
                BorderedText(" Local Multiplayer ")
            })
        }
    }
}
