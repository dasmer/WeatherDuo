//
//  ContentView.swift
//  Weather Duo Watch WatchKit Extension
//
//  Created by Dasmer Singh on 2/24/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack {
            if let model = weatherViewModel.model {
                VStack {
                    Text(model.city)
                    Spacer()
                    HStack {
                        Spacer().overlay (
                            VStack {
                                Text("°C")
                                Text(model.temperature.celsiusString).bold()
                            }
                        )
                        Image(model.iconName)
                        Spacer().overlay (
                            VStack {
                                Text("°F")
                                Text(model.temperature.fahrenheitString).bold()
                            }
                        )
                    }
                    Spacer()
                    Text(model.title)
                }.padding()
            } else {
                ProgressView()
            }
        }.task {
            await weatherViewModel.loadWeatherAtLocation(coordinate: ManhattanCoordinate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherViewModel: WeatherViewModel(stubbed: true))
    }
}
