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
    
    @IBOutlet weak var imgPlayerCard1: UIImageView!
    @IBOutlet weak var imgPlayerCard2: UIImageView!
    
    @IBOutlet weak var imgPlayerCard3: UIImageView!
    @IBOutlet weak var imgPlayerCard4: UIImageView!
    
    @IBOutlet weak var myPoints: UILabel!
    @IBOutlet weak var houseCardTotal: UILabel!
    @IBOutlet weak var myCardTotal: UILabel!
    
    @IBOutlet weak var buttonHit: UIButton!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonStay: UIButton!
    @IBOutlet weak var buttonNameChange: UIButton!
    
    @IBOutlet weak var nameLabel_game: UILabel!
    
    var points = 0;
    var houseTotal = 0;
    var playerTotal = 0;
    
    var houseCount = 0;
    var playerCount = 0;
    
    var turn = true;
    
    var houseDeck: [String] = [];
    var playerDeck: [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    @IBOutlet weak var testlbl: UILabel!
    
    
    @IBAction func buttonPressed_start(_ sender: UIButton) {

        houseDeck = createDeck();
        playerDeck = createDeck();
        
        imgHouseCard2.image = UIImage(named: "\(randomCard(deck: houseDeck)).png");
        
        imgPlayerCard2.image = UIImage(named: "\(randomCard(deck: playerDeck)).png");
        imgPlayerCard1.image = UIImage(named: "\(randomCard(deck: playerDeck)).png");
        
    }
    
    @IBAction func buttonPressed_hit(_ sender: UIButton) {
        if turn == true && playerCount < 3 {
            imgPlayerCard3.image = UIImage(named: "\(randomCard(deck: playerDeck)).png");
            playerCount += 1;
            turn = false;
        } else if turn == false && playerCount < 3 {
            imgPlayerCard4.image = UIImage(named: "\(randomCard(deck: playerDeck)).png");
            playerCount += 1;
            turn = true;
        }
    }
    
    
    @IBAction func buttonPressed_stay(_ sender: UIButton) {
        if turn == true && houseCount < 3 {
            imgHouseCard3.image = UIImage(named: "\(randomCard(deck: houseDeck)).png");
            houseCount += 1;
            turn = false;
        } else if turn == false && houseCount < 3 {
            imgHouseCard4.image = UIImage(named: "\(randomCard(deck: playerDeck)).png");
            houseCount += 1;
            turn = true;
        }
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
    
    func createDeck() -> [String] {
        let suits = ["Spades", "Hearts", "Clubs", "Diamonds"];
        
        var blankDeck: [String] = [];
        
        for suit in suits {
            for rank in 1...13{
                let newCard = suit + String(rank);
                blankDeck.append(newCard);
            }
        }
        return blankDeck;
    }
    
    
    func randomCard(deck: [String]) -> String {
        let randomNum = Int.random(in: 0...12);
        return deck[randomNum];
    }


}




