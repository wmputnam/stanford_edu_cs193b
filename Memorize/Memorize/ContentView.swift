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
    let emojis: Array<String> = ["👻", "🎃", "🕷", "😈", "👾", "👁", "🧛🏼", "👺"]
    // @State不能在body里面声明，因为是用来管理View的状态
    // @State can't be declared in the body, because it's used to manage the state of the view
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardsCountAdjusters
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            // ... means includes 4, ..< means 4 is not include
            // we can use forEach(0..<4) or emojis.indices
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardsCountAdjusters: some View{
        HStack{
            cardRemover
            Spacer() // have space between
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View{
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View{
        return cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View{
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        // type inference
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture{
            isFaceUp.toggle() // for bool, f to t, t to f
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
