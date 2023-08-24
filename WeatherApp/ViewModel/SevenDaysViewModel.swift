//
//  SevenDaysViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation
import CoreLocation

class SevenDaysViewModel: ObservableObject {
    let locationManager = LocationManager()
    let weatherDataManager = WeatherDataManager()
    @Published var date: String = "-"
    @Published var weatherIcon: String = Icons.defaultIcon
    @Published var weekdays: [String] = ["Mon", "Thu", "Wed", "Thut", "Fri", "Sat", "Sun"]





    func sevenDaysFetchWeather(forLocation location: CLLocation) {
        weatherDataManager.fetchSevenDaysWeather(forLocation: location) { [weak self] weatherData in
            DispatchQueue.main.async {
               
                self?.date = "\(weatherData?.list.first?.dt ?? 0)"
                if let newDate = weatherData?.list[2].dt {
                    self?.date = Date.formattedDate(timestamp: newDate)
                } else {
                    self?.date = "-"
                }
            }
        }
    }
}
