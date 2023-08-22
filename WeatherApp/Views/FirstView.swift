//
//  FirstView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI

struct FirstView: View {

    @StateObject private var viewModel = WeatherViewModel()


    var body: some View {

        ZStack {
            Color.backgroundColorFirstView
            VStack {
                Text("\(viewModel.city)")
                    .font(.largeTitle)

                Text("\(viewModel.temperature)")
                    .font(.system(size: 100))

                Text("\(viewModel.description)")
                Text("\(viewModel.weatherIcon)")
                    .font(.title)
                
                Spacer()
            }
            .padding(.top, 100)
            .foregroundColor(.white)



        }
        .ignoresSafeArea()

        .onAppear{
            viewModel.requestLocation()
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
