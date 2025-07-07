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
        let currentMode = SettingsManager.shared.getCurrentMode()
        return SimpleEntry(date: Date(), quote: WidgetQuoteService.shared.getRandomQuote(for: currentMode))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // 重新加载语录以确保使用最新语言
        WidgetQuoteService.shared.reloadQuotes()
        let currentMode = SettingsManager.shared.getCurrentMode()
        let entry = SimpleEntry(date: Date(), quote: WidgetQuoteService.shared.getRandomQuote(for: currentMode))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // 重新加载语录以确保使用最新语言
        WidgetQuoteService.shared.reloadQuotes()
        
        let currentMode = SettingsManager.shared.getCurrentMode()
        
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        // 每5分钟更新一次，创建12个entries（1小时）
        // 根据当前选择的模式获取语录
        for minuteOffset in stride(from: 0, to: 60, by: 5) {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: WidgetQuoteService.shared.getRandomQuote(for: currentMode))
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
    
    // 根据语言获取字体大小
    private var quoteFontSize: CGFloat {
        let language = WidgetLanguageManager.getCurrentLanguageForWidget()
        let baseSize: CGFloat
        
        switch family {
        case .systemSmall:
            baseSize = language == .english ? 14 : 18  // 英文更小
        case .systemMedium:
            baseSize = language == .english ? 17 : 22  // 英文更小
        default:
            baseSize = language == .english ? 19 : 24  // 英文更小
        }
        
        return baseSize
    }
    
    private var importantQuoteFontSize: CGFloat {
        let language = WidgetLanguageManager.getCurrentLanguageForWidget()
        let baseSize: CGFloat
        
        switch family {
        case .systemSmall:
            baseSize = language == .english ? 17 : 22  // 英文更小
        case .systemMedium:
            baseSize = language == .english ? 21 : 28  // 英文更小
        default:
            baseSize = language == .english ? 24 : 30  // 英文更小
        }
        
        return baseSize
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
        family == .systemSmall ? 3 : 5
    }
    
    private var leftPadding: CGFloat {
        family == .systemSmall ? 6 : 9  // 减少1/4：8*0.75=6, 12*0.75=9
    }
    
    private var verticalPadding: CGFloat {
        family == .systemSmall ? 4 : 6
    }
    
    // 竖条高度 - 根据文字内容动态调整
    private var barHeight: CGFloat {
        // 更准确的行数估算 - 根据语言调整字符宽度
        let language = WidgetLanguageManager.getCurrentLanguageForWidget()
        let textLength = entry.quote.text.count
        let estimatedCharsPerLine: Int
        
        switch family {
        case .systemSmall:
            estimatedCharsPerLine = language == .english ? 18 : 6  // 英文字符更窄
        case .systemMedium:
            estimatedCharsPerLine = language == .english ? 28 : 10 // 英文字符更窄
        default:
            estimatedCharsPerLine = language == .english ? 28 : 10
        }
        
        let estimatedLines = max(1, (textLength + estimatedCharsPerLine - 1) / estimatedCharsPerLine) // 向上取整
        
        // 根据行数计算竖条高度
        let lineHeightMultiplier = language == .english ? 1.1 : 1.3  // 英文行间距更小
        let lineHeight = quoteFontSize * lineHeightMultiplier
        let baseHeight = CGFloat(estimatedLines) * lineHeight
        
        // 添加固定的基础高度，确保即使短文字也有合理长度
        let minHeight = quoteFontSize * 1.5
        let contentHeight = max(baseHeight, minHeight)
        
        switch family {
        case .systemSmall:
            return max(contentHeight * 0.85, quoteFontSize * 2.0)  // 至少2倍字体大小
        case .systemMedium:
            return max(contentHeight * 0.65, quoteFontSize * 1.0)  // 调整：更短的比例和最小高度
        default:
            return max(contentHeight * 0.65, quoteFontSize * 1.0)
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
    
    // 构建富文本 - 确保空格不丢失
    private var styledText: Text {
        let language = WidgetLanguageManager.getCurrentLanguageForWidget()
        let segments = entry.quote.segments
        
        // 对于英文，先构建完整的AttributedString
        if language == .english {
            var attributedString = AttributedString()
            
            for segment in segments {
                var segmentString = AttributedString(segment.text)
                
                // 设置字体
                segmentString.font = .system(size: segment.isImportant ? importantQuoteFontSize : quoteFontSize, weight: segment.isImportant ? .bold : .medium)
                
                // 设置颜色
                segmentString.foregroundColor = segment.isImportant ? importantTextColor : textColor
                
                attributedString.append(segmentString)
            }
            
            return Text(attributedString)
        } else {
            // 中文使用原来的方法
            guard let firstSegment = segments.first else {
                return Text("")
            }
            
            var combinedText = Text(firstSegment.text)
                .font(.custom("TBMCYXT", size: firstSegment.isImportant ? importantQuoteFontSize : quoteFontSize))
                .fontWeight(firstSegment.isImportant ? .black : .heavy)
                .foregroundColor(firstSegment.isImportant ? importantTextColor : textColor)
            
            for i in 1..<segments.count {
                let segment = segments[i]
                let segmentText = Text(segment.text)
                    .font(.custom("TBMCYXT", size: segment.isImportant ? importantQuoteFontSize : quoteFontSize))
                    .fontWeight(segment.isImportant ? .black : .heavy)
                    .foregroundColor(segment.isImportant ? importantTextColor : textColor)
                combinedText = combinedText + segmentText
            }
            
            return combinedText
        }
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
                            .lineSpacing(WidgetLanguageManager.getCurrentLanguageForWidget() == .english ? 0 : 2)
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
        let language = WidgetLanguageManager.getCurrentLanguageForWidget()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: entry.date)
        let day = calendar.component(.day, from: entry.date)
        
        // 根据语言决定日期格式
        switch language {
        case .simplifiedChinese:
            // 中文使用 "X月X日" 格式
            let monthText = Text("\(month)")
                .font(.system(size: dateFontSize))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            let monthUnit = Text("月")
                .font(.system(size: dateFontSize))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            let dayText = Text("\(day)")
                .font(.system(size: dateFontSize))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            let dayUnit = Text("日")
                .font(.system(size: dateFontSize))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            return monthText + monthUnit + dayText + dayUnit
            
        case .english:
            // 英文使用标准日期格式
            let formatter = DateFormatter()
            formatter.locale = language.locale
            formatter.dateFormat = "MMM d"
            
            return Text(formatter.string(from: entry.date))
                .font(.system(size: dateFontSize))
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
    }
}

struct GitaWidget: Widget {
    let kind: String = "GitaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GitaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(getLocalizedString("widget.title"))
        .description(getLocalizedString("widget.description"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
    
    private func getLocalizedString(_ key: String) -> String {
        let language = WidgetLanguageManager.getCurrentLanguageForWidget()
        let languageCode = language.rawValue
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        
        return NSLocalizedString(key, comment: "")
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
