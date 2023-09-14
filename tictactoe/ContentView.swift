//
//  ContentView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/9/23.
//

import SwiftUI

// Main view
struct ContentView: View {
    
    var body: some View {
        GameView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ContentView().preferredColorScheme)
    }
}
