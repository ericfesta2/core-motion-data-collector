//
//  MainView.swift
//  Core Motion Data Collector
//
//  Created by Eric Festa on 11/2/26.
//

import SwiftUI

private struct OSSpecificProperties {
    let mainVStackSpacing: CGFloat
    let mainHeadingNotStartedText: String
    let mainHeadingStartedText: String
}

struct MainView: View {
    let motionDataCollector: MotionDataCollector
    let settingsManager: SettingsManager
    let openSettingsWithButton: Bool

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
                if (openSettingsWithButton) {
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
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                #if !os(watchOS)
                .padding()
                #endif
    }
}
