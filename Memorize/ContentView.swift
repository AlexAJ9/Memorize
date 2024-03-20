//
//  ContentView.swift
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

struct ContentView: View {
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
                cards
            }
            Spacer()
            themeChosers
        }.padding()
    }
    
    var cards: some View {
        var shuffeledEmojis = currentThemeEmojis + currentThemeEmojis
        shuffeledEmojis.shuffle()
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            
            ForEach(0..<numberOfCards, id:\.self){ index in
                CardView(content: shuffeledEmojis[index]).aspectRatio(2/3, contentMode: .fit)
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
    let content: String
    @State var isFaceUp = false
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
           
        }.onTapGesture{
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


