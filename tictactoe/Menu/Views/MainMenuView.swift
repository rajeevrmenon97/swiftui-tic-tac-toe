//
//  MainMenuView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
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
                    NavigationLink(destination: GameModeView()) {
                        Text("Start Game")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding()
                            .background(Color("SecondaryColor"))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(10)
                            .border(Color("SecondaryColor"), width: 5)
                    }.padding()
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding()
                            .background(Color("SecondaryColor"))
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(10)
                            .border(Color("SecondaryColor"), width: 5)
                    }.padding()
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    MainMenuView()
}
