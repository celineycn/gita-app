//
//  Language.swift
//  GitaApp
//
//  Created by Celine on 1/21/25.
//

import Foundation

/// 支持的语言枚举
enum Language: String, CaseIterable, Codable {
    case simplifiedChinese = "zh-Hans"
    case english = "en"
    
    /// 语言的本地化显示名称
    var displayName: String {
        switch self {
        case .simplifiedChinese:
            return "简体中文"
        case .english:
            return "English"
        }
    }
    
    /// 语言的emoji标识
    var emoji: String {
        switch self {
        case .simplifiedChinese:
            return "🇨🇳"
        case .english:
            return "🇺🇸"
        }
    }
    
    /// 对应的Locale
    var locale: Locale {
        switch self {
        case .simplifiedChinese:
            return Locale(identifier: "zh-Hans")
        case .english:
            return Locale(identifier: "en")
        }
    }
    
    /// 从系统语言获取对应的应用语言
    static func from(locale: Locale) -> Language {
        let languageCode = locale.language.languageCode?.identifier ?? ""
        
        // 检查是否是中文
        if languageCode == "zh" {
            return .simplifiedChinese
        }
        
        // 默认使用英文
        return .english
    }
} 