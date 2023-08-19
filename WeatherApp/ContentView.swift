//
//  ContentView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var locationManager = LocationManager()
    @StateObject var weatherDataManager = WeatherDataManager()

    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("Hello, world!\(location.coordinate.latitude), \(location.coordinate.longitude)")
            }  else {
                Text("error")
            }
            Button("Fetch weather") {
                weatherDataManager.fetchData(forLocation: locationManager.location!)
            }
        }
        .onAppear {
            locationManager.requstLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
