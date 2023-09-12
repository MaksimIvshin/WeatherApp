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
    @Published var isDataAlreadyAdded: Bool = false
    @Published var dataList: Set<String> = Set()

    @Published var weatherData: CityNameWeatherData?
    let weatherDataManager = WeatherDataManager()
    
    func fetchWeatherData() {
        isDataAlreadyAdded = dataList.contains {
            $0.contains("City: \(cityName)")
        }
        weatherDataManager.cityNameDaysWeather(forCity: cityName) { [weak self] data in
            DispatchQueue.main.async {
                self?.weatherData = data
                self?.tempDay = "\(data?.list.first?.temp.day.roundDouble() ?? "")°"
            }
        }
    }

    func addDataToList() {
        let newData = "City: \(cityName), Temperature: \(tempDay)"
        if !dataList.contains(newData) {
            dataList.insert(newData)
        } else {
            isDataAlreadyAdded = true
        }
    }
}
