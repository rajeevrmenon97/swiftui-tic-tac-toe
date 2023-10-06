//
//  SettingsView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 9/14/23.
//

import SwiftUI

// Main view for settings
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
