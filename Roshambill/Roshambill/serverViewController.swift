//
//  serverViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/4/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit

class serverViewController: UIViewController, UITextFieldDelegate  {

    var lowNum:Int?
    var highNum:Int?
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var gameNumberTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if(!(Int(gameNumberTextField.text!)! > highNum! || Int(gameNumberTextField.text!)! < lowNum!)){
            self.performSegue(withIdentifier: "serverToHM", sender: self)
        }
        
    }
    
    
    @IBAction func changedServerText(_ sender: UITextField) {
        
        guard Int(gameNumberTextField.text!) != nil else{
            nextButton.isHidden = true
            return
        }
        
        if(Int(gameNumberTextField.text!)! > highNum! || Int(gameNumberTextField.text!)! < lowNum!){
            nextButton.isHidden = true
        }else{
            nextButton.isHidden = false
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

        gameNumberTextField.delegate = self
        
        nextButton.isHidden = true
        
        rangeLabel.text = "From: \(lowNum!) - \(highNum!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "serverToHM"){

            //TODO make sure game number is in range
            
            let dest = segue.destination as? howManyViewController
            dest?.highNumber = self.highNum
            dest?.lowNumber = self.lowNum
            dest?.gameNumber = Int(self.gameNumberTextField.text!)
        }
        
    }
    

}
