//
//  WidgetLanguageManager.swift
//  GitaWidget
//
//  Created by Celine on 1/21/25.
//

import Foundation

/// Widget专用的语言管理器
struct WidgetLanguageManager {
    
    /// Widget中获取当前语言设置
    static func getCurrentLanguageForWidget() -> Language {
        let sharedDefaults = UserDefaults(suiteName: AppConfig.appGroupIdentifier) ?? UserDefaults.standard
        let languageKey = "selectedLanguage"
        
        if let savedLanguage = sharedDefaults.string(forKey: languageKey),
           let language = Language(rawValue: savedLanguage) {
            return language
        } else {
            // 默认使用系统语言
            return Language.from(locale: Locale.current)
        }
    }
} 