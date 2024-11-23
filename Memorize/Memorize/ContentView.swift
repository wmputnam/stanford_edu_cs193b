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
    @State var emojis: Array<String> = ["👻", "🎃", "🕷", "😈", "👾", "👁", "🧛🏼", "👺"]
    @State var cardCount: Int = 16
    
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
                        .aspectRatio(2/3, contentMode: .fit)
                        .frame(width: width)
                }
            }
        }
        .foregroundColor(.orange)
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.title2)
            .bold()
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
        .imageScale(.medium)
        .font(.largeTitle)
    }
    
    var themesHalloween: some View {
        return themesAdjuster(by: "Halloween", symbol: "sun.max.trianglebadge.exclamationmark.fill")
    }
    
    var themesFood: some View {
        return themesAdjuster(by: "Food", symbol: "carrot")
    }
    var themesAnimal: some View {
        return themesAdjuster(by: "Animal", symbol: "pawprint")
    }
    var themesPeople: some View {
        return themesAdjuster(by: "People", symbol: "person")
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
            .foregroundColor(.orange)
        }
    }
    
    func emojisAdjuster(of theme: String){
        switch theme {
        case "Halloween":
            emojis = arrayAdjuster(emojisHalloween)
        case "People":
            emojis = arrayAdjuster(emojisPeople)
        case "Animal":
            emojis = arrayAdjuster(emojisAnimal)
        case "Food":
            emojis = arrayAdjuster(emojisAnimal)
        default:
            emojis = arrayAdjuster(emojisAnimal)
        }
    }
    
    func arrayAdjuster(_ emojisArray: Array<String>) -> Array<String>{
        cardCount = min(cardCount, emojisArray.count * 2)
        let afterShuffled = emojisArray.shuffled()
        let arraySliced = Array(afterShuffled.prefix(cardCount/2))
        let afterSliced = arraySliced + arraySliced
        return afterSliced.shuffled()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        // type inference
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.frame(width:10, height: 50)
            Group {
                base.foregroundColor(.white)
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
