//
//  Cards.swift
//  SlapJack
//
//  Created by curry敏 on 2021/7/25.
//

import Foundation

enum Suit: String, CaseIterable {
    case spade = "♠"
    case heart = "♥"
    case diamond = "♦"
    case club = "♣"
}

enum Rank: String, CaseIterable {
    case ace = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case joker = "J"
    case queen = "Q"
    case king = "K"
}

struct Cards: Equatable {
    
    var ranks: Rank
    var suits: Suit
    
    static func createDeck() -> [Cards] {
        var deck = [Cards]()
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                deck.append(Cards(ranks: rank, suits: suit))
            }
        }
        return deck
    }
    
    static func drawACard(deck: [Cards]) -> Cards {
        let randnCard = deck.randomElement()
        return randnCard!
    }
}

