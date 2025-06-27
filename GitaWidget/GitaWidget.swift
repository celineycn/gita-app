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
    
    private var quoteFontSize: CGFloat {
        switch family {
        case .systemSmall:
            return 13
        case .systemMedium:
            return 16
        default:
            return 18
        }
    }
    
    private var sourceFontSize: CGFloat {
        switch family {
        case .systemSmall:
            return 10
        case .systemMedium:
            return 12
        default:
            return 13
        }
    }
    
    private var padding: CGFloat {
        family == .systemSmall ? 16 : 20
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Quote text
            Text(entry.quote.text)
                .font(.custom("Montserrat-Medium", size: quoteFontSize))
                .fontWeight(.medium)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
                .lineLimit(nil)
                .minimumScaleFactor(0.85)
            
            Spacer()
            
            // Source attribution
            HStack {
                Text("Chapter \(entry.quote.chapter) • Verse \(entry.quote.verse)")
                    .font(.custom("Montserrat-Regular", size: sourceFontSize))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(padding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Bhagavad Gita quote: \(entry.quote.text). From Chapter \(entry.quote.chapter), Verse \(entry.quote.verse)")
    }
}

struct GitaWidget: Widget {
    let kind: String = "GitaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GitaWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    Image("PaperTexture")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
        }
        .configurationDisplayName("Gita Wisdom")
        .description("Daily wisdom from the Bhagavad Gita")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "Be steadfast in yoga, O Arjuna.", chapter: 2, verse: 48))
    SimpleEntry(date: .now, quote: Quote(text: "The mind is restless, turbulent, obstinate and very strong.", chapter: 6, verse: 34))
}

#Preview(as: .systemMedium) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "You have the right to perform your prescribed duty, but you are not entitled to the fruits of action.", chapter: 2, verse: 47))
    SimpleEntry(date: .now, quote: Quote(text: "For the soul there is neither birth nor death. It is not slain when the body is slain.", chapter: 2, verse: 20))
}
