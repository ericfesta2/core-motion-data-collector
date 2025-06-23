//
//  ContentView.swift
//  Motion Data Collector Watch App
//
//  Created by Eric Festa on 5/18/25.
//

import SwiftUI
import os

let logger = Logger()

struct ContentView: View {
    private let motionDataCollector = MotionDataCollector()
    private let settingsManager = SettingsManager()

    var body: some View {
        #if targetEnvironment(simulator)
            let hasMotionError = false // Simulator can't collect motion data, but show the full interface anyway for testing purposes
        #else
            let hasMotionError = motionDataCollector.isError
        #endif

        if !hasMotionError {
            NavigationStack {
                VStack {
                    Text(!motionDataCollector.isCollectingData ? "Tap 'Start' to collect data." : "Collecting data. Check the debug logs...")

                    Spacer()

                    Button(!motionDataCollector.isCollectingData ? "Start" : "Stop") {
                        if !motionDataCollector.isCollectingData {
                            motionDataCollector.recordMotionData(freq: 1 / Double(settingsManager.frequencyHz), typesToRecord: settingsManager.enabledTypes)
                        } else {
                            motionDataCollector.stopMotionData()
                        }
                    }
                        .handGestureShortcutIfAvailable()
                }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            NavigationLink(destination: MainSettingsView(settingsManager: settingsManager)) {
                                Image(systemName: "gearshape")
                            }
                        }
                    }
            }
        } else {
            Text("Motion data unavailable. Quit the app and try again.")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ContentView()
}
