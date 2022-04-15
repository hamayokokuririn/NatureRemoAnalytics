//
//  ViewController.swift
//  NatureRemoAnalytics
//
//  Created by 齋藤健悟 on 2020/08/08.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var natureStatus: UILabel!
    @IBOutlet weak var natureTemp: UILabel!
    @IBOutlet weak var natureHumid: UILabel!
    
    @IBAction func didPushNatureReload(_ sender: UIButton) {
        natureLoad()
    }
    
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var weatherHumid: UILabel!
    
    // DI用のinitializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func didPushWeatherReload() {
        weatherLoad()
    }
    
    let natureLoader = NatureDataLoader()
    let weatherLoader = WeatherDataLoader()
    var cancellables: Set<AnyCancellable> = []
    
    fileprivate func natureLoad() {
        natureLoader.publish()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                
                case .finished:
                    print("finish")
                case .failure(let e):
                    self.errorText(e.localizedDescription)
                }
            }, receiveValue: { devices in
                
                let temp = devices.first!.newestEvents.te.val.description
                let mois = devices.first!.newestEvents.hu.val.description
                self.setText(temp: temp, mois: mois, updateDate: self.updateDate(string: devices.first!.newestEvents.te.createdAt))
            })
            .store(in: &cancellables)
    }
    
    fileprivate func weatherLoad() {
        weatherLoader.publish()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                
                case .finished:
                    print("weather finish")
                case .failure(let e):
                    self.errorText(e.localizedDescription)
                }
            }, receiveValue: { weather in
                self.weather.text = weather.weather.first!.main
                self.weatherTemp.text = weather.main.temp.description + "℃"
                self.weatherHumid.text = weather.main.humidity.description + "%"
                self.weatherStatus.text = self.updateDate(fromDt: TimeInterval(weather.dt)) + "時点"
            })
            .store(in: &cancellables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        natureStatus.text = "loading..."
        
        natureLoad()
        weatherLoad()
    }
    
    private func failureText(statusCode: Int) {
        DispatchQueue.main.async {
            self.natureStatus.text = "Status Code: " + statusCode.description
            self.natureStatus.sizeToFit()
        }
    }
    
    private func errorText(_ text: String) {
        DispatchQueue.main.async {
            self.natureStatus.text = "error text: " + text
            self.natureStatus.sizeToFit()
        }
    }

    private func setText(temp: String, mois: String, updateDate: String) {
        DispatchQueue.main.async {
            self.natureTemp.text = temp + "℃"
            self.natureTemp.sizeToFit()
            
            self.natureHumid.text = mois + "%"
            self.natureHumid.sizeToFit()
            
            self.natureStatus.text = updateDate + "時点"
            self.natureStatus.sizeToFit()
        }
    }
    
    
    private func updateDate(string: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: string)!
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func updateDate(fromDt: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: fromDt)
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

