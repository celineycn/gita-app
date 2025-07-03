//
//  QuoteService.swift
//  GitaApp
//
//  Created by Mrityunjay Bhanja on 6/27/25.
//

import Foundation

class QuoteService {
    static let shared = QuoteService()
    
    private let quotes: [Quote] = [
        // 我要减肥 (20条示例)
        Quote(text: "去年拍的照片，脸小得不像你。", mode: .weightLoss, number: 1, segments: [
            TextSegment(text: "去年拍的照片，脸小得", isImportant: false),
            TextSegment(text: "不像你", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "你戒的从来不是奶茶，是自律。", mode: .weightLoss, number: 2, segments: [
            TextSegment(text: "你戒的从来不是", isImportant: false),
            TextSegment(text: "奶茶", isImportant: true),
            TextSegment(text: "，是", isImportant: false),
            TextSegment(text: "自律", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "想瘦这件事，你说过很多遍了。", mode: .weightLoss, number: 3, segments: [
            TextSegment(text: "想瘦", isImportant: true),
            TextSegment(text: "这件事，你说过很多遍了。", isImportant: false)
        ]),
        Quote(text: "那条裤子不是缩水，是你膨胀。", mode: .weightLoss, number: 4, segments: [
            TextSegment(text: "那条裤子不是缩水，是你", isImportant: false),
            TextSegment(text: "膨胀", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "那天发誓要瘦，现在胖得更稳。", mode: .weightLoss, number: 5, segments: [
            TextSegment(text: "那天", isImportant: false),
            TextSegment(text: "发誓", isImportant: true),
            TextSegment(text: "要瘦，现在", isImportant: false),
            TextSegment(text: "胖得更稳", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "减肥，是重新掌控自己的人生。", mode: .weightLoss, number: 6, segments: [
            TextSegment(text: "减肥", isImportant: true),
            TextSegment(text: "，是重新", isImportant: false),
            TextSegment(text: "掌控", isImportant: true),
            TextSegment(text: "自己的人生。", isImportant: false)
        ]),
        Quote(text: "想吃就吃，是你最大的不自由。", mode: .weightLoss, number: 7, segments: [
            TextSegment(text: "想吃就吃", isImportant: true),
            TextSegment(text: "，是你最大的", isImportant: false),
            TextSegment(text: "不自由", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "胖不是问题，是你不解决问题。", mode: .weightLoss, number: 8, segments: [
            TextSegment(text: "胖不是问题，是你", isImportant: false),
            TextSegment(text: "不解决", isImportant: true),
            TextSegment(text: "问题。", isImportant: false)
        ]),
        Quote(text: "长得不差，输在太爱吃。", mode: .weightLoss, number: 9, segments: [
            TextSegment(text: "长得不差，输在", isImportant: false),
            TextSegment(text: "太爱吃", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "好看的脸，不该躲在双下巴后。", mode: .weightLoss, number: 10, segments: [
            TextSegment(text: "好看的", isImportant: false),
            TextSegment(text: "脸", isImportant: true),
            TextSegment(text: "，不该躲在", isImportant: false),
            TextSegment(text: "双下巴", isImportant: true),
            TextSegment(text: "后。", isImportant: false)
        ]),
        Quote(text: "瘦下来会更美，不是更好看，是更自信。", mode: .weightLoss, number: 11, segments: [
            TextSegment(text: "瘦下来", isImportant: true),
            TextSegment(text: "会更美，不是更好看，是更", isImportant: false),
            TextSegment(text: "自信", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "明明可以靠脸，非要靠修图。", mode: .weightLoss, number: 12, segments: [
            TextSegment(text: "明明可以靠", isImportant: false),
            TextSegment(text: "脸", isImportant: true),
            TextSegment(text: "，非要靠", isImportant: false),
            TextSegment(text: "修图", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "奶茶三分糖，体脂百分百。", mode: .weightLoss, number: 13, segments: [
            TextSegment(text: "奶茶", isImportant: true),
            TextSegment(text: "三分糖，", isImportant: false),
            TextSegment(text: "体脂", isImportant: true),
            TextSegment(text: "百分百。", isImportant: false)
        ]),
        Quote(text: "镜子里的你，还在等你心动。", mode: .weightLoss, number: 14, segments: [
            TextSegment(text: "镜子", isImportant: true),
            TextSegment(text: "里的你，还在等你", isImportant: false),
            TextSegment(text: "心动", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "美貌与自律，不是对立关系。", mode: .weightLoss, number: 15, segments: [
            TextSegment(text: "美貌", isImportant: true),
            TextSegment(text: "与", isImportant: false),
            TextSegment(text: "自律", isImportant: true),
            TextSegment(text: "，不是对立关系。", isImportant: false)
        ]),
        Quote(text: "\"明天开始\"是体重的保护神。", mode: .weightLoss, number: 16, segments: [
            TextSegment(text: "\"明天开始\"", isImportant: true),
            TextSegment(text: "是体重的", isImportant: false),
            TextSegment(text: "保护神", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "热量不会因为你后悔就退货。", mode: .weightLoss, number: 17, segments: [
            TextSegment(text: "热量", isImportant: true),
            TextSegment(text: "不会因为你后悔就", isImportant: false),
            TextSegment(text: "退货", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "你还记得你上次瘦的时候吗？", mode: .weightLoss, number: 18, segments: [
            TextSegment(text: "你还记得你", isImportant: false),
            TextSegment(text: "上次瘦", isImportant: true),
            TextSegment(text: "的时候吗？", isImportant: false)
        ]),
        Quote(text: "你在焦虑胖的同时，吃得真香。", mode: .weightLoss, number: 19, segments: [
            TextSegment(text: "你在", isImportant: false),
            TextSegment(text: "焦虑胖", isImportant: true),
            TextSegment(text: "的同时，", isImportant: false),
            TextSegment(text: "吃得真香", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "减肥路上，你太容易放过自己。", mode: .weightLoss, number: 20, segments: [
            TextSegment(text: "减肥路上，你太容易", isImportant: false),
            TextSegment(text: "放过", isImportant: true),
            TextSegment(text: "自己。", isImportant: false)
        ]),
        
        // 我要上岸 (20条示例)
        Quote(text: "明明可以上岸，却在刷短剧。", mode: .getAshore, number: 1, segments: [
            TextSegment(text: "明明可以", isImportant: false),
            TextSegment(text: "上岸", isImportant: true),
            TextSegment(text: "，却在", isImportant: false),
            TextSegment(text: "刷短剧", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "第一志愿已经等你很久了。", mode: .getAshore, number: 2, segments: [
            TextSegment(text: "第一志愿", isImportant: true),
            TextSegment(text: "已经", isImportant: false),
            TextSegment(text: "等你", isImportant: true),
            TextSegment(text: "很久了。", isImportant: false)
        ]),
        Quote(text: "脑子聪明，用在背歌词可惜了。", mode: .getAshore, number: 3, segments: [
            TextSegment(text: "脑子", isImportant: true),
            TextSegment(text: "聪明，用在", isImportant: false),
            TextSegment(text: "背歌词", isImportant: true),
            TextSegment(text: "可惜了。", isImportant: false)
        ]),
        Quote(text: "背得了星座，背不下定义？", mode: .getAshore, number: 4, segments: [
            TextSegment(text: "背得了", isImportant: false),
            TextSegment(text: "星座", isImportant: true),
            TextSegment(text: "，背不下", isImportant: false),
            TextSegment(text: "定义", isImportant: true),
            TextSegment(text: "？", isImportant: false)
        ]),
        Quote(text: "你不是不会写，是太会逃避。", mode: .getAshore, number: 5, segments: [
            TextSegment(text: "你不是不会写，是太会", isImportant: false),
            TextSegment(text: "逃避", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "智商在线，作业下线。", mode: .getAshore, number: 6, segments: [
            TextSegment(text: "智商", isImportant: true),
            TextSegment(text: "在线，", isImportant: false),
            TextSegment(text: "作业", isImportant: true),
            TextSegment(text: "下线。", isImportant: false)
        ]),
        Quote(text: "本来能靠脑袋，非要靠熬夜。", mode: .getAshore, number: 7, segments: [
            TextSegment(text: "本来能靠", isImportant: false),
            TextSegment(text: "脑袋", isImportant: true),
            TextSegment(text: "，非要靠", isImportant: false),
            TextSegment(text: "熬夜", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "会分析爱情，却不会写分析题。", mode: .getAshore, number: 8, segments: [
            TextSegment(text: "会分析", isImportant: false),
            TextSegment(text: "爱情", isImportant: true),
            TextSegment(text: "，却不会写", isImportant: false),
            TextSegment(text: "分析题", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "脑子不差，差的是野心。", mode: .getAshore, number: 9, segments: [
            TextSegment(text: "脑子不差，差的是", isImportant: false),
            TextSegment(text: "野心", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "明明是逻辑天才，却被数学吊打。", mode: .getAshore, number: 10, segments: [
            TextSegment(text: "明明是", isImportant: false),
            TextSegment(text: "逻辑天才", isImportant: true),
            TextSegment(text: "，却被", isImportant: false),
            TextSegment(text: "数学", isImportant: true),
            TextSegment(text: "吊打。", isImportant: false)
        ]),
        Quote(text: "你不是懒，是对自己太温柔。", mode: .getAshore, number: 11, segments: [
            TextSegment(text: "你不是懒，是对自己太", isImportant: false),
            TextSegment(text: "温柔", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "脑袋挺亮，手机更亮。", mode: .getAshore, number: 12, segments: [
            TextSegment(text: "脑袋", isImportant: true),
            TextSegment(text: "挺亮，", isImportant: false),
            TextSegment(text: "手机", isImportant: true),
            TextSegment(text: "更亮。", isImportant: false)
        ]),
        Quote(text: "书干净得像从没看过。", mode: .getAshore, number: 13, segments: [
            TextSegment(text: "书", isImportant: true),
            TextSegment(text: "干净得像", isImportant: false),
            TextSegment(text: "从没看过", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "你会的是选择题，选了放弃。", mode: .getAshore, number: 14, segments: [
            TextSegment(text: "你会的是", isImportant: false),
            TextSegment(text: "选择题", isImportant: true),
            TextSegment(text: "，选了", isImportant: false),
            TextSegment(text: "放弃", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "能熬夜追番，为何不能刷卷？", mode: .getAshore, number: 15, segments: [
            TextSegment(text: "能", isImportant: false),
            TextSegment(text: "熬夜追番", isImportant: true),
            TextSegment(text: "，为何不能", isImportant: false),
            TextSegment(text: "刷卷", isImportant: true),
            TextSegment(text: "？", isImportant: false)
        ]),
        Quote(text: "本该在考场发光，结果在床上发呆。", mode: .getAshore, number: 16, segments: [
            TextSegment(text: "本该在", isImportant: false),
            TextSegment(text: "考场", isImportant: true),
            TextSegment(text: "发光，结果在", isImportant: false),
            TextSegment(text: "床上", isImportant: true),
            TextSegment(text: "发呆。", isImportant: false)
        ]),
        Quote(text: "你看得懂暗恋，却看不懂课本？", mode: .getAshore, number: 17, segments: [
            TextSegment(text: "你看得懂", isImportant: false),
            TextSegment(text: "暗恋", isImportant: true),
            TextSegment(text: "，却看不懂", isImportant: false),
            TextSegment(text: "课本", isImportant: true),
            TextSegment(text: "？", isImportant: false)
        ]),
        Quote(text: "才华配得上第一志愿吗？", mode: .getAshore, number: 18, segments: [
            TextSegment(text: "才华", isImportant: true),
            TextSegment(text: "配得上", isImportant: false),
            TextSegment(text: "第一志愿", isImportant: true),
            TextSegment(text: "吗？", isImportant: false)
        ]),
        Quote(text: "你输在坚持，不是能力。", mode: .getAshore, number: 19, segments: [
            TextSegment(text: "你输在", isImportant: false),
            TextSegment(text: "坚持", isImportant: true),
            TextSegment(text: "，不是", isImportant: false),
            TextSegment(text: "能力", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "想考高分，先考过自己。", mode: .getAshore, number: 20, segments: [
            TextSegment(text: "想", isImportant: false),
            TextSegment(text: "考高分", isImportant: true),
            TextSegment(text: "，先", isImportant: false),
            TextSegment(text: "考过", isImportant: true),
            TextSegment(text: "自己。", isImportant: false)
        ]),
        
        // 我要搞钱 (20条示例)
        Quote(text: "想要的太贵，不靠幻想买单。", mode: .makeMoney, number: 1, segments: [
            TextSegment(text: "想要的", isImportant: false),
            TextSegment(text: "太贵", isImportant: true),
            TextSegment(text: "，不靠", isImportant: false),
            TextSegment(text: "幻想", isImportant: true),
            TextSegment(text: "买单。", isImportant: false)
        ]),
        Quote(text: "赚钱不是贪心，是清醒。", mode: .makeMoney, number: 2, segments: [
            TextSegment(text: "赚钱", isImportant: true),
            TextSegment(text: "不是贪心，是", isImportant: false),
            TextSegment(text: "清醒", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "我想要的生活，不便宜。", mode: .makeMoney, number: 3, segments: [
            TextSegment(text: "我想要的", isImportant: false),
            TextSegment(text: "生活", isImportant: true),
            TextSegment(text: "，", isImportant: false),
            TextSegment(text: "不便宜", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "我没有摆烂的预算。", mode: .makeMoney, number: 4, segments: [
            TextSegment(text: "我没有", isImportant: false),
            TextSegment(text: "摆烂", isImportant: true),
            TextSegment(text: "的预算。", isImportant: false)
        ]),
        Quote(text: "我拒绝无薪野心。", mode: .makeMoney, number: 5, segments: [
            TextSegment(text: "我拒绝", isImportant: false),
            TextSegment(text: "无薪", isImportant: true),
            TextSegment(text: "野心。", isImportant: false)
        ]),
        Quote(text: "野心落地的声音，是到账。", mode: .makeMoney, number: 6, segments: [
            TextSegment(text: "野心", isImportant: true),
            TextSegment(text: "落地的声音，是", isImportant: false),
            TextSegment(text: "到账", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "情绪要管理，收入也一样。", mode: .makeMoney, number: 7, segments: [
            TextSegment(text: "情绪", isImportant: true),
            TextSegment(text: "要管理，", isImportant: false),
            TextSegment(text: "收入", isImportant: true),
            TextSegment(text: "也一样。", isImportant: false)
        ]),
        Quote(text: "生气不如赚钱快。", mode: .makeMoney, number: 8, segments: [
            TextSegment(text: "生气", isImportant: false),
            TextSegment(text: "不如", isImportant: false),
            TextSegment(text: "赚钱", isImportant: true),
            TextSegment(text: "快。", isImportant: false)
        ]),
        Quote(text: "我值几个零，心里有数。", mode: .makeMoney, number: 9, segments: [
            TextSegment(text: "我值", isImportant: false),
            TextSegment(text: "几个零", isImportant: true),
            TextSegment(text: "，", isImportant: false),
            TextSegment(text: "心里有数", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "我不是野路子，是野心有路子。", mode: .makeMoney, number: 10, segments: [
            TextSegment(text: "我不是野路子，是", isImportant: false),
            TextSegment(text: "野心", isImportant: true),
            TextSegment(text: "有路子。", isImportant: false)
        ]),
        Quote(text: "钱给我安全感，也给我退路。", mode: .makeMoney, number: 11, segments: [
            TextSegment(text: "钱", isImportant: true),
            TextSegment(text: "给我", isImportant: false),
            TextSegment(text: "安全感", isImportant: true),
            TextSegment(text: "，也给我", isImportant: false),
            TextSegment(text: "退路", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "自信靠积累，底气靠存款。", mode: .makeMoney, number: 12, segments: [
            TextSegment(text: "自信", isImportant: true),
            TextSegment(text: "靠积累，", isImportant: false),
            TextSegment(text: "底气", isImportant: true),
            TextSegment(text: "靠存款。", isImportant: false)
        ]),
        Quote(text: "穿得起想穿的，住得起想住的。", mode: .makeMoney, number: 13, segments: [
            TextSegment(text: "穿得起", isImportant: true),
            TextSegment(text: "想穿的，", isImportant: false),
            TextSegment(text: "住得起", isImportant: true),
            TextSegment(text: "想住的。", isImportant: false)
        ]),
        Quote(text: "外表淡定，账户火热。", mode: .makeMoney, number: 14, segments: [
            TextSegment(text: "外表", isImportant: false),
            TextSegment(text: "淡定", isImportant: true),
            TextSegment(text: "，", isImportant: false),
            TextSegment(text: "账户", isImportant: true),
            TextSegment(text: "火热。", isImportant: false)
        ]),
        Quote(text: "低调做事，默默搞钱。", mode: .makeMoney, number: 15, segments: [
            TextSegment(text: "低调", isImportant: true),
            TextSegment(text: "做事，", isImportant: false),
            TextSegment(text: "默默", isImportant: true),
            TextSegment(text: "搞钱。", isImportant: false)
        ]),
        Quote(text: "我只对结果动心。", mode: .makeMoney, number: 16, segments: [
            TextSegment(text: "我只对", isImportant: false),
            TextSegment(text: "结果", isImportant: true),
            TextSegment(text: "动心。", isImportant: false)
        ]),
        Quote(text: "你喜欢内耗，我喜欢回报率。", mode: .makeMoney, number: 17, segments: [
            TextSegment(text: "你喜欢", isImportant: false),
            TextSegment(text: "内耗", isImportant: true),
            TextSegment(text: "，我喜欢", isImportant: false),
            TextSegment(text: "回报率", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "赢，不需要通知全世界。", mode: .makeMoney, number: 18, segments: [
            TextSegment(text: "赢", isImportant: true),
            TextSegment(text: "，不需要通知全世界。", isImportant: false)
        ]),
        Quote(text: "表面柔软，内里精算。", mode: .makeMoney, number: 19, segments: [
            TextSegment(text: "表面", isImportant: false),
            TextSegment(text: "柔软", isImportant: true),
            TextSegment(text: "，内里", isImportant: false),
            TextSegment(text: "精算", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "我搞钱，不搞情绪波动。", mode: .makeMoney, number: 20, segments: [
            TextSegment(text: "我", isImportant: false),
            TextSegment(text: "搞钱", isImportant: true),
            TextSegment(text: "，不搞", isImportant: false),
            TextSegment(text: "情绪波动", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        
        // 我要好运 (20条示例)
        Quote(text: "结果比你想象中更好。", mode: .goodLuck, number: 1, segments: [
            TextSegment(text: "结果", isImportant: true),
            TextSegment(text: "比你想象中", isImportant: false),
            TextSegment(text: "更好", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "转折，正在悄悄向你靠近。", mode: .goodLuck, number: 2, segments: [
            TextSegment(text: "转折", isImportant: true),
            TextSegment(text: "，正在悄悄向你", isImportant: false),
            TextSegment(text: "靠近", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "错过的是考验，来的是好运。", mode: .goodLuck, number: 3, segments: [
            TextSegment(text: "错过的是", isImportant: false),
            TextSegment(text: "考验", isImportant: true),
            TextSegment(text: "，来的是", isImportant: false),
            TextSegment(text: "好运", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "宇宙从不缺席，只是暂时沉默。", mode: .goodLuck, number: 4, segments: [
            TextSegment(text: "宇宙", isImportant: true),
            TextSegment(text: "从不缺席，只是暂时", isImportant: false),
            TextSegment(text: "沉默", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "当你放下控制，幸运才开始工作。", mode: .goodLuck, number: 5, segments: [
            TextSegment(text: "当你", isImportant: false),
            TextSegment(text: "放下", isImportant: true),
            TextSegment(text: "控制，", isImportant: false),
            TextSegment(text: "幸运", isImportant: true),
            TextSegment(text: "才开始工作。", isImportant: false)
        ]),
        Quote(text: "所有美好的事物，正在加速奔向你。", mode: .goodLuck, number: 6, segments: [
            TextSegment(text: "所有", isImportant: false),
            TextSegment(text: "美好", isImportant: true),
            TextSegment(text: "的事物，正在", isImportant: false),
            TextSegment(text: "奔向你", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "你的名字，正在被好运记住。", mode: .goodLuck, number: 7, segments: [
            TextSegment(text: "你的", isImportant: false),
            TextSegment(text: "名字", isImportant: true),
            TextSegment(text: "，正在被", isImportant: false),
            TextSegment(text: "好运", isImportant: true),
            TextSegment(text: "记住。", isImportant: false)
        ]),
        Quote(text: "延迟的回应，也在路上了。", mode: .goodLuck, number: 8, segments: [
            TextSegment(text: "延迟的", isImportant: false),
            TextSegment(text: "回应", isImportant: true),
            TextSegment(text: "，也在", isImportant: false),
            TextSegment(text: "路上", isImportant: true),
            TextSegment(text: "了。", isImportant: false)
        ]),
        Quote(text: "等你准备好，礼物就会来。", mode: .goodLuck, number: 9, segments: [
            TextSegment(text: "等你", isImportant: false),
            TextSegment(text: "准备好", isImportant: true),
            TextSegment(text: "，", isImportant: false),
            TextSegment(text: "礼物", isImportant: true),
            TextSegment(text: "就会来。", isImportant: false)
        ]),
        Quote(text: "命运正在悄悄偏向你这一边。", mode: .goodLuck, number: 10, segments: [
            TextSegment(text: "命运", isImportant: true),
            TextSegment(text: "正在悄悄", isImportant: false),
            TextSegment(text: "偏向你", isImportant: true),
            TextSegment(text: "这一边。", isImportant: false)
        ]),
        Quote(text: "你正在变成值得被好运追上的人。", mode: .goodLuck, number: 11, segments: [
            TextSegment(text: "你正在变成值得被", isImportant: false),
            TextSegment(text: "好运", isImportant: true),
            TextSegment(text: "追上的人。", isImportant: false)
        ]),
        Quote(text: "你的光，会被看见。", mode: .goodLuck, number: 12, segments: [
            TextSegment(text: "你的", isImportant: false),
            TextSegment(text: "光", isImportant: true),
            TextSegment(text: "，会被", isImportant: false),
            TextSegment(text: "看见", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "接下来，是属于你的回合。", mode: .goodLuck, number: 13, segments: [
            TextSegment(text: "接下来，是属于你的", isImportant: false),
            TextSegment(text: "回合", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "别急，好事会按时到来。", mode: .goodLuck, number: 14, segments: [
            TextSegment(text: "别急，", isImportant: false),
            TextSegment(text: "好事", isImportant: true),
            TextSegment(text: "会", isImportant: false),
            TextSegment(text: "按时到来", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "一切都在酝酿最适合你的节奏。", mode: .goodLuck, number: 15, segments: [
            TextSegment(text: "一切都在酝酿最适合你的", isImportant: false),
            TextSegment(text: "节奏", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "你以为是结尾，其实是转场。", mode: .goodLuck, number: 16, segments: [
            TextSegment(text: "你以为是", isImportant: false),
            TextSegment(text: "结尾", isImportant: true),
            TextSegment(text: "，其实是", isImportant: false),
            TextSegment(text: "转场", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "你想要的生活，也在找你。", mode: .goodLuck, number: 17, segments: [
            TextSegment(text: "你想要的", isImportant: false),
            TextSegment(text: "生活", isImportant: true),
            TextSegment(text: "，也在", isImportant: false),
            TextSegment(text: "找你", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "所有的等待，都会被回应。", mode: .goodLuck, number: 18, segments: [
            TextSegment(text: "所有的", isImportant: false),
            TextSegment(text: "等待", isImportant: true),
            TextSegment(text: "，都会被", isImportant: false),
            TextSegment(text: "回应", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ]),
        Quote(text: "没有白走的路，每一步都算数。", mode: .goodLuck, number: 19, segments: [
            TextSegment(text: "没有白走的", isImportant: false),
            TextSegment(text: "路", isImportant: true),
            TextSegment(text: "，", isImportant: false),
            TextSegment(text: "每一步", isImportant: true),
            TextSegment(text: "都算数。", isImportant: false)
        ]),
        Quote(text: "好运不是突然，是刚刚好。", mode: .goodLuck, number: 20, segments: [
            TextSegment(text: "好运", isImportant: true),
            TextSegment(text: "不是突然，是", isImportant: false),
            TextSegment(text: "刚刚好", isImportant: true),
            TextSegment(text: "。", isImportant: false)
        ])
    ]
    
    private init() {}
    
    func getRandomQuote(for mode: Mode? = nil) -> Quote {
        let filteredQuotes: [Quote]
        if let mode = mode {
            filteredQuotes = quotes.filter { $0.mode == mode }
        } else {
            // 如果没有指定模式，使用当前选中的模式
            let selectedMode = SettingsManager.shared.selectedMode
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
