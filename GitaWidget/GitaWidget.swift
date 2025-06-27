//
//  GitaWidget.swift
//  GitaWidget
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: QuoteService.shared.getRandomQuote())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quote: QuoteService.shared.getRandomQuote())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: QuoteService.shared.getRandomQuote())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: Quote
}

struct GitaWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .leading, spacing: family == .systemSmall ? 8 : 12) {
            Text(entry.quote.text)
                .font(.system(size: family == .systemSmall ? 12 : 14, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .minimumScaleFactor(0.8)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("— " + entry.quote.attribution)
                    .font(.system(size: family == .systemSmall ? 10 : 12, weight: .regular))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding(family == .systemSmall ? 12 : 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Bhagavad Gita quote: \(entry.quote.text). From \(entry.quote.attribution)")
    }
}

struct GitaWidget: Widget {
    let kind: String = "GitaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GitaWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Gita Wisdom")
        .description("Daily wisdom from the Bhagavad Gita")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "You have the right to perform your prescribed duty, but you are not entitled to the fruits of action.", chapter: 2, verse: 47))
    SimpleEntry(date: .now, quote: Quote(text: "As a person puts on new garments, giving up old ones, the soul similarly accepts new material bodies.", chapter: 2, verse: 22))
}

#Preview(as: .systemMedium) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "You have the right to perform your prescribed duty, but you are not entitled to the fruits of action.", chapter: 2, verse: 47))
    SimpleEntry(date: .now, quote: Quote(text: "For the soul there is neither birth nor death. It is not slain when the body is slain.", chapter: 2, verse: 20))
}
