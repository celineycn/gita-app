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
    
    private var importantQuoteFontSize: CGFloat {
        switch family {
        case .systemSmall:
            return 22
        case .systemMedium:
            return 28
        default:
            return 30
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
    
    private var dateFontSize: CGFloat {
        switch family {
        case .systemSmall:
            return 17.6  // 22 * 0.8 = 17.6 (减少20%)
        case .systemMedium:
            return 20.8  // 26 * 0.8 = 20.8 (减少20%)
        default:
            return 22.4  // 28 * 0.8 = 22.4 (减少20%)
        }
    }
    
    private var padding: CGFloat {
        family == .systemSmall ? 8 : 12
    }
    
    private var leftPadding: CGFloat {
        family == .systemSmall ? 6 : 9  // 减少1/4：8*0.75=6, 12*0.75=9
    }
    
    private var verticalPadding: CGFloat {
        family == .systemSmall ? 4 : 6
    }
    
    // 竖条高度 - 根据widget尺寸调整
    private var barHeight: CGFloat {
        switch family {
        case .systemSmall:
            return quoteFontSize * 3.6  // 小widget再增加高度
        case .systemMedium:
            return quoteFontSize * 1.0  // 中等widget再减少高度
        default:
            return quoteFontSize * 1.0
        }
    }
    
    // 普通文字颜色 - 使用 primary 自适应系统主题和背景
    private var textColor: Color { .primary }
    
    // 重要信息颜色 - 根据模式选择不同颜色
    private var importantTextColor: Color {
        switch entry.quote.mode {
        case .weightLoss:
            return .orange
        case .getAshore:
            return .blue
        case .makeMoney:
            return .green
        case .goodLuck:
            return .purple
        }
    }
    
    // 构建富文本
    private var styledText: Text {
        var combinedText = Text("")
        
        for segment in entry.quote.segments {
            let segmentText = Text(segment.text)
                .font(.custom("TBMCYXT", size: segment.isImportant ? importantQuoteFontSize : quoteFontSize))
                .fontWeight(segment.isImportant ? .black : .heavy)
                .foregroundColor(segment.isImportant ? importantTextColor : textColor)
            
            combinedText = combinedText + segmentText
        }
        
        return combinedText
    }

    var body: some View {
        ZStack {
            // 左上角日期
            VStack {
                HStack {
                    styledDateText
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Spacer()
                }
                .padding(.top, verticalPadding)
                .padding(.leading, family == .systemSmall ? 3 : 5) // 减少日期的左边距
                .padding(.trailing, padding)
                Spacer()
            }
            
            // 左下角Quote区域 - 贴着底部
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    // 左侧竖线 - 独立放置，根据widget尺寸调整高度
                    RoundedRectangle(cornerRadius: 1.5)
                        .fill(importantTextColor)
                        .frame(width: 3, height: barHeight) // 使用动态计算的高度
                    
                    VStack(alignment: .leading, spacing: 4) {
                        // Quote text with styled segments
                        styledText
                            .multilineTextAlignment(.leading)
                            .lineSpacing(2)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.85)
                    }
                    .padding(.leading, 6) // 竖条和文字之间的间距
                    
                    Spacer()
                }
                .padding(.bottom, verticalPadding)
                .padding(.leading, family == .systemSmall ? 3 : 5) // 减少quote区域的左边距，与日期对齐
                .padding(.trailing, padding)
            }
        }
        .containerBackground(for: .widget) {
            // 使用厚重材质，获得类似电池widget的白色毛玻璃效果
            Rectangle()
                .fill(.thickMaterial)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(entry.quote.mode.displayName)语录: \(entry.quote.text)")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日"
        return formatter
    }
    
    // 创建分段颜色的日期文本
    private var styledDateText: Text {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: entry.date)
        let day = calendar.component(.day, from: entry.date)
        
        let monthText = Text("\(month)")
            .font(.system(size: dateFontSize))
            .fontWeight(.bold)
            .foregroundColor(.black)
        
        let monthUnit = Text("月")
            .font(.system(size: dateFontSize))
            .fontWeight(.bold)
            .foregroundColor(.black)
        
        let dayText = Text("\(day)")
            .font(.system(size: dateFontSize))
            .fontWeight(.bold)
            .foregroundColor(.black)
        
        let dayUnit = Text("日")
            .font(.system(size: dateFontSize))
            .fontWeight(.bold)
            .foregroundColor(.black)
        
        return monthText + monthUnit + dayText + dayUnit
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
