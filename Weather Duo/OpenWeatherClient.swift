import Foundation

// Current: api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
// OneCall https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&appid={API key}

struct OpenWeatherClient {
    static fileprivate let apiKey = "334ef71349f357adfe939275033cc49a"

    func loadCurrentWeather(coordinate: LocationCoordinate) async -> CurrentWeatherResponse?  {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(Self.apiKey)")!
        var response: CurrentWeatherResponse? = nil

        if let (data, _) = try? await URLSession.shared.data(from: url),
           let decodedResponse = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data) {
            response = decodedResponse
        }

        return response
    }
}

struct CurrentWeatherResponse: Codable {

    let weather: [Weather]
    let main: Main
    let name: String
    let dt: Int

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
    }
}
