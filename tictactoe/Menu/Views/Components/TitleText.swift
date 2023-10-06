//
//  TitleText.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

// Title text view
struct TitleText: View {
    private let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(Color("SecondaryColor"))
            .font(.title)
            .padding()
    }
}

#Preview {
    TitleText("Test Title")
}
