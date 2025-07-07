//
//  LanguageManager.swift
//  GitaApp
//
//  Created by Celine on 1/21/25.
//

import Foundation
import SwiftUI
import WidgetKit

/// 语言管理器，负责管理应用的语言设置
class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    // 使用App Group共享的UserDefaults
    private let sharedDefaults = UserDefaults(suiteName: AppConfig.appGroupIdentifier) ?? UserDefaults.standard
    private let languageKey = "selectedLanguage"
    
    @Published var currentLanguage: Language {
        didSet {
            if currentLanguage != oldValue {
                saveLanguage()
                reloadAllWidgets()
            }
        }
    }
    
    private init() {
        // 从UserDefaults读取保存的语言设置
        if let savedLanguage = sharedDefaults.string(forKey: languageKey),
           let language = Language(rawValue: savedLanguage) {
            self.currentLanguage = language
        } else {
            // 默认使用系统语言
            self.currentLanguage = Language.from(locale: Locale.current)
        }
        
        // 首次启动时，复制JSON文件到共享容器
        copyQuotesToSharedContainer()
    }
    
    /// 保存语言设置
    private func saveLanguage() {
        sharedDefaults.set(currentLanguage.rawValue, forKey: languageKey)
        sharedDefaults.synchronize()
    }
    
    /// 刷新所有Widget
    private func reloadAllWidgets() {
        DispatchQueue.main.async {
            #if !WIDGET_EXTENSION
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadAllTimelines()
            }
            #endif
        }
    }
    
    /// 设置新语言
    func setLanguage(_ language: Language) {
        currentLanguage = language
        // 复制对应语言的语录文件到共享容器
        copyQuoteFileToSharedContainer(for: language)
    }
    
    /// 获取当前语言的Locale
    var currentLocale: Locale {
        return currentLanguage.locale
    }
    
    /// 判断是否使用用户自定义语言（而非跟随系统）
    var isUsingCustomLanguage: Bool {
        return sharedDefaults.string(forKey: languageKey) != nil
    }
    
    /// 重置为跟随系统语言
    func resetToSystemLanguage() {
        sharedDefaults.removeObject(forKey: languageKey)
        sharedDefaults.synchronize()
        currentLanguage = Language.from(locale: Locale.current)
        // 复制对应语言的语录文件到共享容器
        copyQuoteFileToSharedContainer(for: currentLanguage)
        reloadAllWidgets()
    }
    
    /// 获取本地化字符串
    func localizedString(for key: String, tableName: String? = nil) -> String {
        let bundle = Bundle.main
        let language = currentLanguage.rawValue
        
        if let path = bundle.path(forResource: language, ofType: "lproj"),
           let languageBundle = Bundle(path: path) {
            return NSLocalizedString(key, tableName: tableName, bundle: languageBundle, comment: "")
        }
        
        return NSLocalizedString(key, tableName: tableName, comment: "")
    }
    
    /// Widget中读取语言设置
    static func getCurrentLanguageForWidget() -> Language {
        let sharedDefaults = UserDefaults(suiteName: AppConfig.appGroupIdentifier) ?? UserDefaults.standard
        
        if let savedLanguage = sharedDefaults.string(forKey: "selectedLanguage"),
           let language = Language(rawValue: savedLanguage) {
            return language
        } else {
            return Language.from(locale: Locale.current)
        }
    }
    
    /// 复制JSON文件到App Group共享容器
    private func copyQuotesToSharedContainer() {
        // 复制当前语言的语录文件
        copyQuoteFileToSharedContainer(for: currentLanguage)
    }
    
    /// 复制特定语言的语录文件到共享容器
    private func copyQuoteFileToSharedContainer(for language: Language) {
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: AppConfig.appGroupIdentifier
        ) else {
            print("Could not access App Group container")
            return
        }
        
        let fileName = "quotes-\(language.rawValue).json"
        let quotesDirectory = containerURL.appendingPathComponent("Quotes", isDirectory: true)
        
        // 确保目录存在
        try? FileManager.default.createDirectory(at: quotesDirectory, withIntermediateDirectories: true)
        
        // 尝试从Quotes子目录加载
        var sourceURL = Bundle.main.url(forResource: "quotes-\(language.rawValue)", withExtension: "json", subdirectory: "Quotes")
        
        // 如果Quotes目录没有，尝试从根目录加载
        if sourceURL == nil {
            sourceURL = Bundle.main.url(forResource: "quotes-\(language.rawValue)", withExtension: "json")
        }
        
        // 如果还没有，尝试从Localizations/Quotes子目录加载
        if sourceURL == nil {
            sourceURL = Bundle.main.url(forResource: "quotes-\(language.rawValue)", withExtension: "json", subdirectory: "Localizations/Quotes")
        }
        
        guard let url = sourceURL else {
            print("Source file not found: \(fileName)")
            // 如果找不到对应语言的文件，尝试复制中文文件作为fallback
            if language != .simplifiedChinese {
                copyQuoteFileToSharedContainer(for: .simplifiedChinese)
            }
            return
        }
        
        let destinationURL = quotesDirectory.appendingPathComponent(fileName)
        
        // 如果文件已存在，先删除
        try? FileManager.default.removeItem(at: destinationURL)
        
        // 复制文件
        do {
            try FileManager.default.copyItem(at: url, to: destinationURL)
            print("✅ Copied \(fileName) to shared container")
        } catch {
            print("❌ Error copying \(fileName): \(error)")
        }
    }
} 