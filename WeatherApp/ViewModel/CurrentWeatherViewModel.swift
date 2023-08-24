//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 21.08.23.
//

import Foundation
import CoreLocation
import Combine

class CurrentWeatherViewModel: ObservableObject {
    let locationManager = LocationManager()
    let weatherDataManager = WeatherDataManager()
    var cancellables: Set<AnyCancellable> = []
    @Published var temperature: String = "-"
    @Published var city: String = "-"
    @Published var country: String = "-"
    @Published var description: String = "-"
    @Published var weatherIcon: String = Icons.defaultIcon

    //    init() {
    //        locationManager.$location
    //            .compactMap { $0 }
    //            .sink { [weak self] location in
    //                self?.fetchWeatherData(forLocation: location)
    //                self?.fetchWeatherData2(forLocation: location)
    //            }
    //            .store(in: &cancellables)
    //    }

    func requestLocation() {
        locationManager.requstLocation()
    }

    func currentFetchWeather(forLocation location: CLLocation) {
        weatherDataManager.fetchCurrentWeather(forLocation: location) { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.temperature = "\(weatherData?.main.temp.roundDouble() ?? "")°"
                self?.city = "\(weatherData?.name ?? "") \(weatherData?.sys.country ?? "")"
                self?.country = weatherData?.sys.country ?? ""
                self?.description = weatherData?.weather.first?.description.capitalized ?? ""
                self?.weatherIcon = Icons.icons[weatherData?.weather.first?.main ?? ""] ?? Icons.defaultIcon
            }
        }
    }
}
