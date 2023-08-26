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
    //Массив для хранения подписок. Хранит подписки на изменения location.
    var cancellables: Set<AnyCancellable> = []
    //Cвойства являются наблюдаемыми и при изменении будут обновляться значения.
    @Published var temperature: String = "-"
    @Published var city: String = "-"
    @Published var country: String = "-"
    @Published var description: String = "-"
    @Published var weatherIcon: String = Icons.defaultIcon
    //Метод иницилизации класса
    init() {
        //Отслеживаем изменения свойства location. Удаляем все значения nil. Устанавливаем подписку на изменения данных. Сохраняем подписки.
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.currentFetchWeather(forLocation: location)
            }
            .store(in: &cancellables)
    }
    //Метод запроса местоположения.
    func requestLocation() {
        locationManager.requstLocation()
    }
    //Метод для получения данных о погоде.
    func currentFetchWeather(forLocation location: CLLocation) {
        weatherDataManager.fetchCurrentWeather(forLocation: location) { [weak self] weatherData in
            DispatchQueue.main.async {
                //Полученные данные будут присвоены свойствам и обновлены на главной очереди (т.к. UI).
                self?.temperature = "\(weatherData?.main.temp.roundDouble() ?? "")°"
                self?.city = "\(weatherData?.name ?? "") \(weatherData?.sys.country ?? "")"
                self?.country = weatherData?.sys.country ?? ""
                self?.description = weatherData?.weather.first?.description.capitalized ?? ""
                self?.weatherIcon = Icons.icons[weatherData?.weather.first?.main ?? ""] ?? Icons.defaultIcon
            }
        }
    }
}
