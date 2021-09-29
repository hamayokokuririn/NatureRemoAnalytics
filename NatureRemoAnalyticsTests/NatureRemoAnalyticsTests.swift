//
//  NatureRemoAnalyticsTests.swift
//  NatureRemoAnalyticsTests
//
//  Created by 齋藤健悟 on 2020/08/08.
//

import XCTest
@testable import NatureRemoAnalytics

class NatureRemoAnalyticsTests: XCTestCase {

    let json = """
    [{"name":"Remo","id":"33ccf92e-88ff-4f07-9bf0-32ffc905ab8a","created_at":"2020-07-30T13:37:50Z","updated_at":"2020-08-08T03:00:20Z","mac_address":"f0:08:d1:6b:f0:a8","bt_mac_address":"f0:08:d1:6b:f0:aa","serial_number":"1W320060015940","firmware_version":"Remo/1.0.23","temperature_offset":0,"humidity_offset":0,"users":[{"id":"1f8bc59f-1c28-44b7-8b17-bb0ccd6af6e2","nickname":"齋藤健悟","superuser":true}],"newest_events":{"hu":{"val":70,"created_at":"2020-08-08T07:06:18Z"},"il":{"val":22,"created_at":"2020-08-08T07:04:50Z"},"mo":{"val":1,"created_at":"2020-08-08T05:20:43Z"},"te":{"val":27.072632,"created_at":"2020-08-08T07:04:18Z"}}}]
    """.data(using: .utf8)!

    
    struct NameElement: Decodable {
        let name: String
    }
    
    typealias Name = [NameElement]
    
    func testDecode() {
        let jsonDecoder = JSONDecoder()
        do {
            let devices = try jsonDecoder.decode(Devices.self,
                                                 from: json)
            let name = devices.first!.name
            XCTAssertEqual(name, "Remo")
        } catch {
            XCTAssertTrue(false)
        }
    }


}

class WeatherLoadTests: XCTestCase {

    let json = """
    {
    "coord": {
    "lon": 139.63,
    "lat": 35.88
    },
    "weather": [
    {
    "id": 804,
    "main": "Clouds",
    "description": "厚い雲",
    "icon": "04n"
    }
    ],
    base: "stations",
    main: {
    temp: 17.76,
    feels_like: 12.62,
    temp_min: 17.22,
    temp_max: 18.89,
    pressure: 997,
    humidity: 26
    },
    visibility: 10000,
    wind: {
    speed: 4.12,
    deg: 332
    },
    clouds: {
    all: 94
    },
    dt: 1603463474,
    sys: {
    type: 3,
    id: 48377,
    country: "JP",
    sunrise: 1603400104,
    sunset: 1603439776
    },
    timezone: 32400,
    id: 1848254,
    name: "Yono",
    cod: 200
    }
    """.data(using: .utf8)!

    
    struct NameElement: Decodable {
        let name: String
    }
    
    typealias Name = [NameElement]
    
    func testDecode() {
        let jsonDecoder = JSONDecoder()
        do {
            let devices = try jsonDecoder.decode(Devices.self,
                                                 from: json)
            let name = devices.first!.name
            XCTAssertEqual(name, "Remo")
        } catch {
            XCTAssertTrue(false)
        }
    }


}
