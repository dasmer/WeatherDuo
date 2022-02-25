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
                    Text(model.title)
                }
            } else {
                ProgressView()
            }
        }.task {
            let coordinate = LocationCoordinate(latitude: 40.7812, longitude: -73.9665)
            await weatherViewModel.loadWeatherAtLocation(coordinate: coordinate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherViewModel: WeatherViewModel(stubbed: true))
    }
}
