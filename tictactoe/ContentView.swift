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
        MainMenuView()
    }
}

struct MainMenuView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.5)
                        .padding()
                    Spacer()
                }
                Text("Tic-Tac-Toe")
                    .fontWeight(.bold)
                    .foregroundColor(Color("SecondaryColor"))
                    .font(.title)
                    .padding()
                Button(action: {}) {
                    Text("Start Game")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .background(Color("SecondaryColor"))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(10)
                        .border(Color("SecondaryColor"), width: 5)
                }
                Button(action: {}) {
                    Text("Settings")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .background(Color("SecondaryColor"))
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(10)
                        .border(Color("SecondaryColor"), width: 5)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: ContentView().preferredColorScheme)
    }
}
