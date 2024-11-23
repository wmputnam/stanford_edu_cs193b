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
    var body: some View {
        HStack{
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View{
    @State var isFaceUp: Bool = false
    
    var body: some View {
        // type inference
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack {
            if isFaceUp{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("💥").font(.largeTitle)
            }
            else{
                base.fill()
            }
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
