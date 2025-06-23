//
//  SettingsView.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/17/25.
//

import SwiftUI

struct MotionDataSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    private let settingsManager: SettingsManager

    @State private var typesToEnable: Set<MotionDataType>

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
        self.typesToEnable = settingsManager.enabledTypes
    }

    var body: some View {
        List {
            Section(header: Text("Motion data to collect")) {
                ForEach(MotionDataType.allCases, id: \.rawValue) { type in
                    let isEnabled = self.typesToEnable.contains(type)

                    Button {
                        if !isEnabled {
                            self.typesToEnable.insert(type)
                        } else {
                            self.typesToEnable.remove(type)
                        }
                    } label: {
                        Text(type.rawValue)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            .foregroundStyle(.white)
                            .padding(18)
                            .fontWeight(isEnabled ? .bold : .regular)
                            .background((isEnabled ? Color.accentColor : Color.secondary).animation(.easeInOut))
                            .cornerRadius(12)
                            .multilineTextAlignment(.center)
                    }
                        .buttonStyle(PlainButtonStyle())
                }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
        }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        self.settingsManager.saveEnabledTypes(newValues: self.typesToEnable)
                        self.dismiss()
                    }
                        .disabled(self.typesToEnable.count == 0)
                        .handGestureShortcutIfAvailable()
                }
            }
            .onAppear {
                self.typesToEnable = self.settingsManager.enabledTypes
            }
    }
}
