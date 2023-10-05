//
//  AboutTab.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct AboutTab: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Created By").bold().font(.headline)
            Text("Rajeev Menon").font(.subheadline).padding()
            Button(action: {
                if let url = URL(string: "https://github.com/rajeevrmenon97/swiftui-tic-tac-toe") {
                    UIApplication.shared.open(url)
                }
            }) {
                HStack {
                    Image(systemName: "link")
                    Text("Github").foregroundColor(.blue)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    AboutTab()
}
