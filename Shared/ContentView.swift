//
//  ContentView.swift
//  Core Motion Data Collector
//
//  Created by Eric Festa on 9/1/25.
//

import SwiftUI
import os

let logger = Logger()

private struct OSSpecificProperties {
    let mainVStackSpacing: CGFloat
    let mainHeadingNotStartedText: String
    let mainHeadingStartedText: String
}

struct ContentView: View {
    private let motionDataCollector = MotionDataCollector()
    private let settingsManager = SettingsManager()

    #if os(watchOS)
    private let osSpecificProperties = OSSpecificProperties(
        mainVStackSpacing: 0,
        mainHeadingNotStartedText: "Tap 'Start' to collect data.",
        mainHeadingStartedText: "Collecting data. Check the Xcode debug logs..."
    )
    #else
    private let osSpecificProperties = OSSpecificProperties(
        mainVStackSpacing: 20,
        mainHeadingNotStartedText: "Collect Motion Data",
        mainHeadingStartedText: "Collecting Motion Data"
    )
    #endif

    var body: some View {
        #if targetEnvironment(simulator)
            let hasMotionError = false // Simulator can't collect motion data, but show the full interface anyway for testing purposes
        #else
            let hasMotionError = motionDataCollector.isError
        #endif

        if !hasMotionError {
            NavigationStack {
                VStack(spacing: osSpecificProperties.mainVStackSpacing) {
                    Text(!motionDataCollector.isCollectingData ?
                         osSpecificProperties.mainHeadingNotStartedText :
                         osSpecificProperties.mainHeadingStartedText
                    )
                        .multilineTextAlignment(.center)
                        #if !os(watchOS)
                        .font(.largeTitle)
                        .bold()
                        #endif

                    #if os(watchOS)
                    Spacer()
                    #else
                    Text(!motionDataCollector.isCollectingData ? "Tap 'Start' to collect data." : "Check the Xcode debug logs...")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    #endif

                    Button(!motionDataCollector.isCollectingData ? "Start" : "Stop") {
                        if !motionDataCollector.isCollectingData {
                            motionDataCollector.recordMotionData(freq: 1 / Double(settingsManager.frequencyHz), typesToRecord: settingsManager.enabledTypes)
                        } else {
                            motionDataCollector.stopMotionData()
                        }
                    }
                        .handGestureShortcutIfAvailable()
                        #if !os(watchOS)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        #endif
                }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            NavigationLink(destination: MainSettingsView(settingsManager: settingsManager)) {
                                #if os(watchOS)
                                Image(systemName: "gearshape")
                                #else
                                Text("Settings")
                                #endif
                            }
                        }
                    }
                    #if !os(watchOS)
                    .padding()
                    #endif
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
