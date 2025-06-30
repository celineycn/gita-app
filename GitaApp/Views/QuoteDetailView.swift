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
                        
                        // Quote content
                        VStack(spacing: 24) {
                            Text(quote.text)
                                .font(.custom("TBMCYXT", size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
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
    QuoteDetailView(quote: Quote(text: "别吃了，你又不饿，只是馋。", chapter: 1, verse: 1))
}