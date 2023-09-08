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
    //Массив для хранения подписок. Хранит подписки на изменения location.
    var cancellables: Set<AnyCancellable> = []
    //Данные о погоде будут автоматически обновляться при изменении значений.
    @Published var weatherData: [List] = []
    //Метод иницилизации класса
    init() {
        //Отслеживаем изменения свойства location. Удаляем все значения nil. Устанавливаем подписку на изменения данных. Сохраняем подписки.
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.sevenDaysFetchWeather(forLocation: location)
            }
            .store(in: &cancellables)
    }
    //Метод запроса местоположения.
    func requestLocation() {
        locationManager.requstLocation()
    }
    //Метод для получения данных о погоде.
    func sevenDaysFetchWeather(forLocation location: CLLocation) {
        weatherDataManager.fetchSevenDaysWeather(forLocation: location) { [weak self] weatherData in
            //Полученные данные будут присвоены weatherData и обновлены на главной очереди (т.к. UI).
            DispatchQueue.main.async {
                self?.weatherData = weatherData?.list ?? []
            }
        }
    }
}
