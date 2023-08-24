//
//  SevenDaysScroll.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import SwiftUI

struct SevenDaysScroll: View {

    @ObservedObject private var sevenDaysViewModel = SevenDaysViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(sevenDaysViewModel.weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .cornerRadius(10)

                }
            }
        }
    }
}

struct SevenDaysScroll_Previews: PreviewProvider {
    static var previews: some View {
        SevenDaysScroll()
    }
}
