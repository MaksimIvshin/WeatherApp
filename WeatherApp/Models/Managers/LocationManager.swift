//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    //Текущая локация. Cвойство является наблюдаемым и при изменении будет обновлять значение.
    @Published var location: CLLocation?
    override init() {
        super.init()
        manager.delegate = self
    }
    func requstLocation() {
        //Запрашиваем разрешение пользователя на использование локации.
        manager.requestWhenInUseAuthorization()
        //Точность местоположения сто метров.
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //Начало обновления локации.
        manager.startUpdatingLocation()
    }
    //Метод делегата при оновлении локации сохраняет местоположение и останавливает обновление.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        manager.stopUpdatingLocation()
    }
    //Принтуем ошибку.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
