//
//  Response.swift
//  NatureRemoAnalytics
//
//  Created by 齋藤健悟 on 2020/08/08.
//

import Foundation

// MARK: - WelcomeElement
struct DeviceElement: Codable {
    let name, id: String
    let createdAt, updatedAt: String
    let macAddress, btMACAddress, serialNumber, firmwareVersion: String
    let temperatureOffset, humidityOffset: Int
    let users: [User]
    let newestEvents: NewestEvents

    enum CodingKeys: String, CodingKey {
        case name, id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case macAddress = "mac_address"
        case btMACAddress = "bt_mac_address"
        case serialNumber = "serial_number"
        case firmwareVersion = "firmware_version"
        case temperatureOffset = "temperature_offset"
        case humidityOffset = "humidity_offset"
        case users
        case newestEvents = "newest_events"
    }
}

// MARK: - NewestEvents
struct NewestEvents: Codable {
    let hu, il, mo, te: Hu
}

// MARK: - Hu
struct Hu: Codable {
    let val: Double
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case val
        case createdAt = "created_at"
    }
}

// MARK: - User
struct User: Codable {
    let id, nickname: String
    let superuser: Bool
}

typealias Devices = [DeviceElement]
