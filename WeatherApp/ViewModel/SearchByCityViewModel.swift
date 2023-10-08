//
//  SearchByCityViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 7.09.23.
//

import Foundation

class SearchByCityViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var tempMax: String = "-"
    @Published var tempMin: String = "-"
    @Published var weatherIcon: String = Icons.defaultIcon
    @Published var isDataAlreadyAdded: Bool = false
    @Published var weatherData: CityNameWeatherData?
    @Published var cityWeatherData: [CityWeather] = []
    private let coreDataManager = CoreDataManager()
    private let weatherDataManager = WeatherDataManager()

    func fetchWeatherData() {
        let existingCities = coreDataManager.getAllCity()
        isDataAlreadyAdded = existingCities.contains { city in
            city.cityName == cityName
        }
        weatherDataManager.cityNameDaysWeather(forCity: cityName) { [weak self] data in
            DispatchQueue.main.async {
                self?.tempMax = ("\(data?.list.first?.temp.max.roundDouble() ?? "")°")
                self?.tempMin = ("\(data?.list.first?.temp.min.roundDouble() ?? "")°")
                self?.weatherIcon = Icons.icons[data?.list.first?.weather.first?.main ?? ""] ?? Icons.defaultIcon
            }
        }
    }

    func getAllCityData() -> [CityWeather] {
        return coreDataManager.getAllCity().reversed()
    }

    func deleteCity(city: CityWeather) {
        coreDataManager.deleteCity(city: city)
    }
    // Обнуляем данные в текстовом поле
    func resetCityName() {
        cityName = ""
    }

    func saveData() {
        coreDataManager.saveCityWeather(cityName: cityName,
                                        tempMax: tempMax,
                                        tempMin: tempMin,
                                        weatherIcon: weatherIcon)
    }
}
