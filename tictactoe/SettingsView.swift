//
//  SettingsView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/14/23.
//

import SwiftUI

struct SettingsTab: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        Form {
            Section(header: Text("Enable dark mode")) {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }
        }.background(Color("PrimaryColor"))
    }
}

struct AboutTab: View {
    var body: some View {
        Text("About author")
    }
}

struct SettingsView: View {
    var body: some View {
        TabView {
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                    
                }
            AboutTab()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
