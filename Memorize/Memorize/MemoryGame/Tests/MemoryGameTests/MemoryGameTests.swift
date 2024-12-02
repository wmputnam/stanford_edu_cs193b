import Testing
@testable import MemoryGame
let onePair = 1
let fourPairs = 4
let NO_CARD = -1
let NO_MATCHES = 0
let ONE_PAIR_MATCHED = 2

@Suite("init MemoryGame",.serialized)
struct initMemoryGame {
    
    let numberOfPairs = fourPairs
    let currentGame = MemoryGame(fourPairs)
    
    init() {
//        currentGame.dumpDeck()
    }
    
    @Test("init MemoryGame: deck is not empty")
    func memoryGameInitDeck() async throws {
        #expect(!currentGame.deck.isEmpty)
    }
    
    @Test("init MemoryGame: deck count is numPairs * 2")
    func memoryGameInitDeckCount() async throws {
        #expect(currentGame.deck.count == numberOfPairs * 2)
    }
    
    @Test("init MemoryGame: number matched starts as 0")
    func memoryGameInitNumMatchedIsZero() async throws {
        #expect(currentGame.numMatched == NO_MATCHES)
    }
    
    @Test("init MemoryGame: card to match is not set (NO_CARD index)")
    func memoryGameInitCardToMatch() async throws {
        #expect(currentGame.lookingForMatch == NO_CARD)
    }
}

@Suite("MemoryGame first choose")
struct memoryGameFirstChoose {
    let numberOfPairs = fourPairs
    let currentGame = MemoryGame(fourPairs)
    let choice = 2
    
    init(){
        currentGame.choose(byPosition: choice)
    }
    
    @Test("MemoryGame first choose: number of matches remains 0")
    func memoryGameFirstChooseMatchedIsZero() async throws {
        #expect(currentGame.numMatched == NO_MATCHES)
    }
    
    @Test("MemoryGame first choose: number of face up cards is 1")
    func memoryGameFirstChooseOneFaceUpCard() async throws {
        let numFaceUp = currentGame.deck.reduce(0,
            { a, y in
            y.faceUp ? a + 1 : a
            })
        #expect(numFaceUp == 1)
    }
    
    @Test("MemoryGame first choose: card to match is set")
    func memoryGameFirstChooseCardToMatch() async throws {
        #expect(currentGame.lookingForMatch == choice)
    }

    @Test("MemoryGame first choose: face up card is the one chosen")
    func memoryGameFirstChooseFaceUpCardIsChosen() async throws {
        #expect(currentGame.deck[choice].faceUp)
    }
}

@Suite("MemoryGame second choose is match",.serialized)
struct memoryGameSecondChooseMatches {
    let numberOfPairs = fourPairs
    let currentGame = MemoryGame(fourPairs)
    let firstChoice = 0
    var secondChoice = -1
    
    init(){
        secondChoice = memoryGameSecondChooseMatches.findMatchingPair(currentGame.deck)
        currentGame.choose(byPosition: firstChoice)
        currentGame.choose(byPosition: secondChoice)
    }
    
    static func findMatchingPair(_ deck:[MemoryGame.Card]) -> Int {
        let valueToFind = deck[0].value;
        for idx in 1..<deck.count {
            if deck[idx].value == valueToFind {
                return idx
            }
        }
        return 0
    }
    
    @Test("MemoryGame second choose is match: number of matches increases by 2")
    func memoryGameSecondChoiceMatchedIsZero() async throws {
        #expect(currentGame.numMatched == ONE_PAIR_MATCHED)
    }
    
    @Test("MemoryGame second choose is match: number of face up cards increases by 2")
    func memoryGameSecondChoiceOneFaceUpCard() async throws {
        let numFaceUp = currentGame.deck.reduce(0,
            { a, y in
            y.faceUp ? a + 1 : a
            })
        #expect(numFaceUp == 2)
    }
    
    @Test("MemoryGame second choose is a match: card to match is reset (NO_CARD)")
    func memoryGameSecondChoiceCardToMatch() async throws {
        #expect(currentGame.lookingForMatch == NO_CARD)
    }

    @Test("MemoryGame second choose is match: face up cards are the ones chosen")
    func memoryGameSecondChoiceFaceUpCardIsChosen() async throws {
        #expect(currentGame.deck[firstChoice].faceUp)
        #expect(currentGame.deck[secondChoice].faceUp)
    }
}
@Suite("MemoryGame second choose is not a match")
struct memoryGameSecondChooseMisses {
    let numberOfPairs = fourPairs
    let currentGame = MemoryGame(fourPairs)
    let firstChoice = 2
    let secondChoice = 0
    
    init(){
        currentGame.choose(byPosition: firstChoice)
        currentGame.choose(byPosition: secondChoice)
    }
    
    @Test("MemoryGame second choose misses: number of matches remains unchanged")
    func memoryGameSecondChoiceMatchedIsZero() async throws {
        #expect(currentGame.numMatched == NO_MATCHES)
    }
    
    @Test("MemoryGame second choose misses: number of face up cards remains unchanged")
    func memoryGameSecondChoiceOneFaceUpCard() async throws {
        let numFaceUp = currentGame.deck.reduce(0,{ a, y in y.faceUp ? a + 1 : a})
        #expect(numFaceUp == 0)
    }
    
    @Test("MemoryGame second choose misses: card to match is reset")
    func memoryGameSecondChoiceCardToMatch() async throws {
        #expect(currentGame.lookingForMatch == NO_CARD)
    }

    @Test("MemoryGame second choose misses: cards chosen returned to face down")
    func memoryGameSecondChoiceFaceUpCardIsChosen() async throws {
        #expect(!currentGame.deck[firstChoice].faceUp)
        #expect(!currentGame.deck[secondChoice].faceUp)
    }
}
