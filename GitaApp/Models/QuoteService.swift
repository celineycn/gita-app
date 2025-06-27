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
        Quote(text: "You have the right to perform your prescribed duty, but you are not entitled to the fruits of action. Never consider yourself to be the cause of the results of your activities, and never be attached to not doing your duty.", chapter: 2, verse: 47),
        
        Quote(text: "As a person puts on new garments, giving up old ones, the soul similarly accepts new material bodies, giving up the old and useless ones.", chapter: 2, verse: 22),
        
        Quote(text: "For the soul there is neither birth nor death. It is not slain when the body is slain.", chapter: 2, verse: 20),
        
        Quote(text: "One who sees inaction in action, and action in inaction, is intelligent among men, and he is in the transcendental position, although engaged in all sorts of activities.", chapter: 4, verse: 18),
        
        Quote(text: "Abandon all varieties of religion and just surrender unto Me. I shall deliver you from all sinful reactions. Do not fear.", chapter: 18, verse: 66),
        
        Quote(text: "The mind is restless, turbulent, obstinate and very strong, O Krishna, and to subdue it, I think, is more difficult than controlling the wind.", chapter: 6, verse: 34),
        
        Quote(text: "One is considered to be in full knowledge whose every endeavor is devoid of desire for sense gratification. He is said by sages to be a worker for whom the reactions of work have been burned up by the fire of perfect knowledge.", chapter: 4, verse: 19),
        
        Quote(text: "Set thy heart upon thy work, but never on its reward. Work not for a reward; but never cease to do thy work.", chapter: 2, verse: 47),
        
        Quote(text: "Those who are motivated only by desire for the fruits of action are miserable, for they are constantly anxious about the results of what they do.", chapter: 2, verse: 49),
        
        Quote(text: "A gift is pure when it is given from the heart to the right person at the right time and at the right place, and when we expect nothing in return.", chapter: 17, verse: 20)
    ]
    
    private init() {}
    
    func getRandomQuote() -> Quote {
        return quotes.randomElement() ?? quotes[0]
    }
    
    func getAllQuotes() -> [Quote] {
        return quotes
    }
}