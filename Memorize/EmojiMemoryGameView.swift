//
//  EmojiMemoryGameVIew.swift
//  Memorize
//
//  Created by Alexander A on 2.03.24.
//

import SwiftUI

enum Theme {
    case halloween
    case animals
    case vehicles
}

func getNumbeOfCards() -> Int {
    Int.random(in: 4...16)
}

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var currentTheme: Theme = Theme.halloween
    @State var numberOfCards = getNumbeOfCards()
    
    let halloweenEmojis: [String] = ["😂", "😎", "🥳" ,"👿" ,"😺" ,"✌️" ,"😽" ,"😷"]
  
    let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐰", "🐯", "🐨", "🐻", "🦊"]

    let vehicleEmojis: [String] = ["🚗", "🚕", "🚂", "🚁", "🚀", "🚢", "🛴", "🛵"]
    

    var currentThemeEmojis: [String] {
        switch currentTheme {
        case .halloween:
            return halloweenEmojis
        case .animals:
            return animalEmojis
        case .vehicles:
            return vehicleEmojis
        }
    }

    var themeToColor: Color {
        switch currentTheme {
        case .halloween:
            return .orange
        case .animals:
            return .green
        case .vehicles:
            return .blue
        }
    }
    var body: some View {
        VStack {
            Text("Memorize!").font(.title).fontWeight(.semibold)
            ScrollView{
                cards.animation(.default, value: viewModel.cards)
            }
            Spacer()
            themeChosers
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }.padding()
    }
    
    var cards: some View {
        var shuffeledEmojis = currentThemeEmojis + currentThemeEmojis
        shuffeledEmojis.shuffle()
        var cardWidth: CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let padding: CGFloat = 16 // Adjust as needed
            let spacing: CGFloat = 8 // Adjust as needed
            let totalSpacing = padding + spacing // Total spacing on both sides of each card
            let availableWidth = screenWidth - totalSpacing // Available width for cards
            
            let minCardWidth: CGFloat = 60 // Minimum width for each card
            
            // Calculate the number of cards per row
            let numberOfColumns = max(1, Int((availableWidth + spacing) / (minCardWidth + spacing)))

            // Calculate the actual width for each card
            let cardWidth = (availableWidth - (CGFloat(numberOfColumns - 1) * spacing)) / CGFloat(numberOfColumns)
            
            return cardWidth
        }
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0) {
            
            ForEach(viewModel.cards) { card in
                CardView(card).aspectRatio(2/3, contentMode: .fit).padding(4).onTapGesture {
                    viewModel.choose(card)
                }
            }
        }.foregroundColor(themeToColor)
    }
    
    var themeChosers: some View {
        HStack {
            Spacer()
            AnimalThemeButton
            Spacer()
            VehiclesThemeButton
            Spacer()
            EmojisThemeButton
            Spacer()
        }.imageScale(.large).font(.largeTitle).padding()
    }
    
 
    func themeChoserButton(theme: Theme, symbol: String, text: String) -> some View {
            Button(action: {
                currentTheme = theme
                numberOfCards = getNumbeOfCards()
            }, label: {
                VStack {
                    Image(systemName: symbol)
                    Text(text).font(.caption)
                }
            })
    }
    
    var AnimalThemeButton: some View {
        themeChoserButton(theme: Theme.animals, symbol: "pawprint.circle", text: "Animal")
    }
    
    var VehiclesThemeButton: some View {
        themeChoserButton(theme: Theme.vehicles, symbol: "car.circle", text: "Vehicles")
    }
    
    var EmojisThemeButton: some View {
        themeChoserButton(theme: Theme.halloween, symbol: "person.circle", text: "Emojis")
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:2)
                Text(card.content).font(.system(size: 200)).minimumScaleFactor(0.01).aspectRatio(1,contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}


