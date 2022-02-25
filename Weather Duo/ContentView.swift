import SwiftUI

struct ContentView: View {

    @ObservedObject var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack {
            if let model = weatherViewModel.model {
                Spacer()
                Text("Current temperature: \(model.temperature.fahrenheitString)°F")
                Text("Feels like: \(model.feelsLike.fahrenheitString)°F")
                Text("Humidity: \(model.humidity)%")
                Text("City: \(model.city)")
                Text("Title: \(model.title)")
                Text("Description: \(model.description)")
                Spacer()
                Text("Last updated:\n\(model.lastUpdateDate)").multilineTextAlignment(.center)
            } else {
                 ProgressView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherViewModel: WeatherViewModel(stubbed: true))
    }
}
