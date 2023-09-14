//
//  tictactoeApp.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/9/23.
//

import SwiftUI

@main
struct tictactoeApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
