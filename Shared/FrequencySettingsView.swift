//
//  FrequencySettingsView.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/21/25.
//

import SwiftUI

struct FrequencySettingsView: View {
    @Environment(\.dismiss) private var dismiss

    private let settingsManager: SettingsManager

    @State private var selectedFrequencyHz: Int

    private static let HeaderTitle = "Frequency"
    private static let MinFreqHz = 10
    private static let MaxFreqHz = 100
    private static let FreqStepHz = 10

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
        self.selectedFrequencyHz = settingsManager.frequencyHz
    }

    // Known bug: when this view appears, a warning log is emitted on both Simulator and a physical device:
    // "Crown Sequencer was set up without a view property. This will inevitably lead to incorrect crown indicator states"
    // On physical devices, another warning log appears when scrolling the Stepper via Digital Crown:
    // "overrelease of detent assertion detected"
    var body: some View {
        VStack {
            #if os(watchOS)
            Stepper(
                value: self.$selectedFrequencyHz,
                in: FrequencySettingsView.MinFreqHz...FrequencySettingsView.MaxFreqHz,
                step: FrequencySettingsView.FreqStepHz
            ) {
                Text("\(self.selectedFrequencyHz) Hz")
                    .multilineTextAlignment(.center)
            }
            #else
            Picker("Frequency", selection: self.$selectedFrequencyHz) {
                ForEach(Array(stride(from: FrequencySettingsView.MinFreqHz, to: FrequencySettingsView.MaxFreqHz + 1, by: FrequencySettingsView.FreqStepHz)), id: \.self) {
                    Text("\($0) Hz")
                }
            }
                .pickerStyle(.wheel)
            #endif
        }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        self.settingsManager.saveFrequency(newValue: self.selectedFrequencyHz)
                        self.dismiss()
                    }
                        .disabled(self.selectedFrequencyHz < FrequencySettingsView.MinFreqHz || self.selectedFrequencyHz > FrequencySettingsView.MaxFreqHz)
                        .handGestureShortcutIfAvailable()
                }
            }
            .onAppear {
                self.selectedFrequencyHz = self.settingsManager.frequencyHz
            }
            #if os(iOS)
            .navigationBarTitle(FrequencySettingsView.HeaderTitle)
            .navigationBarTitleDisplayMode(.large)
            #endif
    }
}
