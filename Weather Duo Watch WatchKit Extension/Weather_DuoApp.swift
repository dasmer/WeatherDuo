//
//  Weather_DuoApp.swift
//  Weather Duo Watch WatchKit Extension
//
//  Created by Dasmer Singh on 2/24/22.
//

import SwiftUI

@main
struct Weather_DuoApp: App {

    @Environment(\.scenePhase) private var scenePhase

    private var viewModel: WeatherViewModel = {
        WeatherViewModel()
    }()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(weatherViewModel: viewModel)
            }
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                Task {
                    let coordinate = LocationCoordinate(latitude: 40.7812, longitude: -73.9665)
                    await viewModel.loadWeatherAtLocation(coordinate: coordinate)
                }
            case .inactive: break
            case .background: break
            @unknown default: assert(false, "New scene phase value")
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
