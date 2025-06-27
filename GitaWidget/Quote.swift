//
//  Quote.swift
//  GitaWidget
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation

struct Quote: Codable, Identifiable {
    let id: UUID
    let text: String
    let chapter: Int
    let verse: Int
    
    init(text: String, chapter: Int, verse: Int) {
        self.id = UUID()
        self.text = text
        self.chapter = chapter
        self.verse = verse
    }
    
    var attribution: String {
        "Chapter \(chapter), Verse \(verse)"
    }
}
