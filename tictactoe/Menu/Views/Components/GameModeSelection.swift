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
            Text("Play on a single phone:")
            Button(action: {
                isMultiPeer = false
                displayedView = 1
            }, label: {
                BorderedText("Co-op Multiplayer")
            }).padding(.bottom)
            
            Text("  Play on two phones:  ")
            Button(action: {
                isMultiPeer = true
                displayedView = 1
            }, label: {
                BorderedText(" Local Multiplayer ")
            })
        }
    }
}
