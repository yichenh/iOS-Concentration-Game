//
//  ViewController.swift
//  Concentration
//
//  Created by Yichen Hao on 6/12/18.
//  Copyright © 2018 Yichen Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: pairsOfCards, numberOfThemes: themes.count)
    
    var pairsOfCards: Int{
        get{
            return (cardButtons.count+1)/2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreBoard: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        //print("agh! A ghost!")
        if let cardNumber = cardButtons.index(of: sender){
            //print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2, numberOfThemes: themes.count)
        updateViewFromModel()
        themes = [["😃","😂","😍","😉","😚","🤪","😱","🤩","🤓","🙃"],["🐶","🐰","🦊","🐼","🐻","🐯","🦁","🐸","🐵","🐹"],["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],["🇦🇺","🇦🇷","🇨🇳","🇫🇷","🇩🇪","🇺🇸","🇨🇭","🇪🇸","🇷🇺","🇲🇽"],["🚗","🚕","🚌","🚎","🏎","🚓","🚲","🚠","🚞","🚄"],["🍎","🍊","🍋","🥝","🍑","🍈","🍍","🥑","🥦","🥒"]]
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreBoard.text = "Current Score: \(game.currentScore)"
    }
    
    private var themes = [["😃","😂","😍","😉","😚","🤪","😱","🤩","🤓","🙃"],["🐶","🐰","🦊","🐼","🐻","🐯","🦁","🐸","🐵","🐹"],["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],["🇦🇺","🇦🇷","🇨🇳","🇫🇷","🇩🇪","🇺🇸","🇨🇭","🇪🇸","🇷🇺","🇲🇽"],["🚗","🚕","🚌","🚎","🏎","🚓","🚲","🚠","🚞","🚄"],["🍎","🍊","🍋","🥝","🍑","🍈","🍍","🥑","🥦","🥒"]]
    private var emoji = Dictionary<Int,String>()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, themes[game.themeIndex].count > 0{
            //let randomIndex = Int(arc4random_uniform(UInt32(themes[game.themeIndex].count)))
            emoji[card.identifier] = themes[game.themeIndex].remove(at: themes[game.themeIndex].count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

