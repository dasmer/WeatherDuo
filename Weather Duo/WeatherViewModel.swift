import Foundation


class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel?

    private let client = OpenWeatherClient()

    @MainActor
    func loadWeatherAtLocation(coordinate: LocationCoordinate) async {
        guard let response = await client.loadCurrentWeather(coordinate: coordinate),
              let weather = response.weather.first else { return }

        model = WeatherModel(kelvinTemperature: response.main.temp,
                             city: response.name,
                             title: weather.main,
                             description: weather.description,
                             iconName: weather.icon,
                             lastUpdateDate: Date(timeIntervalSince1970: TimeInterval(response.dt)))
    }
}
