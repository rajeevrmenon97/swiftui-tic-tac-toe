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
        }
    }
}

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

struct SettingsView: View {
    @State var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(1)
            AboutTab()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }.tag(2)
        }.navigationTitle(selectedTab == 1 ? "Settings" : "About")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
