//
//  MainSettingsView.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/21/25.
//

import SwiftUI

struct MainSettingsView: View {
    private let settingsManager: SettingsManager

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
    }

    var body: some View {
        List {
            NavigationLink(destination: MotionDataSettingsView(settingsManager: self.settingsManager)) {
                Text("Data to Collect")
                    .multilineTextAlignment(.center)
            }

            NavigationLink(destination: FrequencySettingsView(settingsManager: self.settingsManager)) {
                Text("Frequency")
                    .multilineTextAlignment(.center)
            }

            NavigationLink(destination: AboutSettingsView()) {
                Text("About")
                    .multilineTextAlignment(.center)
            }
        }
    }
}
