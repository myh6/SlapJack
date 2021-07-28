//
//  ViewController.swift
//  SlapJack
//
//  Created by curry敏 on 2021/7/25.
//

import UIKit
import Lottie

class SlapjackViewController: UIViewController {

    @IBOutlet var cardView: [UIView]!
    @IBOutlet var cardSuit: [UILabel]!
    @IBOutlet var cardRank: [UILabel]!
    @IBOutlet var dealerView: [UIView]!
    @IBOutlet var dealerSuit: [UILabel]!
    @IBOutlet var dealerRank: [UILabel]!
    @IBOutlet weak var slapJack: UILabel!
    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var jimmyword: UILabel!
    
    private var cardValue: Int {
        get {
            switch cardRank[playerRounds].text {
            case "J":
                return 10
            case "Q":
                return 10
            case "K":
                return 10
            default:
                return Int(cardRank[playerRounds].text!)!
            }
        } set {
            cardRank[playerRounds].text = String(newValue)
        }
    }
    
    private var dealerCardValue: Int {
        get {
            switch dealerRank[dealerRounds].text {
            case "J":
                return 10
            case "Q":
                return 10
            case "K":
                return 10
            default:
                return Int(dealerRank[dealerRounds].text!)!
            }
        } set {
            dealerRank[dealerRounds].text = String(newValue)
        }
    }
    
    private let animationView = AnimationView()
    private var cards = Cards.createDeck()
    private var playerRounds = 0
    private var dealerRounds = 0
    private var play = Players()
    private var dealer = Dealers()
    private var playerisDone = false
    private var gameisEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //plyer draws the first card
        drawCard()
        cardView[playerRounds].isHidden = false
        for i in (1...4) {
            cardView[i].isHidden = true
        }
        
        //dealer draws the first card
        for i in 0...1 {
            dealerView[i].isHidden = false
            dealerDrawCard()
        }
        dealerView[0].backgroundColor = dealerSuit[0].textColor
        for i in (2...4) {
            dealerView[i].isHidden = true
        }

    }
    
