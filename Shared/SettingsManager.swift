//
//  SettingsManager.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/17/25.
//

import SwiftUI

final class SettingsManager {
    private(set) var enabledTypes: Set<MotionDataType>
    private(set) var frequencyHz: Int

    private static let EnabledTypesStorageKey = "enabledTypes"
    private static let FrequencyStorageKey = "frequency"

    private static let DefaultFrequencyHzValue = 100

    private static let jsonEncoder = JSONEncoder()
    private static let jsonDecoder = JSONDecoder()

    init() {
        self.enabledTypes = SettingsManager.loadEnabledTypes()
        self.frequencyHz = SettingsManager.loadFrequency()
    }

    func saveEnabledTypes(newValues: Set<MotionDataType>) {
        self.enabledTypes = newValues
        UserDefaults.standard.set(try! SettingsManager.jsonEncoder.encode(newValues), forKey: SettingsManager.EnabledTypesStorageKey)
    }

    func saveFrequency(newValue: Int) {
        self.frequencyHz = newValue
        UserDefaults.standard.set(newValue, forKey: SettingsManager.FrequencyStorageKey)
    }

    private static func loadEnabledTypes() -> Set<MotionDataType> {
        guard let savedTypes = UserDefaults.standard.data(forKey: SettingsManager.EnabledTypesStorageKey) else {
            logger.warning("No saved types found. Defaulting to all types.")

            return Set(MotionDataType.allCases)
        }

        return Set((try? jsonDecoder.decode([MotionDataType].self, from: savedTypes)) ?? MotionDataType.allCases)
    }

    private static func loadFrequency() -> Int {
        let savedValue = UserDefaults.standard.integer(forKey: SettingsManager.FrequencyStorageKey)

        return savedValue == 0 ? DefaultFrequencyHzValue : savedValue
    }
}
