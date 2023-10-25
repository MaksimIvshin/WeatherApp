//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 21.08.23.
//

import Foundation
import CoreLocation
import Combine

final class CurrentWeatherViewModel: ObservableObject {
    private let locationManager = LocationManager()
    private let weatherDataManager = WeatherDataManager()
    // Array for storing subscriptions. Stores subscriptions to location changes.
    private var cancellables: Set<AnyCancellable> = []
    // Published properties that will be tracked.
    @Published var temperature: String = "-"
    @Published var feelsLike: String = "-"
    @Published var windSpeed: String = "-"
    @Published var humidity: String = "-"
    @Published var visibility: String = "-"
    @Published var city: String = "-"
    @Published var country: String = "-"
    @Published var description: String = "-"
    @Published var weatherIcon: String = Icons.defaultIcon
    // Initialization and binding.
    init() {
        // Track the location. Remove all nil values. Set up a subscription to data changes. Save subscriptions.
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.currentFetchWeather(forLocation: location)
            }
            .store(in: &cancellables)
    }
    // Requesting a location.
    func requestLocation() {
        locationManager.requstLocation()
    }
    // Request current weather data.
    private func currentFetchWeather(forLocation location: CLLocation) {
        weatherDataManager.fetchCurrentWeather(forLocation: location) { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.city = "\(weatherData?.name ?? "") \(weatherData?.sys.country ?? "")"
                self?.temperature = "\(weatherData?.main.temp.roundDouble() ?? "")°"
                self?.description = weatherData?.weather.first?.description.capitalized ?? ""
                self?.weatherIcon = Icons.icons[weatherData?.weather.first?.main ?? ""] ?? Icons.defaultIcon
                self?.feelsLike = "\(weatherData?.main.feels_like.roundDouble() ?? "")°"
                self?.windSpeed = "\(weatherData?.wind.speed.roundDouble() ?? "") km/h"
                self?.humidity = "\(weatherData?.main.humidity ?? 0) %"
                self?.visibility = "\(weatherData?.visibility.metersToKilometrs() ?? 0) km"
            }
        }
    }
}
