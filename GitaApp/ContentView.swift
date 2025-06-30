//
//  ContentView.swift
//  GitaApp
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var quotes = QuoteService.shared.getAllQuotes()
    @State private var selectedQuote: Quote?
    
    var body: some View {
        NavigationView {
            List(quotes) { quote in
                QuoteRow(quote: quote) {
                    selectedQuote = quote
                }
            }
            .navigationTitle("减肥语录")
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
                Text(quote.text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
}
