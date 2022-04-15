//
//  Downloader.swift
//  NatureRemoAnalytics
//
//  Created by 齋藤健悟 on 2022/04/15.
//

import Foundation
import Combine

struct NatureDataLoader {
    let url = URL(string: "https://api.nature.global/1/devices")!
    
    let headers = {
        ["Content-Type" : "application/json",
         "Authorization": "Bearer " + natureRemoAPIKey]
    }()
    
    func publish() -> AnyPublisher<Devices, Error> {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Devices.self, decoder: JSONDecoder())
            .first()
            .eraseToAnyPublisher()
    }
}


struct WeatherDataLoader {
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Yono,JP&appid=\(weatherAPIKey)&lang=ja&units=metric")!
    let headers = {
        ["Content-Type" : "application/json"]
    }()
    
    func publish() -> AnyPublisher<Weather, Error> {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Weather.self, decoder: JSONDecoder())
            .first()
            .eraseToAnyPublisher()
    }
}
