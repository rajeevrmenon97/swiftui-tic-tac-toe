//
//  SettingsTab.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct SettingsTab: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        Form {
            Section(header: Text("Enable dark mode")) {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }
        }
    }
}

#Preview {
    SettingsTab()
}
