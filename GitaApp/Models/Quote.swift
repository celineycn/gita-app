//
//  Quote.swift
//  GitaApp
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
        return ""
    }
    
    var categoryName: String {
        switch chapter {
        case 1:
            return "一针见血型"
        case 2:
            return "扎心现实型"
        case 3:
            return "行动指令型"
        default:
            return "减肥语录"
        }
    }
}
