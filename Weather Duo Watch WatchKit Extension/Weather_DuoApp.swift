//
//  Weather_DuoApp.swift
//  Weather Duo Watch WatchKit Extension
//
//  Created by Dasmer Singh on 2/24/22.
//

import SwiftUI

@main
struct Weather_DuoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
