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
    @Published var location: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requstLocation() {
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
