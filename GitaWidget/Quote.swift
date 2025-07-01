//
//  Quote.swift
//  GitaWidget
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation

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

struct Quote: Codable, Identifiable {
    let id: UUID
    let text: String
    let mode: Mode
    let number: Int
    
    init(text: String, mode: Mode, number: Int) {
        self.id = UUID()
        self.text = text
        self.mode = mode
        self.number = number
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
    private let sharedDefaults = UserDefaults(suiteName: "group.com.gita.app") ?? UserDefaults.standard
    
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
