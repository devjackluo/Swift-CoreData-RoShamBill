//
//  howManyViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/4/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit

class howManyViewController: UIViewController, UITextFieldDelegate {

    var lowNumber:Int?
    var highNumber:Int?
    var gameNumber:Int?
    
    @IBOutlet weak var hMPlayersTextField: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        if(!(Int(hMPlayersTextField.text!)! > 50 || Int(hMPlayersTextField.text!)! < 2)){
            self.performSegue(withIdentifier: "hMToPlay", sender: self)
        }
        
        
    }
    
    @IBAction func playerTextChanged(_ sender: UITextField) {
        
        guard Int(hMPlayersTextField.text!) != nil else{
            startButton.isHidden = true
            return
        }
        
        if(Int(hMPlayersTextField.text!)! > 50 || Int(hMPlayersTextField.text!)! < 2){
            startButton.isHidden = true
        }else{
            startButton.isHidden = false
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        hMPlayersTextField.delegate = self
        startButton.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "hMToPlay"){
            
            let dest = segue.destination as? playViewController
            
            //print(hMPlayersTextField.text!)
            
            dest?.hPlayers = Int(hMPlayersTextField.text!)
            
            //print(dest?.hPlayers)
            
            dest?.lowNumber = self.lowNumber
            dest?.highNumber = self.highNumber
            dest?.gameNumber = self.gameNumber

            //create data
            
            
            
            //pass data over
            
        }
        
        
    }
    

}
