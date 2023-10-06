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
                    
                    TitleText("Tic-Tac-Toe")
                    
                    NavigationLink(destination: GameModeView()) {
                        BorderedText("Start Game")
                    }.padding()
                    
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
