//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander A on 1.09.24.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["😂", "😎", "🥳" ,"👿" ,"😺" ,"✌️" ,"😽" ,"😷"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 16) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return  emojis[pairIndex]
            } else {
                return "🦄"
            }
        }
    }
    
  @Published private var model = createMemoryGame()
    
  
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
