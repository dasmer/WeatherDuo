import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    private var weatherViewModel = WeatherViewModel()

    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), model: WeatherModel.stubbedModel)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), model: WeatherModel.stubbedModel)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [SimpleEntry] = []
            var policy = TimelineReloadPolicy.atEnd
            await weatherViewModel.loadWeatherAtLocation(coordinate: ManhattanCoordinate)

            if let model = weatherViewModel.model {
                entries.append(SimpleEntry(date: Date(), model: model))
                let nextUpdateDate = model.lastUpdateDate.addingTimeInterval(30 * 60)
                policy = .after(nextUpdateDate)
            }

            let timeline = Timeline(entries: entries , policy: policy)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let model: WeatherModel
}

struct Weather_Duo_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.model.city)
            HStack {
                Spacer().overlay (
                VStack {
                    Text("°C")
                    Text(entry.model.temperature.celsiusString).bold()
                }
                )
                Image(entry.model.iconName)
                Spacer().overlay (
                    VStack {
                        Text("°F")
                        Text(entry.model.temperature.fahrenheitString).bold()
                    }
                )
            }
            Text(entry.model.title)
        }
    }
}

@main
struct Weather_Duo_Widget: Widget {
    let kind: String = "Weather_Duo_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Weather_Duo_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Weather_Duo_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Weather_Duo_WidgetEntryView(entry: SimpleEntry(date: Date(), model: WeatherModel.stubbedModel))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
