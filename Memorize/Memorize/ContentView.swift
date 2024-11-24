//
//  ContentView.swift
//  Memorize
//
//  Created by William Putnam on 11/22/24.
//

import SwiftUI

struct ContentView: View {
    // VStack：up and down, vertical stack
    // HStack: side to side, horizontal
    // ZStack: direction towards the user
    // Array<String> same as [String]
    let emojisHalloween: Array<String> = ["👻", "🎃", "🕷", "😈", "👾", "👁", "🧛🏼", "👺"]
    let emojisPeople: Array<String> = ["👶🏻", "👧🏻", "💂🏻‍♀️", "👮🏻‍♀️", "👩🏻‍⚕️", "👩🏻‍🌾", "👩🏻‍💻", "👩🏻‍🎓"]
    let emojisFood: Array<String> = ["🥐", "🥯", "🥨", "🌯", "🥟", "🍨", "🍫", "🍲"]
    let emojisAnimal: Array<String> = ["🐶", "🦁", "🐷", "🦊", "🐰", "🐼", "🐵", "🐸"]
    
    // @State不能在body里面声明，因为是用来管理View的状态
    // translation -> a @State var cannot be declared in the body because it's used to manage the state of the view
    @State var activeTheme = "Food"
    @State static var cardCount: Int = 16
    @State var emojis: Array<String>
    
    init() {
        emojis = ContentView.arrayAdjuster(emojisFood)
    }
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            themesAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 4 - 8
            LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]){
                ForEach(emojis.indices, id: \.self){ index in
                    CardView(content: emojis[index])
                        .aspectRatio(3/4, contentMode: .fit)
                        .frame(width: width)
                }
            }
        }
        .foregroundStyle(.orange)
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.title2)
            .bold()
            .foregroundStyle(.blue)
    }
    
    var themesAdjusters: some View {
        HStack {
            themesHalloween
            Spacer()
            themesFood
            Spacer()
            themesAnimal
            Spacer()
            themesPeople
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var themesHalloween: some View {
        return themesAdjuster(by: "Halloween", symbol: activeTheme == "Halloween" ? "sun.max.trianglebadge.exclamationmark.fill" : "sun.max")
    }
    
    var themesFood: some View {
        return themesAdjuster(by: "Food", symbol: activeTheme == "Food" ? "carrot.fill" : "carrot")
    }
    var themesAnimal: some View {
        return themesAdjuster(by: "Animal", symbol: activeTheme == "Animal" ? "pawprint.fill" : "pawprint")
    }
    var themesPeople: some View {
        return themesAdjuster(by: "People", symbol: activeTheme == "People" ? "person.fill" : "person")
    }
    
    func themesAdjuster(by theme: String, symbol: String) -> some View {
        Button(action: {
            emojisAdjuster(of: theme)
        }){
            VStack {
                Image(systemName: symbol)
                    .font(.title)
                Text(theme)
                    .font(.caption)
            }
            .foregroundStyle(.blue)
        }
    }
    
    func emojisAdjuster(of theme: String){
        switch theme {
        case "Halloween":
            emojis = ContentView.arrayAdjuster(emojisHalloween)
        case "People":
            emojis = ContentView.arrayAdjuster(emojisPeople)
        case "Animal":
            emojis = ContentView.arrayAdjuster(emojisAnimal)
        case "Food":
            emojis = ContentView.arrayAdjuster(emojisFood)
        default:
            emojis = ContentView.arrayAdjuster(emojisAnimal)
        }
        activeTheme = theme
    }
    
    static func arrayAdjuster(_ emojisArray: Array<String>) -> Array<String>{
        cardCount = min(cardCount, emojisArray.count * 2)
        let afterShuffled = emojisArray.shuffled()
        // prefix method on the array returns a slice of the array (subsequence)
        let arraySliced = Array(afterShuffled.prefix(cardCount/2))
        let afterSliced = arraySliced + arraySliced
        return afterSliced.shuffled()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        // type inferred by compiler
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.frame(width:10, height: 50)
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle() // for bool, f to t, t to f
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
