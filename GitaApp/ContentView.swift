//
//  ContentView.swift
//  GitaApp
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @StateObject private var settingsManager = SettingsManager.shared
    @StateObject private var languageManager = LanguageManager.shared
    
    var body: some View {
        TabView {
            ModeSelectionView()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    LocalizedText("tab.mode", comment: "Mode Selection tab title")
                }
            
            QuoteLibraryView()
                .tabItem {
                    Image(systemName: "quote.bubble")
                    LocalizedText("tab.quotes", comment: "Quote Library tab title")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    LocalizedText("tab.settings", comment: "Settings tab title")
                }
        }
        .environmentObject(settingsManager)
        .environmentObject(languageManager)
    }
}

struct ModeSelectionView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                LocalizedText("mode.selection.title", comment: "Choose your mode")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                LocalizedText("mode.selection.subtitle", comment: "Choose the most suitable motivational mode based on your current goals")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(Mode.allCases, id: \.self) { mode in
                        ModeCard(
                            mode: mode,
                            isSelected: settingsManager.selectedMode == mode
                        ) {
                            settingsManager.selectedMode = mode
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 10) {
                    LocalizedFormatText("mode.selection.current %@", settingsManager.selectedMode.displayName, comment: "Current selection: %@")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    LocalizedText("mode.selection.widget.info", comment: "Widget will display quotes for this mode")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle(Text(getLocalizedString("mode.selection.navigation.title", comment: "Mode Selection")))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func getLocalizedString(_ key: String, comment: String) -> String {
        let languageCode = languageManager.currentLanguage.rawValue
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: comment)
        }
        
        return NSLocalizedString(key, comment: comment)
    }
}

struct ModeCard: View {
    let mode: Mode
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                Text(mode.emoji)
                    .font(.system(size: 40))
                
                Text(mode.displayName)
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.accentColor.opacity(0.2) : Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            )
            .foregroundColor(isSelected ? .accentColor : .primary)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

struct QuoteLibraryView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject private var quoteService = QuoteService.shared
    @State private var selectedQuote: Quote?
    
    private var quotesForCurrentMode: [Quote] {
        quoteService.getQuotes(for: settingsManager.selectedMode)
    }
    
    var body: some View {
        NavigationView {
            List(quotesForCurrentMode) { quote in
                QuoteRow(quote: quote) {
                    selectedQuote = quote
                }
            }
            .navigationTitle(Text(getLocalizedString("quotes.title", settingsManager.selectedMode.displayName)))
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(item: $selectedQuote) { quote in
            QuoteDetailView(quote: quote)
        }
    }
    
    private func getLocalizedString(_ key: String, _ arg: String) -> String {
        let languageCode = languageManager.currentLanguage.rawValue
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            let format = NSLocalizedString(key, bundle: bundle, comment: "")
            return String(format: format, arg)
        }
        
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, arg)
    }
}

struct QuoteRow: View {
    let quote: Quote
    let onTap: () -> Void
    @EnvironmentObject var languageManager: LanguageManager
    
    // 普通文字字号
    private let normalFontSize: CGFloat = 16
    
    // 重要信息字号
    private let importantFontSize: CGFloat = 18
    
    // 重要信息颜色 - 根据模式选择不同颜色
    private var importantTextColor: Color {
        switch quote.mode {
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
    
    // 构建富文本
    private var styledText: Text {
        var combinedText = Text("")
        let language = languageManager.currentLanguage
        
        for segment in quote.segments {
            let segmentText: Text
            
            // 根据语言选择不同的字体
            if language == .english {
                // 英文使用系统字体
                segmentText = Text(segment.text)
                    .font(.system(size: segment.isImportant ? importantFontSize : normalFontSize, weight: segment.isImportant ? .bold : .regular))
                    .foregroundColor(segment.isImportant ? importantTextColor : .primary)
            } else {
                // 中文使用系统字体（列表中不使用自定义字体）
                segmentText = Text(segment.text)
                    .font(.system(size: segment.isImportant ? importantFontSize : normalFontSize))
                    .fontWeight(segment.isImportant ? .bold : .regular)
                    .foregroundColor(segment.isImportant ? importantTextColor : .primary)
            }
            
            combinedText = combinedText + segmentText
        }
        
        return combinedText
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("#\(quote.number)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray5))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    Text(quote.mode.emoji)
                        .font(.caption)
                }
                
                styledText
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
}
