//
//  BorderedText.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct BorderedText: View {
    private let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.title)
            .padding()
            .background(Color("SecondaryColor"))
            .foregroundColor(Color("PrimaryColor"))
            .padding(10)
            .border(Color("SecondaryColor"), width: 5)
    }
}

#Preview {
    BorderedText("Test")
}
