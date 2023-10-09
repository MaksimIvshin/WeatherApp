//
//  SevenDaysViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation
import CoreLocation
import Combine

class SevenDaysViewModel: ObservableObject {
    let locationManager = LocationManager()
    let weatherDataManager = WeatherDataManager()
    // Array for storing subscriptions. Stores subscriptions to location changes.
    var cancellables: Set<AnyCancellable> = []
    // Weather data will be automatically updated when values change.
    @Published var weatherData: [List] = []
    // Initialization and binding.
    init() {
        // Track the location. Remove all nil values. Set up a subscription to data changes. Save subscriptions.
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.sevenDaysFetchWeather(forLocation: location)
            }
            .store(in: &cancellables)
    }
    // Requesting a location.
    func requestLocation() {
        locationManager.requstLocation()
    }
    // Request weather data by the location for 7 days.
    func sevenDaysFetchWeather(forLocation location: CLLocation) {
        weatherDataManager.fetchSevenDaysWeather(forLocation: location) { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.weatherData = weatherData?.list ?? []
            }
        }
    }
}
