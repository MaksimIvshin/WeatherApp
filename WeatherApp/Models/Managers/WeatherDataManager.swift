//
//  WeatheManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
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
    let apiKeyForFiveDays = "ed60fcfbd110ee65c7150605ea8aceea"


    func fetchCurrentWeather(forLocation location: CLLocation, compltion: @escaping (CurrentWeatherData?)->Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            compltion (nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            let weather = try? JSONDecoder().decode(CurrentWeatherData.self, from: data)
            if let weather = weather {
                compltion(weather)
                //print(weather)
                //проверить почему вызывется 4 раза
            } else {
                compltion(nil)
            }
        }.resume()
    }

    func fetchSevenDaysWeather(forLocation location: CLLocation, compltion: @escaping (SevenDaysWeatherData?)->Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&cnt=7&appid=\(apiKeyForFiveDays)&units=metric"
        guard let url = URL(string: urlString) else {
            compltion (nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            let weather = try? JSONDecoder().decode(SevenDaysWeatherData.self, from: data)
            if let weather = weather {
                compltion(weather)
            } else {
                compltion(nil)
            }
        }.resume()
    }
}
