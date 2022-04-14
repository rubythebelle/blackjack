//
//  CreditViewController.swift
//  Blackjack
//
//  Created by RUBY on 13/04/2022.
//

import UIKit

class CreditViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var houseTableView: UITableView!;
    @IBOutlet weak var playerTableView: UITableView!;
    
    var cards = [] as NSArray;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        houseTableView.dataSource = self;
        houseTableView.delegate = self;
        
//        playerTableView.dataSource = self;
        playerTableView.delegate = self;
        
        cards = ["Spades", "Hearts", "Clubs", "Diamonds"];
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func houseTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count;
    }
    func playerTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count;
    }
    
    func houseTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = houseTableView.dequeueReusableCell(withIdentifier: "houseCell", for: indexPath);
        
        let cardimg1 = cell.viewWithTag(1) as! UIImageView;
        
        cardimg1.image = UIImage(named: "\(cards[indexPath.row]).png")
        
        let cardimg2 = cell.viewWithTag(2) as! UIImageView;
        
        cardimg2.image = UIImage(named: "\(cards[indexPath.row]).png")
        
        return cell;
    }

}
