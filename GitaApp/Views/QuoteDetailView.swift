//
//  QuoteDetailView.swift
//  GitaApp
//
//  Created by Mrityunjay Bhanja on 6/28/25.
//

import SwiftUI

struct QuoteDetailView: View {
    let quote: Quote
    @Environment(\.dismiss) private var dismiss
    
    // 普通文字字号
    private let normalFontSize: CGFloat = 16
    
    // 重要信息字号
    private let importantFontSize: CGFloat = 20
    
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
        let language = LanguageManager.shared.currentLanguage
        
        for segment in quote.segments {
            let segmentText: Text
            
            // 根据语言选择不同的字体
            if language == .english {
                // 英文使用系统字体
                segmentText = Text(segment.text)
                    .font(.system(size: segment.isImportant ? importantFontSize : normalFontSize, weight: segment.isImportant ? .black : .bold))
                    .foregroundColor(segment.isImportant ? importantTextColor : .black)
            } else {
                // 中文使用自定义字体
                segmentText = Text(segment.text)
                    .font(.custom("TBMCYXT", size: segment.isImportant ? importantFontSize : normalFontSize))
                    .fontWeight(segment.isImportant ? .black : .bold)
                    .foregroundColor(segment.isImportant ? importantTextColor : .black)
            }
            
            combinedText = combinedText + segmentText
        }
        
        return combinedText
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Stacked cards effect
                ZStack {
                    // Bottom card (shadow card)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(maxWidth: 340, minHeight: 200)
                        .offset(x: 4, y: 8)
                    
                    // Second shadow card
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(maxWidth: 340, minHeight: 200)
                        .offset(x: 2, y: 4)
                    
                    // Main quote card with paper texture
                    ZStack {
                        // Paper texture background
                        Image("PaperTexture")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                        
                        // Semi-transparent overlay
                        Color.white.opacity(0.92)
                        
                        // Quote content with styled text
                        VStack(spacing: 24) {
                            styledText
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                                .padding(.horizontal, 24)
                        }
                        .padding(.vertical, 32)
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: 340)
                    .frame(minHeight: 200)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    QuoteDetailView(quote: Quote(text: "别吃了，你又不饿，只是馋。", mode: .weightLoss, number: 24))
}