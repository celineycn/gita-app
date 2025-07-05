//
//  Quote.swift
//  GitaWidget
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation

/// 应用程序配置常量
struct AppConfig {
    /// App Groups标识符，用于应用和Widget间的数据共享
    static let appGroupIdentifier = "group.com.ycn.GitaApp"
}

enum Mode: String, CaseIterable, Codable {
    case weightLoss = "我要减肥"
    case getAshore = "我要上岸"
    case makeMoney = "我要搞钱"
    case goodLuck = "我要好运"
    
    var displayName: String {
        return self.rawValue
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
        }
    }
    
    private init() {
        let savedMode = sharedDefaults.string(forKey: "selectedMode") ?? Mode.weightLoss.rawValue
        self.selectedMode = Mode(rawValue: savedMode) ?? .weightLoss
    }
    
    // Widget中读取最新的模式设置
    func getCurrentMode() -> Mode {
        let savedMode = sharedDefaults.string(forKey: "selectedMode") ?? Mode.weightLoss.rawValue
        return Mode(rawValue: savedMode) ?? .weightLoss
    }
}
