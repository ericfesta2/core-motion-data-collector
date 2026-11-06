//
//  ContentView.swift
//  Core Motion Data Collector
//
//  Created by Eric Festa on 9/1/25.
//

import SwiftUI
import os

let logger = Logger()

struct MainViewWrap: View {
    private let motionDataCollector = MotionDataCollector()
    private let settingsManager = SettingsManager()

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    #if !os(watchOS)
    @State private var preferredColumn: NavigationSplitViewColumn = .sidebar
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    #endif

    var body: some View {
        #if targetEnvironment(simulator)
        let hasMotionError = false // Simulator can't collect motion data, but show the full interface anyway for testing purposes
        #else
        let hasMotionError = motionDataCollector.isError
        #endif

        let horizontalSizeClassNonNil = (horizontalSizeClass ?? .compact) // horizontalSizeClass may be nil on watchOS

        if !hasMotionError {
            if #available(iOS 27.1, watchOS 27.1, *) {
                let baseArrangementView = ArrangementView {
                    NavigationStack {
                        MainView(
                            motionDataCollector: motionDataCollector,
                            settingsManager: settingsManager,
                            openSettingsWithButton: horizontalSizeClassNonNil == .compact
                        )
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } secondary: {
                    if (horizontalSizeClassNonNil == .regular) {
                        NavigationStack {
                            MainSettingsView(settingsManager: settingsManager)
                                .navigationTitle("Settings")
                        }
                    }
                }

                if (horizontalSizeClassNonNil == .compact) {
                    baseArrangementView
                        .arrangementViewStyle(.overlay)
                } else {
                    baseArrangementView
                }
            } else {
                NavigationStack {
                    MainView(
                        motionDataCollector: motionDataCollector,
                        settingsManager: settingsManager,
                        openSettingsWithButton: horizontalSizeClassNonNil == .compact
                    )
                }
            }
        } else {
            Text("Motion data unavailable. Quit the app and try again.")
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    MainViewWrap()
}
