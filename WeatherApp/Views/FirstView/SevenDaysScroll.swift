//
//  SevenDaysScroll.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import SwiftUI

struct SevenDaysScroll: View {
    @ObservedObject var sevenDaysViewModel: SevenDaysViewModel
    var body: some View {
        VStack {
            Text("Weather forecast for 7 days")
            ScrollView(.horizontal, showsIndicators: false) {
                //Ленивый стек для меньшей загрузки памяти. Вычисления - по мере отображения на экране.
                LazyHStack(spacing: 20) {
                    //.id для для идентификации элементов в массиве.
                    ForEach(sevenDaysViewModel.weatherData, id: \.dt) { weather in
                        VStack {
                            Date.isToday(date: weather.dt) ? Text("Today") : Text("\(Date.formattedDate(date: weather.dt))")
                            Text("\(weather.temp.day.roundDouble())°")
                            Text("\(Icons.icons[weather.weather.first?.main ?? ""] ?? Icons.defaultIcon )")
                        }
                        .padding(10)
                        .frame(width: 100, height: 100)
                        .background(Color.blue.opacity(0.5))
                        .cornerRadius(10)
                    }
                }
            }
            .frame(maxHeight: 120)
            .padding(.leading, 30)
            .padding(.trailing, 30)
            Spacer()
        }
    }
}

struct SevenDaysScroll_Previews: PreviewProvider {
    static var previews: some View {
        SevenDaysScroll(sevenDaysViewModel: SevenDaysViewModel())
    }
}
