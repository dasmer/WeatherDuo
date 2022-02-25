import Foundation

class WeatherViewModel: ObservableObject {
    let stubbed: Bool
    @Published private(set) var model: WeatherModel?

    private let client = OpenWeatherClient()

    init(stubbed: Bool = false) {
        self.stubbed = stubbed
        if stubbed {
            model = WeatherModel.stubbedModel
        }
    }

    @MainActor
    func loadWeatherAtLocation(coordinate: LocationCoordinate) async {
        if stubbed {
            return
        }
        model = nil
        guard let response = await client.loadCurrentWeather(coordinate: coordinate),
              let weather = response.weather.first else { return }

            model = WeatherModel(temperature: Temperature(kelvin: response.main.temp),
                                 feelsLike: Temperature(kelvin: response.main.feelsLike),
                                 city: response.name,
                                 title: weather.main,
                                 description: weather.description,
                                 iconName: weather.icon,
                                 lastUpdateDate: Date(timeIntervalSince1970: TimeInterval(response.dt)))
    }
}
