//
//  MotionManager.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 5/18/25.
//

import CoreMotion

@Observable class MotionDataCollector {
    private(set) var isError: Bool
    private(set) var isCollectingData: Bool

    private let motionManager = CMMotionManager()

    init() {
        self.isError = !motionManager.isDeviceMotionAvailable
        self.isCollectingData = false
    }

    func recordMotionData(freq: Double, typesToRecord: Set<MotionDataType>) {
        if self.isError {
            logger.error("Error collecting motion data - will not continue")
            return
        }

        let sortedTypesToRecord = typesToRecord.sorted { $0.rawValue < $1.rawValue }

        let typeHeaders = sortedTypesToRecord.map(\.rawValue).joined(separator: ",")

        print("Timestamp,\(typeHeaders),Label")

        self.isCollectingData = true

        motionManager.deviceMotionUpdateInterval = freq
        motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: .main) { data, error in
            if error != nil {
                logger.error("Error: \(String(describing: error))")
                self.isError = true
                return
            }

            guard let motion = data else {
                logger.warning("No motion data available")
                return
            }

            let rotationRate = motion.rotationRate
            let userAcceleration = motion.userAcceleration
            let attitude = motion.attitude
            let gravity = motion.gravity
            let heading = motion.heading

            let typesToData: [MotionDataType: Double] = [
                .rotationRateX: rotationRate.x,
                .rotationRateY: rotationRate.y,
                .rotationRateZ: rotationRate.z,
                .userAccelerationX: userAcceleration.x,
                .userAccelerationY: userAcceleration.y,
                .userAccelerationZ: userAcceleration.z,
                .accelerationX: userAcceleration.x + gravity.x,
                .accelerationY: userAcceleration.y + gravity.y,
                .accelerationZ: userAcceleration.z + gravity.z,
                .gravityX: gravity.x,
                .gravityY: gravity.y,
                .gravityZ: gravity.z,
                .attitudeRoll: attitude.roll,
                .attitudePitch: attitude.pitch,
                .attitudeYaw: attitude.yaw,
                .heading: heading
            ]

            let dataToOutput = sortedTypesToRecord.map { String(typesToData[$0]!) }.joined(separator: ",") // Assume all are present in the typesToData dict

            print("\(Date().timeIntervalSince1970),\(dataToOutput)")
        }
    }

    func stopMotionData() {
        motionManager.stopDeviceMotionUpdates()
        self.isCollectingData = false
    }
}
