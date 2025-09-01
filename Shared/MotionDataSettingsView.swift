//
//  SettingsView.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/17/25.
//

import SwiftUI

struct MotionDataSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    private let HeaderTitle = "Motion data to collect"

    private let settingsManager: SettingsManager

    @State private var typesToEnable: Set<MotionDataType>

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
        self.typesToEnable = settingsManager.enabledTypes
    }

    private func settingEnablementBinding(for setting: MotionDataType) -> Binding<Bool> {
        Binding(
            get: { typesToEnable.contains(setting) },
            set: { newValue in
                if newValue {
                    typesToEnable.insert(setting)
                } else {
                    typesToEnable.remove(setting)
                }
            }
        )
    }

    private var settingsList: some View {
        ForEach(MotionDataType.allCases, id: \.rawValue) { type in
            let isSettingEnabledBinding = settingEnablementBinding(for: type)

            #if os(watchOS)
            Button {
                isSettingEnabledBinding.wrappedValue.toggle()
            } label: {
                Text(type.rawValue)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .foregroundStyle(.white)
                    .padding(18)
                    .fontWeight(isSettingEnabledBinding.wrappedValue ? .bold : .regular)
                    .background((isSettingEnabledBinding.wrappedValue ? Color.accentColor : Color.secondary).animation(.easeInOut))
                    .cornerRadius(12)
                    .multilineTextAlignment(.center)
            }
            .buttonStyle(PlainButtonStyle())
            #else
            Toggle(isOn: isSettingEnabledBinding) { Text(type.rawValue) }
            #endif
        }
    }

    var body: some View {
        List {
            #if os(watchOS)
            Section(header: Text(HeaderTitle)) {
                settingsList
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
            #else
            settingsList
            #endif
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
            #if os(iOS)
            .navigationBarTitle(HeaderTitle)
            .navigationBarTitleDisplayMode(.large)
            #endif
    }
}
