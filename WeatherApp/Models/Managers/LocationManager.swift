//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    // Current location. The property is observable and will update the value when changed.
    @Published var location: CLLocation?
    override init() {
        super.init()
        manager.delegate = self
    }
    // Request permission to use the location.
    func requstLocation() {
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.startUpdatingLocation()
    }
    // When location updating, the delegate method saves the location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        manager.stopUpdatingLocation()
    }
    // Some error.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
