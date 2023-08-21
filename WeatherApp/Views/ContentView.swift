//
//  ContentView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = WeatherViewModel()


    var body: some View {
        VStack {
            Button("Fetch weather") {
                print(viewModel.temperature)
            }
        }
        .onAppear{
            viewModel.requestLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
