import SwiftUI
import WidgetKit

@main
struct Weather_DuoApp: App {

    @Environment(\.scenePhase) private var scenePhase

    private var viewModel: WeatherViewModel = {
        WeatherViewModel()
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: viewModel)
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                Task {
                    await viewModel.loadWeatherAtLocation(coordinate: ManhattanCoordinate)
                }
            case .inactive: break
            case .background: WidgetCenter.shared.reloadAllTimelines()
            @unknown default: assert(false, "New scene phase value")
            }
        }

    }
}