//MARK: - Draw Card function for player
    func drawCard() {
        
        let newCard = Cards.drawACard(deck: cards)
        let newCardID = cards.firstIndex(where: {$0 == newCard})
        print(newCard)
        if newCard.suits == Suit.heart {
            cardSuit[playerRounds].textColor = UIColor.red
            cardRank[playerRounds].textColor = UIColor.red
            cardSuit[playerRounds].text = newCard.suits.rawValue
            cardRank[playerRounds].text = newCard.ranks.rawValue
        } else if newCard.suits == Suit.diamond {
            cardSuit[playerRounds].textColor = UIColor.red
            cardRank[playerRounds].textColor = UIColor.red
            cardSuit[playerRounds].text = newCard.suits.rawValue
            cardRank[playerRounds].text = newCard.ranks.rawValue
        } else {
            cardRank[playerRounds].textColor = UIColor.black
            cardSuit[playerRounds].textColor = UIColor.black
            cardSuit[playerRounds].text = newCard.suits.rawValue
            cardRank[playerRounds].text = newCard.ranks.rawValue
        }
        
        print("you draw: \(cardValue)")
        let result = play.calculation(inputnumber: cardValue)
        print("player sum: \(result)")
        cards.remove(at: Int(newCardID!))
        //print("remaining cards in deck: \(cards.count)")
        if result > 21 {
            gameisEnded = true
            slapJack.text = "You got slapped!🖐"
            print("dealer:\(dealer.dealerTotal)you:\(play.numberTotal).You lose")
            jimmyword.text = "It's so great having you on the show."
        } else if result == 21 {
            slapJack.text = "You won. Slap Jimmy!🖐"
            jimmyword.text = "Ahhhhhhhhh"
            gameisEnded = true
            print("dealer:\(dealer.dealerTotal)you:\(play.numberTotal).You won")
            playerWon()
        }
    }
    
    //MARK: - Draw Card function for Dealer
    func dealerDrawCard() {
        
        dealerView[dealerRounds].isHidden = false

        let newCard = Cards.drawACard(deck: cards)
        let newCardID = cards.firstIndex(where: {$0 == newCard})
        print(newCard)
        if newCard.suits == Suit.heart {
            dealerSuit[dealerRounds].textColor = UIColor.red
            dealerRank[dealerRounds].textColor = UIColor.red
            dealerSuit[dealerRounds].text = newCard.suits.rawValue
            dealerRank[dealerRounds].text = newCard.ranks.rawValue
        } else if newCard.suits == Suit.diamond {
            dealerSuit[dealerRounds].textColor = UIColor.red
            dealerRank[dealerRounds].textColor = UIColor.red
            dealerSuit[dealerRounds].text = newCard.suits.rawValue
            dealerRank[dealerRounds].text = newCard.ranks.rawValue
        } else {
            dealerRank[dealerRounds].textColor = UIColor.black
            dealerSuit[dealerRounds].textColor = UIColor.black
            dealerSuit[dealerRounds].text = newCard.suits.rawValue
            dealerRank[dealerRounds].text = newCard.ranks.rawValue
        }
        
        print("dealer draw: \(dealerCardValue)")
        let result = dealer.calculateDealer(inputN: dealerCardValue)
        print("dealer sum: \(result)")
        cards.remove(at: Int(newCardID!))
        
        if dealerRounds < 4 {
            dealerRounds += 1
        }
        
        //print("remaining cards in deck: \(cards.count)")
    }
    
    //MARK: - Hit Me
    @IBAction func hitMePressed(_ sender: UIButton) {
        playerRounds += 1
        cardView[playerRounds].isHidden = false
        drawCard()
    }
    
    //MARK: - Stay
    @IBAction func stayPressed(_ sender: UIButton) {
        playerisDone = true
        hitMeButton.isEnabled = false
        hitMeButton.tintColor = UIColor.red
        print("Dealer's turn")
        dealerTurn()
    }
    
    //MARK: - Restart the game
    @IBAction func restart(_ sender: UIButton) {
        animationView.removeFromSuperview()
        hitMeButton.isEnabled = true
        hitMeButton.tintColor = UIColor.white
        gameisEnded = false
        playerisDone = false
        cards.shuffle()
        if cards.count < 10 {
            cards.removeAll()
            cards = Cards.createDeck()
            print("just update the deck")
        }
        playerRounds = 0
        dealerRounds = 0
        play.setNumber(0)
        dealer.setDealersN(0)
        dealer.hasOneOne = false
        play.hasEleven = false
        slapJack.text = "SlapJack"
        jimmyword.text = "Let's play SlapJack"
        for i in 0...1 {
            dealerView[i].isHidden = false
            dealerDrawCard()
        }
        dealerView[0].backgroundColor = dealerSuit[0].textColor
        for i in 2...4 {
            dealerView[i].isHidden = true
        }
        drawCard()
        cardView[playerRounds].isHidden = false
        for i in (1...4) {
            cardView[i].isHidden = true
        }
    }
    
    //MARK: - Dealer's turn
    func dealerTurn() {
        if playerisDone {
            dealerView[0].backgroundColor = UIColor.white
            while(!gameisEnded) {
                checkWhoWin()
            }
        }
    }
    
    func playerWon() {
        
        let anima = Animation.named("22314-slipper-smack")
        animationView.animation = anima
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFill
        animationView.frame = view.bounds
        animationView.frame = CGRect(x: 20, y: 20, width: 80, height: 80)
        view.addSubview(animationView)
        animationView.play(toProgress: 1, loopMode: .loop)
        //animationView.play()
    }
    
    func checkWhoWin() {
        
        if dealer.dealerTotal > 21 {
            slapJack.text = "You won. Slap Jimmy!🖐"
            gameisEnded = true
            print("dealer:\(dealer.dealerTotal)you:\(play.numberTotal). You won")
            jimmyword.text = "Ahhhhhhhhh"
            playerWon()
        } else if dealer.dealerTotal > play.numberTotal {
            slapJack.text = "You got slapped!🖐"
            jimmyword.text = "It's so great having you on the show."
            gameisEnded = true
            print("dealer:\(dealer.dealerTotal)you:\(play.numberTotal).You lose")
        } else if dealer.dealerTotal < play.numberTotal {
            dealerDrawCard()
        } else if dealer.dealerTotal == 21 {
            slapJack.text = "You got slapped!🖐"
            jimmyword.text = "It's so great having you on the show."
            gameisEnded = true
            print("dealer:\(dealer.dealerTotal)you:\(play.numberTotal).You lose")
        }
        else {
            //dealer's total is equal to the player
            slapJack.text = "You won. Slap Jimmy!🖐"
            jimmyword.text = "Ahhhhhhhhh"
            gameisEnded = true
            print("dealer:\(dealer.dealerTotal)you:\(play.numberTotal).You won")
            playerWon()
        }
    }
    
}

