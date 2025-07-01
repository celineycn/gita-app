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
    
    var body: some View {
        TabView {
            ModeSelectionView()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("模式选择")
                }
            
            QuoteLibraryView()
                .tabItem {
                    Image(systemName: "quote.bubble")
                    Text("语录库")
                }
        }
        .environmentObject(settingsManager)
    }
}

struct ModeSelectionView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("选择你的模式")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Text("根据你当前的目标，选择最适合的激励模式")
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
                    Text("当前选择：\(settingsManager.selectedMode.displayName)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Widget将显示该模式下的语录")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("模式选择")
            .navigationBarTitleDisplayMode(.inline)
        }
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
    @State private var selectedQuote: Quote?
    
    private var quotesForCurrentMode: [Quote] {
        QuoteService.shared.getQuotes(for: settingsManager.selectedMode)
    }
    
    var body: some View {
        NavigationView {
            List(quotesForCurrentMode) { quote in
                QuoteRow(quote: quote) {
                    selectedQuote = quote
                }
            }
            .navigationTitle("\(settingsManager.selectedMode.displayName)语录")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(item: $selectedQuote) { quote in
            QuoteDetailView(quote: quote)
        }
    }
}

struct QuoteRow: View {
    let quote: Quote
    let onTap: () -> Void
    
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
                
                Text(quote.text)
                    .font(.body)
                    .foregroundColor(.primary)
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
