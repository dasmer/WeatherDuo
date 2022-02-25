import Foundation

struct Temperature {
    private let kelvin: Double

    init(kelvin: Double) {
        self.kelvin = kelvin
    }

    var celsiusString: String {
        temperatureString(forTemperature: celsius)
    }

    var fahrenheitString: String {
        temperatureString(forTemperature: fahrenheit)
    }

    // MARK: Private

    private var celsius: Double {
        return kelvin - 273.15
    }

    private var fahrenheit: Double {
        return celsius * 1.8 + 32
    }

    private func temperatureString(forTemperature t: Double) -> String {
        if t > -10.0 && t < 10.0 {
            return String(round(t * 10) / 10.0)
        } else {
            return String(Int(round(t)))
        }
    }
}
