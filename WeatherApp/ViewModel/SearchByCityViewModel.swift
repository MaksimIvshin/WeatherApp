//
//  SearchByCityViewModel.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 7.09.23.
//

import Foundation

class SearchByCityViewModel: ObservableObject {
    // Published properties that will be tracked.
    @Published var cityName: String = ""
    @Published var tempMax: String = "-"
    @Published var tempMin: String = "-"
    @Published var weatherIcon: String = Icons.defaultIcon
    @Published var isDataAlreadyAdded: Bool = false
    @Published var weatherData: CityNameWeatherData?
    @Published var cityWeatherData: [CityWeather] = []
    private let coreDataManager = CoreDataManager()
    private let weatherDataManager = WeatherDataManager()
    // Get weather data.
    func fetchWeatherData() {
        // Get existing cities from CoreData.
        let existingCities = coreDataManager.getAllCity()
        // Check if the list of existing cities contains the entered city.
        isDataAlreadyAdded = existingCities.contains { city in
            city.cityName == cityName
        }
        // Request weather data by the entered city.
        weatherDataManager.cityNameDaysWeather(forCity: cityName) { [weak self] data in
            DispatchQueue.main.async {
                self?.tempMax = ("\(data?.list.first?.temp.max.roundDouble() ?? "")°")
                self?.tempMin = ("\(data?.list.first?.temp.min.roundDouble() ?? "")°")
                self?.weatherIcon = Icons.icons[data?.list.first?.weather.first?.main ?? ""] ?? Icons.defaultIcon
                //  Update weather data in CoreData.
                self?.updateCityWeatherData()
            }
        }
    }
    // Update weather data in CoreData.
    func updateCityWeatherData() {
        let existingCities = coreDataManager.getAllCity()
        // Create a DispatchGroup to wait for all async requests to complete.
        let dispatchGroup = DispatchGroup()
        existingCities.forEach { existingCity in
            dispatchGroup.enter()
            weatherDataManager.cityNameDaysWeather(forCity: existingCity.cityName ?? "") { [weak self] data in
                DispatchQueue.main.async {
                    existingCity.tempMax = data?.list.first?.temp.max.roundDouble() ?? ""
                    existingCity.tempMin = data?.list.first?.temp.min.roundDouble() ?? ""
                    existingCity.weatherIcon = Icons.icons[data?.list.first?.weather.first?.main ?? ""] ?? Icons.defaultIcon
                    self?.coreDataManager.saveContextIfChange()
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.objectWillChange.send()
        }
    }
    // Getting all city weather data.
    func getAllCityData() -> [CityWeather] {
        return coreDataManager.getAllCity().reversed()
    }
    // Removing the city from CoreData.
    func deleteCity(city: CityWeather) {
        coreDataManager.deleteCity(city: city)
    }
    // Reset the value of the entered city.
    func resetCityName() {
        cityName = ""
    }
    // Saving weather data to CoreData.
    func saveData() {
        coreDataManager.saveCityWeather(cityName: cityName,
                                        tempMax: tempMax,
                                        tempMin: tempMin,
                                        weatherIcon: weatherIcon)
    }
}
