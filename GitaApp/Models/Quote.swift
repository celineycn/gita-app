//
//  Quote.swift
//  GitaApp
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation
import WidgetKit

enum Mode: String, CaseIterable, Codable {
    case weightLoss = "我要减肥"
    case getAshore = "我要上岸"
    case makeMoney = "我要搞钱"
    case goodLuck = "我要好运"
    
    var displayName: String {
        // 动态获取本地化字符串
        let key: String
        switch self {
        case .weightLoss:
            key = "mode.weightLoss"
        case .getAshore:
            key = "mode.getAshore"
        case .makeMoney:
            key = "mode.makeMoney"
        case .goodLuck:
            key = "mode.goodLuck"
        }
        
        // 尝试使用当前语言的Bundle
        if let sharedDefaults = UserDefaults(suiteName: AppConfig.appGroupIdentifier),
           let languageCode = sharedDefaults.string(forKey: "selectedLanguage"),
           let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        
        // 如果没有自定义语言，使用系统语言
        let currentLocale = Locale.current
        let languageCode = currentLocale.language.languageCode?.identifier ?? "en"
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        
        // 最后使用默认
        return NSLocalizedString(key, comment: "")
    }
    
    var emoji: String {
        switch self {
        case .weightLoss:
            return "💪"
        case .getAshore:
            return "📚"
        case .makeMoney:
            return "💰"
        case .goodLuck:
            return "🍀"
        }
    }
}

// 文本片段结构，用于区分重要和普通文本
struct TextSegment: Codable {
    let text: String
    let isImportant: Bool
    
    init(text: String, isImportant: Bool = false) {
        self.text = text
        self.isImportant = isImportant
    }
}

struct Quote: Codable, Identifiable {
    let id: UUID
    let text: String
    let mode: Mode
    let number: Int
    let segments: [TextSegment] // 新增：文本片段数组，用于标识重要信息
    
    init(text: String, mode: Mode, number: Int, segments: [TextSegment] = []) {
        self.id = UUID()
        self.text = text
        self.mode = mode
        self.number = number
        // 如果没有提供segments，将整个文本作为普通文本
        self.segments = segments.isEmpty ? [TextSegment(text: text, isImportant: false)] : segments
    }
    
    var attribution: String {
        return "\(mode.displayName) #\(number)"
    }
    
    var categoryName: String {
        return mode.displayName
    }
}

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    // 使用App Group共享的UserDefaults
    private let sharedDefaults = UserDefaults(suiteName: AppConfig.appGroupIdentifier) ?? UserDefaults.standard
    
    @Published var selectedMode: Mode {
        didSet {
            sharedDefaults.set(selectedMode.rawValue, forKey: "selectedMode")
            sharedDefaults.synchronize()
            reloadAllWidgets()
        }
    }
    
    private init() {
        let savedMode = sharedDefaults.string(forKey: "selectedMode") ?? Mode.weightLoss.rawValue
        self.selectedMode = Mode(rawValue: savedMode) ?? .weightLoss
    }
    
    private func reloadAllWidgets() {
        DispatchQueue.main.async {
            #if !WIDGET_EXTENSION
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            #endif
        }
    }
    
    // Widget中读取最新的模式设置
    func getCurrentMode() -> Mode {
        let savedMode = sharedDefaults.string(forKey: "selectedMode") ?? Mode.weightLoss.rawValue
        return Mode(rawValue: savedMode) ?? .weightLoss
    }
}
