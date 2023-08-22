//
//  WeatherDataManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import Foundation
import CoreLocation

//protocol Networking {
//    func request(
//                 forLocation location: CLLocation,
//                 complition: @escaping (Data?, Error?) -> Void
//    )
//    func request2(
//                 forLocation location: CLLocation,
//                 complition: @escaping (Data?, Error?) -> Void
//    )
//}

class WeatherDataManager: ObservableObject {
    let apiKey = "b5a50c398a579b44871a884663a2845a"

    func fetchCurrentWeather(forLocation location: CLLocation, compltion: @escaping ((WeatherData)->Void)) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                compltion(weather)
            } else {
                print(String(describing: error?.localizedDescription))
            }
        }.resume()
    }

    func fetchFiveDaysWeather(forLocation location: CLLocation, compltion: @escaping ((WeatherData)->Void)) {
        let urlString = "api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                compltion(weather)
            } else {
                print(String(describing: error?.localizedDescription))
            }
        }.resume()
    }
}
