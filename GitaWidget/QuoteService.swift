//
//  QuoteService.swift
//  GitaWidget
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation

class QuoteService {
    static let shared = QuoteService()
    
    // 为了减少widget bundle大小，只包含每个模式的前20条语录作为示例
    private let quotes: [Quote] = [
        // 我要减肥 (20条示例)
        Quote(text: "去年拍的照片，脸小得不像你。", mode: .weightLoss, number: 1),
        Quote(text: "你戒的从来不是奶茶，是自律。", mode: .weightLoss, number: 2),
        Quote(text: "想瘦这件事，你说过很多遍了。", mode: .weightLoss, number: 3),
        Quote(text: "那条裤子不是缩水，是你膨胀。", mode: .weightLoss, number: 4),
        Quote(text: "那天发誓要瘦，现在胖得更稳。", mode: .weightLoss, number: 5),
        Quote(text: "减肥，是重新掌控自己的人生。", mode: .weightLoss, number: 6),
        Quote(text: "想吃就吃，是你最大的不自由。", mode: .weightLoss, number: 7),
        Quote(text: "胖不是问题，是你不解决问题。", mode: .weightLoss, number: 8),
        Quote(text: "长得不差，输在太爱吃。", mode: .weightLoss, number: 9),
        Quote(text: "好看的脸，不该躲在双下巴后。", mode: .weightLoss, number: 10),
        Quote(text: "瘦下来会更美，不是更好看，是更自信。", mode: .weightLoss, number: 11),
        Quote(text: "明明可以靠脸，非要靠修图。", mode: .weightLoss, number: 12),
        Quote(text: "奶茶三分糖，体脂百分百。", mode: .weightLoss, number: 13),
        Quote(text: "镜子里的你，还在等你心动。", mode: .weightLoss, number: 14),
        Quote(text: "美貌与自律，不是对立关系。", mode: .weightLoss, number: 15),
        Quote(text: "\"明天开始\"是体重的保护神。", mode: .weightLoss, number: 16),
        Quote(text: "热量不会因为你后悔就退货。", mode: .weightLoss, number: 17),
        Quote(text: "你还记得你上次瘦的时候吗？", mode: .weightLoss, number: 18),
        Quote(text: "你在焦虑胖的同时，吃得真香。", mode: .weightLoss, number: 19),
        Quote(text: "减肥路上，你太容易放过自己。", mode: .weightLoss, number: 20),
        
        // 我要上岸 (20条示例)
        Quote(text: "明明可以上岸，却在刷短剧。", mode: .getAshore, number: 1),
        Quote(text: "第一志愿已经等你很久了。", mode: .getAshore, number: 2),
        Quote(text: "脑子聪明，用在背歌词可惜了。", mode: .getAshore, number: 3),
        Quote(text: "背得了星座，背不下定义？", mode: .getAshore, number: 4),
        Quote(text: "你不是不会写，是太会逃避。", mode: .getAshore, number: 5),
        Quote(text: "智商在线，作业下线。", mode: .getAshore, number: 6),
        Quote(text: "本来能靠脑袋，非要靠熬夜。", mode: .getAshore, number: 7),
        Quote(text: "会分析爱情，却不会写分析题。", mode: .getAshore, number: 8),
        Quote(text: "脑子不差，差的是野心。", mode: .getAshore, number: 9),
        Quote(text: "明明是逻辑天才，却被数学吊打。", mode: .getAshore, number: 10),
        Quote(text: "你不是懒，是对自己太温柔。", mode: .getAshore, number: 11),
        Quote(text: "脑袋挺亮，手机更亮。", mode: .getAshore, number: 12),
        Quote(text: "书干净得像从没看过。", mode: .getAshore, number: 13),
        Quote(text: "你会的是选择题，选了放弃。", mode: .getAshore, number: 14),
        Quote(text: "能熬夜追番，为何不能刷卷？", mode: .getAshore, number: 15),
        Quote(text: "本该在考场发光，结果在床上发呆。", mode: .getAshore, number: 16),
        Quote(text: "你看得懂暗恋，却看不懂课本？", mode: .getAshore, number: 17),
        Quote(text: "才华配得上第一志愿吗？", mode: .getAshore, number: 18),
        Quote(text: "你输在坚持，不是能力。", mode: .getAshore, number: 19),
        Quote(text: "想考高分，先考过自己。", mode: .getAshore, number: 20),
        
        // 我要搞钱 (20条示例)
        Quote(text: "想要的太贵，不靠幻想买单。", mode: .makeMoney, number: 1),
        Quote(text: "赚钱不是贪心，是清醒。", mode: .makeMoney, number: 2),
        Quote(text: "我想要的生活，不便宜。", mode: .makeMoney, number: 3),
        Quote(text: "我没有摆烂的预算。", mode: .makeMoney, number: 4),
        Quote(text: "我拒绝无薪野心。", mode: .makeMoney, number: 5),
        Quote(text: "野心落地的声音，是到账。", mode: .makeMoney, number: 6),
        Quote(text: "情绪要管理，收入也一样。", mode: .makeMoney, number: 7),
        Quote(text: "生气不如赚钱快。", mode: .makeMoney, number: 8),
        Quote(text: "我值几个零，心里有数。", mode: .makeMoney, number: 9),
        Quote(text: "我不是野路子，是野心有路子。", mode: .makeMoney, number: 10),
        Quote(text: "钱给我安全感，也给我退路。", mode: .makeMoney, number: 11),
        Quote(text: "自信靠积累，底气靠存款。", mode: .makeMoney, number: 12),
        Quote(text: "穿得起想穿的，住得起想住的。", mode: .makeMoney, number: 13),
        Quote(text: "外表淡定，账户火热。", mode: .makeMoney, number: 14),
        Quote(text: "低调做事，默默搞钱。", mode: .makeMoney, number: 15),
        Quote(text: "我只对结果动心。", mode: .makeMoney, number: 16),
        Quote(text: "你喜欢内耗，我喜欢回报率。", mode: .makeMoney, number: 17),
        Quote(text: "赢，不需要通知全世界。", mode: .makeMoney, number: 18),
        Quote(text: "表面柔软，内里精算。", mode: .makeMoney, number: 19),
        Quote(text: "我搞钱，不搞情绪波动。", mode: .makeMoney, number: 20),
        
        // 我要好运 (20条示例)
        Quote(text: "结果比你想象中更好。", mode: .goodLuck, number: 1),
        Quote(text: "转折，正在悄悄向你靠近。", mode: .goodLuck, number: 2),
        Quote(text: "错过的是考验，来的是好运。", mode: .goodLuck, number: 3),
        Quote(text: "宇宙从不缺席，只是暂时沉默。", mode: .goodLuck, number: 4),
        Quote(text: "当你放下控制，幸运才开始工作。", mode: .goodLuck, number: 5),
        Quote(text: "所有美好的事物，正在加速奔向你。", mode: .goodLuck, number: 6),
        Quote(text: "你的名字，正在被好运记住。", mode: .goodLuck, number: 7),
        Quote(text: "延迟的回应，也在路上了。", mode: .goodLuck, number: 8),
        Quote(text: "等你准备好，礼物就会来。", mode: .goodLuck, number: 9),
        Quote(text: "命运正在悄悄偏向你这一边。", mode: .goodLuck, number: 10),
        Quote(text: "你正在变成值得被好运追上的人。", mode: .goodLuck, number: 11),
        Quote(text: "你的光，会被看见。", mode: .goodLuck, number: 12),
        Quote(text: "接下来，是属于你的回合。", mode: .goodLuck, number: 13),
        Quote(text: "别急，好事会按时到来。", mode: .goodLuck, number: 14),
        Quote(text: "一切都在酝酿最适合你的节奏。", mode: .goodLuck, number: 15),
        Quote(text: "你以为是结尾，其实是转场。", mode: .goodLuck, number: 16),
        Quote(text: "你想要的生活，也在找你。", mode: .goodLuck, number: 17),
        Quote(text: "所有的等待，都会被回应。", mode: .goodLuck, number: 18),
        Quote(text: "没有白走的路，每一步都算数。", mode: .goodLuck, number: 19),
        Quote(text: "好运不是突然，是刚刚好。", mode: .goodLuck, number: 20)
    ]
    
    private init() {}
    
    func getRandomQuote(for mode: Mode? = nil) -> Quote {
        let filteredQuotes: [Quote]
        if let mode = mode {
            filteredQuotes = quotes.filter { $0.mode == mode }
        } else {
            // 如果没有指定模式，使用当前选中的模式
            let selectedMode = SettingsManager.shared.getCurrentMode()
            filteredQuotes = quotes.filter { $0.mode == selectedMode }
        }
        return filteredQuotes.randomElement() ?? quotes[0]
    }
    
    func getAllQuotes() -> [Quote] {
        return quotes
    }
    
    func getQuotes(for mode: Mode) -> [Quote] {
        return quotes.filter { $0.mode == mode }
    }
}