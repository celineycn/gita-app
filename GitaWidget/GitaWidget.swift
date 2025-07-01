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
        // 每5分钟更新一次，创建12个entries（1小时）
        // 根据当前选择的模式获取语录
        for minuteOffset in stride(from: 0, to: 60, by: 5) {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
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
    
    // 文字颜色 - 使用 primary 自适应系统主题和背景
    private var textColor: Color { .primary }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Quote text
            Text(entry.quote.text)
                .font(.custom("TBMCYXT", size: quoteFontSize))
                .fontWeight(.heavy)
                .foregroundColor(textColor)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
                .lineLimit(nil)
                .minimumScaleFactor(0.85)
            
            Spacer()
        }
        .padding(padding)
        .containerBackground(for: .widget) {
            // 使用厚重材质，获得类似电池widget的白色毛玻璃效果
            Rectangle()
                .fill(.thickMaterial)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(entry.quote.mode.displayName)语录: \(entry.quote.text)")
    }
}

struct GitaWidget: Widget {
    let kind: String = "GitaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GitaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("励志语录")
        .description("根据你选择的模式显示对应的励志语录")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "别吃了，你不饿，只是馋。", mode: .weightLoss, number: 24))
    SimpleEntry(date: .now, quote: Quote(text: "想要的太贵，不靠幻想买单。", mode: .makeMoney, number: 1))
}

#Preview(as: .systemMedium) {
    GitaWidget()
} timeline: {
    SimpleEntry(date: .now, quote: Quote(text: "明明可以上岸，却在刷短剧。", mode: .getAshore, number: 1))
    SimpleEntry(date: .now, quote: Quote(text: "结果比你想象中更好。", mode: .goodLuck, number: 1))
}
