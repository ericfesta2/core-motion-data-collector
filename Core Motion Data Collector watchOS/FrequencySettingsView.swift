//
//  FrequencySettingsView.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/21/25.
//

import SwiftUI

struct FrequencySettingsView: View {
    @Environment(\.dismiss) private var dismiss

    private var settingsManager: SettingsManager

    @State private var selectedFrequencyHz: Int
    @FocusState private var isStepperFocused: Bool

    private static let MIN_FREQ_HZ = 10
    private static let MAX_FREQ_HZ = 100
    private static let FREQ_STEP_HZ = 10

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
        self.selectedFrequencyHz = settingsManager.frequencyHz
    }

    // Known bug: when this view appears, a warning log is emitted:
    // "Crown Sequencer was set up without a view property. This will inevitably lead to incorrect crown indicator states"
    var body: some View {
        Stepper(
            value: self.$selectedFrequencyHz,
            in: FrequencySettingsView.MIN_FREQ_HZ...FrequencySettingsView.MAX_FREQ_HZ,
            step: FrequencySettingsView.FREQ_STEP_HZ
        ) {
            Text("\(self.selectedFrequencyHz) Hz")
                .multilineTextAlignment(.center)
        }
            .focusable(true)
            .focused(self.$isStepperFocused)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        self.settingsManager.saveFrequency(newValue: self.selectedFrequencyHz)
                        self.dismiss()
                    }
                        .disabled(self.selectedFrequencyHz < FrequencySettingsView.MIN_FREQ_HZ)
                        .handGestureShortcutIfAvailable()
                }
            }
            .onAppear {
                self.selectedFrequencyHz = self.settingsManager.frequencyHz
                self.isStepperFocused = true
            }
            .onDisappear {
                self.isStepperFocused = false
            }
    }
}
