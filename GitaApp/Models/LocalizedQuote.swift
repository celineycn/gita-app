//
//  LocalizedQuote.swift
//  GitaApp
//
//  Created by Celine on 1/21/25.
//

import Foundation

/// 本地化语录数据结构
struct LocalizedQuoteData: Codable {
    let quotes: [String: [LocalizedQuote]]
    
    enum CodingKeys: String, CodingKey {
        case quotes
    }
}

/// 本地化语录结构
struct LocalizedQuote: Codable {
    let text: String
    let number: Int
    let segments: [LocalizedSegment]
    
    /// 转换为Quote对象
    func toQuote(mode: Mode) -> Quote {
        let textSegments = segments.map { segment in
            TextSegment(text: segment.text, isImportant: segment.isImportant)
        }
        return Quote(text: text, mode: mode, number: number, segments: textSegments)
    }
}

/// 本地化文本片段
struct LocalizedSegment: Codable {
    let text: String
    let isImportant: Bool
}

/// 语录加载器
class QuoteLoader {
    static func loadQuotes(for language: Language) -> LocalizedQuoteData? {
        let fileName = "quotes-\(language.rawValue)"
        print("🔍 Attempting to load quotes for language: \(language.rawValue)")
        
        // 首先尝试从Quotes子目录加载
        print("🔍 Attempting to load from bundle Quotes subdirectory")
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "Quotes") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let result = try decoder.decode(LocalizedQuoteData.self, from: data)
                print("✅ Successfully loaded quotes from Quotes subdirectory for \(language.rawValue)")
                print("📊 Loaded \(result.quotes.count) categories")
                return result
            } catch {
                print("❌ Error loading quotes from Quotes subdirectory: \(error)")
            }
        }
        
        // 如果失败，尝试从App Group共享容器加载
        if let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: AppConfig.appGroupIdentifier
        ) {
            let fileURL = containerURL
                .appendingPathComponent("Quotes", isDirectory: true)
                .appendingPathComponent("\(fileName).json")
            
            print("🔍 Checking shared container: \(fileURL.path)")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    let data = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(LocalizedQuoteData.self, from: data)
                    print("✅ Successfully loaded quotes from shared container for \(language.rawValue)")
                    print("📊 Loaded \(result.quotes.count) categories")
                    return result
                } catch {
                    print("❌ Error loading quotes from shared container: \(error)")
                }
            } else {
                print("⚠️ File not found in shared container")
            }
        }
        
        // 如果都失败，尝试从根目录加载（备用）
        print("🔍 Attempting to load from bundle root directory")
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let result = try decoder.decode(LocalizedQuoteData.self, from: data)
                print("✅ Successfully loaded quotes from bundle root for \(language.rawValue)")
                print("📊 Loaded \(result.quotes.count) categories")
                return result
            } catch {
                print("❌ Error loading quotes from bundle root: \(error)")
            }
        }
        
        // 最后尝试从原来的Localizations/Quotes子目录加载
        print("🔍 Attempting to load from bundle with subdirectory: Localizations/Quotes")
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "Localizations/Quotes") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let result = try decoder.decode(LocalizedQuoteData.self, from: data)
                print("✅ Successfully loaded quotes from Localizations/Quotes subdirectory for \(language.rawValue)")
                print("📊 Loaded \(result.quotes.count) categories")
                return result
            } catch {
                print("❌ Error loading quotes from Localizations/Quotes subdirectory: \(error)")
            }
        }
        
        print("❌ Could not find \(fileName).json in any location")
        return nil
    }
} 