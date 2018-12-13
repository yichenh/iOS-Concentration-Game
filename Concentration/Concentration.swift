//
//  Concentration.swift
//  Concentration
//
//  Created by Yichen Hao on 2018/6/23.
//  Copyright © 2018 Yichen Hao. All rights reserved.
//

import Foundation

struct Concentration{
    //MARK: Declare instance variables
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount: Int = 0
    var themeIndex: Int
    var currentScore: Int = 0
    
    //MARK: Constructor
    init(numberOfPairsOfCards: Int, numberOfThemes: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards:\(numberOfPairsOfCards): numberOfPairsOfCards is less than or equal to 0")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        self.themeIndex = Int(arc4random_uniform(UInt32(numberOfThemes)))
        //MARK: Shuffle the cards
        for _ in 1...numberOfPairsOfCards*10{
            let cardBeingShuffled = cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
            cards.append(cardBeingShuffled)
        }
    }
    
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index): Choose index not in the cards")
        if !cards[index].isMatched, !cards[index].isFaceUp{
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    currentScore += 2
                } else {
                    if cards[matchIndex].hasBeenSeen {currentScore -= 1}
                    if cards[index].hasBeenSeen {currentScore -= 1}
                }
                cards[index].isFaceUp = true
                cards[index].hasBeenSeen = true
                cards[matchIndex].hasBeenSeen = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                //cards[index].hasBeenSeen = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
