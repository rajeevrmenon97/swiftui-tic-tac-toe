//
//  MainMenuView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack{
                    Spacer()
                    
                    // Logo
                    HStack {
                        Spacer()
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.5)
                            .padding()
                        Spacer()
                    }
                    
                    // Main title
                    TitleText("Tic-Tac-Toe")
                    
                    // Nav link to game mode selection
                    NavigationLink(destination: GameModeView()) {
                        BorderedText("Start Game")
                    }.padding()
                    
                    // Nav link to settings
                    NavigationLink(destination: SettingsView()) {
                        BorderedText("Settings")
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
