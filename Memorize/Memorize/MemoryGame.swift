//
//  MemoryGame.swift
//  Memorize
//
//  Created by William Putnam on 11/29/24.
//

class MemoryGame {
    // state variables
    // number of pairs
    var numPairs:Int
    
    // card deck
    var deck: [Card]
    
    // number of pairs that are currently matched -- they are face up
    var numMatched = 0
    
    // unchecked displaying: 0:no cards, 1:one card, 2:two cards
//    var unCheckedFaceUp = 0
    
    var lookingForMatch = -1
    
    init(numPairs:Int){
        self.numPairs = numPairs;
        self.deck = MemoryGame.createDeck(numPairs)
    }
    
    /// choose card in game deck by offset
    /// - Parameter offset: position of card in deck
    func choose(byPosition offset:Int){
        if (0..<numPairs*2) ~= offset {
            if deck[offset].faceUp == false {
                if lookingForMatch > 0 {
                    deck[offset].faceUp = true
                    if deck[offset].value == deck[lookingForMatch].value {
                        celebrateMatch()
                    } else {
                        notMatch()
                        deck[offset].faceUp = false
                        deck[lookingForMatch].faceUp = false
                        lookingForMatch = -1
                    }
                } else {
                    lookingForMatch = offset
                    deck[offset].faceUp = true
                }
                //            switch unCheckedFaceUp {
                //            case 0:
                //                deck[offset].faceUp = true
                //            case 1:
                //                deck[offset].faceUp = true
                //                if deck[offset].value == deck[lookingForMatch].value {
                //                    celebrateMatch()
                //                } else {
                //                    notMatch()
                //                }
                //            default:
                //                pass()
                //            }
            } else {
                // no nothing
            }
        } else {
            fatalError("unable to choose card with offset \(offset)")
        }
    }
    
    struct Card {
        var faceUp = false;
        var value:Int
        
        init(_ value:Int){
            self.value = value
        }
    }
    
    static func createDeck(_ numPairs:Int) -> [Card]{
        var newDeck :[Card] = [Card]()
        for index in 0..<numPairs{
            newDeck.append(contentsOf: newPair(index))
        }
        return newDeck
    }
    
    static func newPair(_ value:Int) -> [Card] {
        var cardArray:[Card] = [Card]()
        cardArray[0] = Card(value)
        cardArray[1] = Card(value)
        return cardArray
    }
    
    func celebrateMatch(){
        numMatched += 2
//        unCheckedFaceUp = 0
        lookingForMatch = -1
    }
    
    func notMatch(){
//        unCheckedFaceUp = 0
    }
    
    func pass() {
        
    }
}


