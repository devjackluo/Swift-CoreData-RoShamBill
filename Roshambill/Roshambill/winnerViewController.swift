//
//  winnerViewController.swift
//  Roshambill
//
//  Created by Zhaowen Luo on 12/5/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit

class winnerViewController: UIViewController {
    
    var player: Int?
    var number: Int?
    
    @IBOutlet weak var winnerPlayerLabel: UILabel!
    @IBOutlet weak var winnerNumberLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerNumberLabel.text = "winning number: \(number!)"
        winnerPlayerLabel.text = "Player #\(player!) Wins!"
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
