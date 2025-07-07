//
//  LocalizedView.swift
//  GitaApp
//
//  Created by Celine on 1/21/25.
//

import SwiftUI

/// 动态本地化的Text视图，会响应语言变化
struct LocalizedText: View {
    let key: String
    let comment: String
    @EnvironmentObject var languageManager: LanguageManager
    
    init(_ key: String, comment: String = "") {
        self.key = key
        self.comment = comment
    }
    
    var body: some View {
        Text(localizedString)
    }
    
    private var localizedString: String {
        // 强制使用当前语言的Bundle
        let languageCode = languageManager.currentLanguage.rawValue
        
        // 尝试获取对应语言的Bundle
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: comment)
        }
        
        // 如果找不到，使用默认
        return NSLocalizedString(key, comment: comment)
    }
}

/// 动态本地化的格式化字符串
struct LocalizedFormatText: View {
    let key: String
    let arguments: [String]
    let comment: String
    @EnvironmentObject var languageManager: LanguageManager
    
    init(_ key: String, _ arguments: String..., comment: String = "") {
        self.key = key
        self.arguments = arguments
        self.comment = comment
    }
    
    var body: some View {
        Text(formattedString)
    }
    
    private var formattedString: String {
        let languageCode = languageManager.currentLanguage.rawValue
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            let format = NSLocalizedString(key, bundle: bundle, comment: comment)
            return String(format: format, arguments: arguments)
        }
        
        let format = NSLocalizedString(key, comment: comment)
        return String(format: format, arguments: arguments)
    }
} 