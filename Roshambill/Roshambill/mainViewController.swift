//
//  mainViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/4/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    var lowestNumber = 25
    var highestNumber = 75
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue){
        if(segue.identifier == "settingToMain"){
            
           let source = segue.source as? settingTableViewController
            
            let lowNumber = source?.lowestNumber
            let highNumber = source?.highestNumber
            
            self.lowestNumber = lowNumber!
            self.highestNumber = highNumber!
            
            //print(lowestNumber!)
            //print(highestNumber!)
            
            
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "mainToServer"){
            let dest = segue.destination as? serverViewController
            dest?.highNum = self.highestNumber
            dest?.lowNum = self.lowestNumber
        }
        
    }
    

}
