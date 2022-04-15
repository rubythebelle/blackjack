//
//  GameViewController.swift
//  Blackjack
//
//  Created by RUBY on 13/04/2022.
//

import UIKit
import Foundation

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imgHouseCard1: UIImageView!
    @IBOutlet weak var imgHouseCard2: UIImageView!
    @IBOutlet weak var imgHouseCard3: UIImageView!
    @IBOutlet weak var imgHouseCard4: UIImageView!
    @IBOutlet weak var imgHouseCard5: UIImageView!
    @IBOutlet weak var imgHouseCard6: UIImageView!
    @IBOutlet weak var imgHouseCard7: UIImageView!
    @IBOutlet weak var imgHouseCard8: UIImageView!
    
    @IBOutlet weak var imgPlayerCard1: UIImageView!
    @IBOutlet weak var imgPlayerCard2: UIImageView!
    @IBOutlet weak var imgPlayerCard3: UIImageView!
    @IBOutlet weak var imgPlayerCard4: UIImageView!
    @IBOutlet weak var imgPlayerCard5: UIImageView!
    @IBOutlet weak var imgPlayerCard6: UIImageView!
    @IBOutlet weak var imgPlayerCard7: UIImageView!
    @IBOutlet weak var imgPlayerCard8: UIImageView!
    
    @IBOutlet weak var myPoints: UILabel!
    @IBOutlet weak var houseCardTotal: UILabel!
    @IBOutlet weak var myCardTotal: UILabel!
    
    @IBOutlet weak var buttonHit: UIButton!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonStay: UIButton!
    @IBOutlet weak var buttonNameChange: UIButton!
    
    @IBOutlet weak var nameLabel_game: UILabel!
    
    var imgHouseCards: [UIImageView] = [];
    var imgPlayerCards: [UIImageView] = [];
    
    var totalScore = 0;
    
    var housePoints = 0;
    var playerPoints = 0;
    
    var houseCardsDelt = 0;
    var playerCardsDelt = 0;
    
    var turn = true;
    
    var deck: [Int] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgHouseCards.append(imgHouseCard1);
        imgHouseCards.append(imgHouseCard2);
        imgHouseCards.append(imgHouseCard3);
        imgHouseCards.append(imgHouseCard4);
        imgHouseCards.append(imgHouseCard5);
        imgHouseCards.append(imgHouseCard6);
        imgHouseCards.append(imgHouseCard7);
        imgHouseCards.append(imgHouseCard8);
        
        imgPlayerCards.append(imgPlayerCard1);
        imgPlayerCards.append(imgPlayerCard2);
        imgPlayerCards.append(imgPlayerCard3);
        imgPlayerCards.append(imgPlayerCard4);
        imgPlayerCards.append(imgPlayerCard5);
        imgPlayerCards.append(imgPlayerCard6);
        imgPlayerCards.append(imgPlayerCard7);
        imgPlayerCards.append(imgPlayerCard8);
        
        buttonStay.isHidden = true;
        buttonHit.isHidden = true;
        buttonStart.isEnabled = true;
    }
    
    @IBOutlet weak var testlbl: UILabel!
    
    
    @IBAction func buttonPressed_start(_ sender: UIButton) {
        deck = createDeck();
        
        dealHouseCard();
        dealHouseCard();
        
        dealPlayerCard();
        dealPlayerCard();
        
        buttonStay.isHidden = false;
        buttonHit.isHidden = false;
        buttonStart.isEnabled = false;
    }
    
    @IBAction func buttonPressed_hit(_ sender: UIButton) {
        dealPlayerCard();
    }
    
    @IBAction func buttonPressed_stay(_ sender: UIButton) {
        var continueDraw = true;
        buttonHit.isHidden = true;
        
        repeat {
            continueDraw = dealHouseCard();
        } while(continueDraw);
    }
    
    @IBAction func buttonPressed_name(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Name", message: "", preferredStyle: .alert)
        alert.addTextField { (myTextField) in myTextField.placeholder = "Enter player's name."}
        
        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
            let userName = alert.textFields?[0].text;
                if userName == "" {
                    self.nameLabel_game.text = "Player1"
                } else {
                    self.nameLabel_game.text = userName;
            }
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in
             //code
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    private func buildDeck() -> [String]{
//        let suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
//
//    }
    
    func createDeck() -> [Int] {
        var blankDeck: [Int] = [];
        
        for suit in 0...3 {
            for rank in 1...13{
                // 001-013 - spades
                // 101-113 - hearts
                // 201-213 - clubs
                // 301-313 - diamonds
                blankDeck.append(suit*100 + rank);
            }
        }
        return blankDeck;
    }
    
    
    func randomCard() -> Int {
        return Int.random(in: 0...(deck.count - 1));
    }
    
    func getCardPoints(deckIndex: Int) -> Int {
        let cardID = deck[deckIndex];
        let suitID = cardID / 100;
        var cardPoints = cardID - suitID * 100;
        
        if (cardPoints > 10) {
            cardPoints = 10;
        }
        
        return cardPoints;
    }
    
    func getCardImage(deckIndex: Int) -> UIImage {
        let suits = ["Spades", "Hearts", "Clubs", "Diamonds"];
        var cardID = deck[deckIndex];
        let suitID = cardID / 100;
        
        cardID = cardID - suitID * 100;
        
        return UIImage(named: "\(suits[suitID])\(Int(cardID)).png")!;
    }
    
    func dealPlayerCard() {
        if (playerCardsDelt < 8) {
            let deckIndex = randomCard();
            
            imgPlayerCards[playerCardsDelt].image =  getCardImage(deckIndex: deckIndex);
            playerCardsDelt += 1;
            playerPoints += getCardPoints(deckIndex: deckIndex);
            
            deck.remove(at: deckIndex);
            myCardTotal.text = String(playerPoints);
            
            if (playerPoints >= 21) {
                finishGame();
            }
            
            if (playerCardsDelt == 8) {
                buttonHit.isEnabled = false;
            }
        }
    }
    
    func dealHouseCard() -> Bool {
        var continueDraw = true;
        
        if (houseCardsDelt < 8) {
            let deckIndex = randomCard();
            
            imgHouseCards[houseCardsDelt].image =  getCardImage(deckIndex: deckIndex);
            houseCardsDelt += 1;
            housePoints += getCardPoints(deckIndex: deckIndex);
            
            deck.remove(at: deckIndex);
            houseCardTotal.text = String(housePoints);
            
            if ((housePoints >= 21 && housePoints >= playerPoints) || (houseCardsDelt == 8)) {
                continueDraw = false;
                finishGame();
            }
        } else {
            continueDraw = false;
        }
        return continueDraw;
    }
    
    func finishGame() {
        var winnerName = "";
        let reward = 50;
        
        if (playerPoints > 21) {
            winnerName = "House";
            totalScore -= reward;
        } else if (playerPoints == 21) {
            winnerName = nameLabel_game.text!;
            totalScore += reward;
        } else if (housePoints > 21) {
            winnerName = nameLabel_game.text!;
            totalScore += reward;
        } else if (housePoints == 21) {
            winnerName = "House";
            totalScore -= reward;
        } else if (playerPoints > housePoints) {
            winnerName = nameLabel_game.text!;
            totalScore += reward;
        } else {
            winnerName = "House";
            totalScore -= reward;
        }
        
        myPoints.text = String(totalScore);
        
        let alert = UIAlertController(title: "Game finished", message: "\(winnerName) wins!!!", preferredStyle: .alert);
        let dismissAction = UIAlertAction(title: "Close", style: .default, handler: { action in
            self.resetGame();
        });
        alert.addAction(dismissAction);
        
        present(alert, animated:true, completion: nil);
    }
    
    func resetGame() {
        buttonStay.isHidden = true;
        buttonHit.isHidden = true;
        buttonStart.isEnabled = true;
        
        playerPoints = 0;
        housePoints = 0;
        playerCardsDelt = 0;
        houseCardsDelt = 0;
        
        myCardTotal.text = "0";
        houseCardTotal.text = "0";
        
        for i in 0...(imgPlayerCards.count - 1) {
            imgPlayerCards[i].image = nil;
        }
        for i in 0...(imgHouseCards.count - 1) {
            imgHouseCards[i].image = nil;
        }
        
        for i in 0...1 {
            imgPlayerCards[i].image = UIImage(named: "card_back.png");
        }
        for i in 0...1 {
            imgHouseCards[i].image = UIImage(named: "card_back.png");
        }
    }
}




