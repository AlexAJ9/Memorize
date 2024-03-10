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
struct ContentView: View {
    @State var currentTheme: Theme = Theme.halloween
    
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(currentThemeEmojis.indices, id:\.self){ index in
                CardView(content: currentThemeEmojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
    var themeChosers: some View {
        HStack {
            AnimalThemeButton
            Spacer()
            VehiclesThemeButton
            Spacer()
            EmojisThemeButton
        }.imageScale(.large).font(.largeTitle).padding()
    }
    
    func themeChoserButton(theme: Theme, symbol: String) -> some View {
        Button(action: {
            currentTheme = theme
        }, label: {
            Image(systemName: symbol)
        })
    }
    
    var AnimalThemeButton: some View {
        themeChoserButton(theme: Theme.animals, symbol: "hare.fill")
    }
    
    var VehiclesThemeButton: some View {
        themeChoserButton(theme: Theme.vehicles, symbol: "car.side.fill")
    }
    
    var EmojisThemeButton: some View {
        themeChoserButton(theme: Theme.halloween, symbol: "figure.run")
    }
    
}

struct CardView: View {
    let content:String
    @State  var isFaceUp = false
    
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


