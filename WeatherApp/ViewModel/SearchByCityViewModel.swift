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
    @Published var isDataAlreadyAdded: Bool = false
    @Published var dataArray: [String] = []
    @Published var weatherData: CityNameWeatherData?
    let weatherDataManager = WeatherDataManager()
    
    func fetchWeatherData() {
        isDataAlreadyAdded = dataArray.contains {
            $0.contains("City: \(cityName)")
        }
        weatherDataManager.cityNameDaysWeather(forCity: cityName) { [weak self] data in
            DispatchQueue.main.async {
                self?.tempMax = data?.list.first?.temp.max.roundDouble() ?? ""
                self?.tempMin = data?.list.first?.temp.min.roundDouble() ?? ""
            }
        }
    }

    func fetchWeatherDataForCities() {
        for (index, data) in dataArray.enumerated() {
            let components = data.components(separatedBy: ", ")
            if components.count == 2 {
                let cityName = components[0].replacingOccurrences(of: "City: ", with: "")
                let temperature = components[1].replacingOccurrences(of: "Temperature: ", with: "")
                weatherDataManager.cityNameDaysWeather(forCity: cityName) { [weak self] weatherData in
                    let tempDay = weatherData?.list.first?.temp.max.roundDouble() ?? ""
                    if temperature != tempDay {
                        let newData = "City: \(cityName), Temperature: \(tempDay)"
                        DispatchQueue.main.async {
                            self?.dataArray[index] = newData
                        }
                    }
                }
            }
        }
    }

    // Обнуляем данные в текстовом поле
    func resetCityName() {
        cityName = ""
    }

    func addDataToSet() {
        let newData = "City: \(cityName), Temperature: \(tempMax)"
        if !dataArray.contains(newData) {
            dataArray.append(newData)
        } else {
            isDataAlreadyAdded = true
        }
    }
}
