//
//  MainSettingsView.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/21/25.
//

import SwiftUI

struct MainSettingsView: View {
    private var settingsManager: SettingsManager

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
    }

    var body: some View {
        NavigationLink(destination: MotionDataSettingsView(settingsManager: self.settingsManager)) {
            Text("Data to Collect")
                .multilineTextAlignment(.center)
        }

        NavigationLink(destination: FrequencySettingsView(settingsManager: self.settingsManager)) {
            Text("Frequency")
                .multilineTextAlignment(.center)
        }
    }
}
