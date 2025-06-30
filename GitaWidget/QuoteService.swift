//
//  QuoteService.swift
//  GitaWidget
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation

class QuoteService {
    static let shared = QuoteService()
    
    private let quotes: [Quote] = [
        // 一针见血型
        Quote(text: "别吃了，你又不饿，只是馋。", chapter: 1, verse: 1),
        Quote(text: "看看你的肚子，再看看你的衣柜，衣服做错了什么？", chapter: 1, verse: 2),
        Quote(text: "你身上的每一斤肉，都是向懒惰和贪婪低头的证据。", chapter: 1, verse: 3),
        Quote(text: "P图P得再瘦，风一吹不也露馅了？", chapter: 1, verse: 4),
        Quote(text: "人家是水做的，你是奶茶、可乐、炸鸡做的吧？", chapter: 1, verse: 5),
        
        // 扎心现实型
        Quote(text: "好看的衣服都在等瘦子穿呢，你穿啥？", chapter: 2, verse: 1),
        Quote(text: "去年买的S码，是在等你，还是在嘲笑你？", chapter: 2, verse: 2),
        Quote(text: "你的情敌正在瘦，你的前任在偷笑。", chapter: 2, verse: 3),
        Quote(text: "你和美女的距离，就差管住这张嘴。", chapter: 2, verse: 4),
        Quote(text: "放弃？你肥胖的样子，就已经是在放弃了。", chapter: 2, verse: 5),
        
        // 行动指令型
        Quote(text: "嘴上享受一时，腰上肥肉一世。选一个。", chapter: 3, verse: 1),
        Quote(text: "比你瘦的人还在努力，你凭什么歇着？", chapter: 3, verse: 2),
        Quote(text: "流汗是脂肪在哭泣，别让它停。", chapter: 3, verse: 3),
        Quote(text: "要么瘦，要么滚去跑。", chapter: 3, verse: 4),
        Quote(text: "闭嘴，迈腿。就这么简单。", chapter: 3, verse: 5)
    ]
    
    private init() {}
    
    func getRandomQuote() -> Quote {
        return quotes.randomElement() ?? quotes[0]
    }
    
    func getAllQuotes() -> [Quote] {
        return quotes
    }
}