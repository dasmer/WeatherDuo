import Foundation

struct WeatherViewModel: Codable {

    let kelvinTemperature: Double
    let city: String
    let title: String
    let description: String
    let iconName: String
}
