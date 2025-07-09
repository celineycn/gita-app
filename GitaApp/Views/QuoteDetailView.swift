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
    
    // 添加环境属性
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    // 自适应卡片宽度
    private var adaptiveCardWidth: CGFloat {
        switch horizontalSizeClass {
        case .regular:
            // iPad 或大屏设备 - 增加宽度
            return 700
        default:
            // iPhone 或紧凑布局
            return 340
        }
    }
    
    // 自适应最小高度
    private var adaptiveMinHeight: CGFloat {
        switch horizontalSizeClass {
        case .regular:
            // iPad需要更高的最小高度
            return 250
        default:
            return 200
        }
    }
    
    // 自适应字体大小基础值
    private var adaptiveFontSize: CGFloat {
        let baseSize: CGFloat = horizontalSizeClass == .regular ? 18 : 16
        
        // 根据动态字体大小调整
        switch dynamicTypeSize {
        case .xSmall, .small:
            return baseSize * 0.9
        case .medium:
            return baseSize
        case .large:
            return baseSize * 1.1
        case .xLarge:
            return baseSize * 1.2
        case .xxLarge:
            return baseSize * 1.3
        case .xxxLarge:
            return baseSize * 1.4
        default:
            return baseSize
        }
    }
    
    // 自适应内边距
    private var adaptivePadding: (horizontal: CGFloat, vertical: CGFloat) {
        switch horizontalSizeClass {
        case .regular:
            return (horizontal: 40, vertical: 48)
        default:
            return (horizontal: 24, vertical: 32)
        }
    }
    
    // 普通文字字号
    private var normalFontSize: CGFloat {
        adaptiveFontSize
    }
    
    // 重要信息字号
    private var importantFontSize: CGFloat {
        normalFontSize * 1.25
    }
    
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
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Stacked cards effect
                    ZStack {
                        // 使用屏幕宽度的百分比来计算卡片宽度，并限制最大宽度
                        let cardWidth = horizontalSizeClass == .regular 
                            ? min(geometry.size.width * 0.75, 600) 
                            : min(geometry.size.width - 40, 340)
                        
                        // Bottom card (shadow card)
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: cardWidth)
                            .frame(minHeight: adaptiveMinHeight)
                            .offset(x: 4, y: 8)
                        
                        // Second shadow card
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: cardWidth)
                            .frame(minHeight: adaptiveMinHeight)
                            .offset(x: 2, y: 4)
                        
                        // Main quote card with paper texture
                        ZStack {
                            // Paper texture background
                            Image("PaperTexture")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: cardWidth)
                                .clipped()
                            
                            // Semi-transparent overlay
                            Color.white.opacity(0.92)
                            
                            // Quote content with styled text
                            VStack(spacing: 24) {
                                styledText
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                                    .padding(.horizontal, adaptivePadding.horizontal)
                                    .frame(maxWidth: .infinity)
                                    .minimumScaleFactor(0.8)
                                    .lineLimit(nil)
                            }
                            .padding(.vertical, adaptivePadding.vertical)
                            .padding(.horizontal, horizontalSizeClass == .regular ? 30 : 20)
                        }
                        .frame(width: cardWidth)
                        .frame(minHeight: adaptiveMinHeight)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
            }
            .onTapGesture {
                dismiss()
            }
        }
    }
}

#Preview {
    QuoteDetailView(quote: Quote(text: "别吃了，你又不饿，只是馋。", mode: .weightLoss, number: 24))
}