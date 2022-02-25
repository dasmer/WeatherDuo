import Foundation

struct WeatherModel: Codable {

    let kelvinTemperature: Double
    let city: String
    let title: String
    let description: String
    let iconName: String
    let lastUpdateDate: Date

    var celsiusTemperatureString: String {
        temperatureString(forTemperature: celsiusTemperature)
    }

    var fahrenheitTemperatureString: String {
        temperatureString(forTemperature: fahrenheitTemperature)
    }

    var imageURL: URL {
        return URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")!
    }

    private var celsiusTemperature: Double {
        return kelvinTemperature - 273.15
    }

    private var fahrenheitTemperature: Double {
        return celsiusTemperature * 1.8 + 32
    }

    private func temperatureString(forTemperature t: Double) -> String {
        if t > -10.0 && t < 10.0 {
            return String(round(t * 10) / 10.0)
        } else {
            return String(Int(round(t)))
        }
    }
}

extension WeatherModel {

    static var stubbedModel: WeatherModel {
        WeatherModel(kelvinTemperature: 254.29,
                     city: "Jericho",
                     title: "Mist",
                     description: "mist",
                     iconName: "50n",
                     lastUpdateDate: Date())
    }
}
