//
//  Card.swift
//  Concentration
//
//  Created by Yichen Hao on 2018/6/23.
//  Copyright © 2018 Yichen Hao. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
        
        
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
