import Foundation

struct WeatherModel {

    let temperature: Temperature
    let feelsLike: Temperature
    let humidity: Int
    let city: String
    let title: String
    let description: String
    let iconName: String
    let lastUpdateDate: Date
}

extension WeatherModel {

    static var stubbedModel: WeatherModel {
        WeatherModel(temperature: Temperature(kelvin: 254.29),
                     feelsLike: Temperature(kelvin: 251.29),
                     humidity: 70,
                     city: "Jericho",
                     title: "Mist",
                     description: "mist",
                     iconName: "50n",
                     lastUpdateDate: Date())
    }
}
