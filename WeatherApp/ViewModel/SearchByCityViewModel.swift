//
//  SearchByCityViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 7.09.23.
//

import Foundation

class SearchByCityViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var tempDay: String = "-"
    @Published var tempNight: String = "-"
    @Published var weatherData: CityNameWeatherData?
    let weatherDataManager = WeatherDataManager()

    func fetchWeatherData() {
        weatherDataManager.cityNameDaysWeather(forCity: cityName) { [weak self] data in
            DispatchQueue.main.async {
                self?.weatherData = data
                self?.tempDay = "\(data?.list.first?.temp.day ?? 0)"
            }
        }
    }
}
