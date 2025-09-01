//
//  MotionDataTypes.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/16/25.
//

enum MotionDataType: String, CaseIterable, Codable {
    case rotationRateX = "Rotation Rate x"
    case rotationRateY = "Rotation Rate y"
    case rotationRateZ = "Rotation Rate z"
    case userAccelerationX = "User Acceleration x"
    case userAccelerationY = "User Acceleration y"
    case userAccelerationZ = "User Acceleration z"
    case accelerationX = "Acceleration x"
    case accelerationY = "Acceleration y"
    case accelerationZ = "Acceleration z"
    case gravityX = "Gravity x"
    case gravityY = "Gravity y"
    case gravityZ = "Gravity z"
    case attitudeRoll = "Attitude Roll"
    case attitudePitch = "Attitude Pitch"
    case attitudeYaw = "Attitude Yaw"
    case heading = "Heading"
}
