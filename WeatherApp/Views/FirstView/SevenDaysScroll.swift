////
////  SevenDaysScroll.swift
////  WeatherApp
////
////  Created by Maks Ivshin on 24.08.23.
////
//
//import SwiftUI
//
//struct SevenDaysScroll: View {
//
//    @ObservedObject var sevenDaysViewModel: SevenDaysViewModel
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyHStack(spacing: 20) {
//                ForEach(1...7, id: \.self) { weekday in
//                    VStack {
//                        Text("\(sevenDaysViewModel.date)")
//                        Text("\(sevenDaysViewModel.temperature)")
//                        Text("\(sevenDaysViewModel.weatherIcon)")
//
//                    }.padding(5)
//                        .frame(width: 100, height: 100)
//                        .background(Color.blue.opacity(0.5))
//                        .cornerRadius(10)
//                }
//            }
//        }
//        .padding(.horizontal, 30)
//
//
//        .onAppear{
//            sevenDaysViewModel.requestLocation()
//            print(sevenDaysViewModel.date)
//        }
//    }
//}
//
//struct SevenDaysScroll_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        SevenDaysScroll(sevenDaysViewModel: SevenDaysViewModel())
//    }
//}
