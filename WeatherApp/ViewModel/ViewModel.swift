//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 21.08.23.
//

import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    private let locationManager = LocationManager()
    private let weatherDataManager = WeatherDataManager()
    private var cancellables: Set<AnyCancellable> = []

    @Published var temperature: String = "-"

    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.fetchWeatherData(forLocation: location)
            }
            .store(in: &cancellables)
    }

    func requestLocation() {
        locationManager.requstLocation()
    }

    private func fetchWeatherData(forLocation location: CLLocation) {
        weatherDataManager.fetchData(forLocation: location) { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.temperature = "\(weatherData.main.temp)" 
            }
        }
    }
}

