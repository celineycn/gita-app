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
            return 18
        case .systemMedium:
            return 22
        default:
            return 24
        }
    }
    
    private var sourceFontSize: CGFloat {
        switch family {
        case .systemSmall:
            return 12
        case .systemMedium:
            return 14
        default:
            return 15
        }
    }
    
    private var padding: CGFloat {
        family == .systemSmall ? 12 : 16
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Quote text
            Text(entry.quote.text)
                .font(.custom("TBMCYXT", size: quoteFontSize))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
                .lineLimit(nil)
                .minimumScaleFactor(0.85)
            
            Spacer()
        }
        .padding(padding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("减肥励志语录: \(entry.quote.text)")
    }
}

struct GitaWidget: Widget {
    let kind: String = "GitaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GitaWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.7, green: 0.4, blue: 0.5),
                            Color(red: 0.6, green: 0.3, blue: 0.4)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
        }
        .configurationDisplayName("减肥语录")
        .description("每日减肥励志语录，助你坚持瘦身目标")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "别吃了，你又不饿，只是馋。", chapter: 1, verse: 1))
    SimpleEntry(date: .now, quote: Quote(text: "流汗是脂肪在哭泣，别让它停。", chapter: 3, verse: 3))
}

#Preview(as: .systemMedium) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "好看的衣服都在等瘦子穿呢，你穿啥？", chapter: 2, verse: 1))
    SimpleEntry(date: .now, quote: Quote(text: "比你瘦的人还在努力，你凭什么歇着？", chapter: 3, verse: 2))
}
