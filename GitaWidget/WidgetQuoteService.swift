//
//  WidgetQuoteService.swift
//  GitaWidget
//
//  Created by Celine on 1/21/25.
//

import Foundation

/// Widget专用的语录服务
class WidgetQuoteService {
    static let shared = WidgetQuoteService()
    
    private init() {
        // Widget启动时不需要特殊初始化
    }
    
    /// 获取随机语录
    func getRandomQuote(for mode: Mode? = nil) -> Quote {
        // 每次获取语录前检查语言是否变化
        checkAndReloadIfLanguageChanged()
        
        // 直接使用主App的QuoteService
        // 由于主App和Widget Extension共享QuoteService的代码
        // QuoteService会自动根据当前语言加载语录
        return QuoteService.shared.getRandomQuote(for: mode)
    }
    
    /// 重新加载语录
    func reloadQuotes() {
        // 在Widget环境中，需要手动触发语言变化的处理
        // 因为NotificationCenter的通知可能不会在Extension中触发
        NotificationCenter.default.post(name: Notification.Name("LanguageChanged"), object: nil)
        
        // 确保QuoteService已经处理了语言变化
        // 通过访问一次来确保语录已经加载
        _ = QuoteService.shared.getRandomQuote()
    }
    
    /// 检查语言是否变化并重新加载
    private func checkAndReloadIfLanguageChanged() {
        let sharedDefaults = UserDefaults(suiteName: AppConfig.appGroupIdentifier) ?? UserDefaults.standard
        let currentLanguageKey = sharedDefaults.string(forKey: "selectedLanguage")
        let lastLoadedLanguageKey = "lastLoadedLanguage_widget"
        let lastLoadedLanguage = sharedDefaults.string(forKey: lastLoadedLanguageKey)
        
        // 如果语言变化了，触发重新加载
        if currentLanguageKey != lastLoadedLanguage {
            print("🔄 Widget detected language change: \(lastLoadedLanguage ?? "nil") -> \(currentLanguageKey ?? "nil")")
            
            // 触发语言变化通知
            NotificationCenter.default.post(name: Notification.Name("LanguageChanged"), object: nil)
            
            // 保存当前语言作为最后加载的语言
            sharedDefaults.set(currentLanguageKey, forKey: lastLoadedLanguageKey)
            sharedDefaults.synchronize()
        }
    }
} 