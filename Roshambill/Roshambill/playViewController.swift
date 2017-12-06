//
//  playViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/4/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit
import CoreData

class playViewController: UIViewController, UITextFieldDelegate {

    var guessOrder = 0
    var lowNumber:Int?
    var highNumber:Int?
    var gameNumber:Int?
    var hPlayers:Int?
    var dynamicLowNumber:Int?
    var dynamicHighNumber:Int?
    var currentPlayer = 1
    
    var gameToUpdate: NSManagedObject?
    //var guesses: NSSet?
    
    @IBOutlet weak var currentRangeLabel: UILabel!
    @IBOutlet weak var whichPlayerLabel: UILabel!
    @IBOutlet weak var playerChoiceTextField: UITextField!
    
    @IBOutlet weak var prayButton: UIButton!
    @IBOutlet weak var serverSaysLabel: UILabel!
    
    
    @IBAction func guessTextChanged(_ sender: Any) {
        guard Int(playerChoiceTextField.text!) != nil else{
            prayButton.isHidden = true
            return
        }
        
        if(Int(playerChoiceTextField.text!)! > dynamicHighNumber! || Int(playerChoiceTextField.text!)! < dynamicLowNumber!){
            prayButton.isHidden = true
        }else{
            prayButton.isHidden = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    
    @IBAction func prayButtonTapped(_ sender: Any) {
        addGuessToGame(gameOb: gameToUpdate!, guessValue: Int(playerChoiceTextField.text!)!)
        //print(gameToUpdate!)
    }
    
 
    func setupGame(){
        
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //2
        let context = appDelegate.persistentContainer.viewContext
        
        //3
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: context)
        
        //4
        let gameO = NSManagedObject(entity: entity!, insertInto: context)
        
        //5
        gameO.setValue(Date(), forKeyPath: "date")
        gameO.setValue(self.gameNumber, forKeyPath: "guessNumber")
        gameO.setValue(self.highNumber, forKeyPath: "highRange")
        gameO.setValue(self.lowNumber, forKeyPath: "lowRange")
        gameO.setValue(self.hPlayers, forKeyPath: "players")
        
        
        do{
            //6
            try context.save()
            gameToUpdate = gameO
            
        }catch let error as NSError {
            print("Error - \(error)")
        }
        
        self.dynamicLowNumber = self.lowNumber
        self.dynamicHighNumber = self.highNumber
        
        currentRangeLabel.text = "Current Range: \(dynamicLowNumber!) - \(dynamicHighNumber!)"
        
        //print("called game creation")
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerChoiceTextField.delegate = self

        prayButton.isHidden = true
        

        setupGame()
        
        
    }
    
    
    
    func addGuessToGame(gameOb:NSManagedObject, guessValue:Int){
        
        if(Int64(currentPlayer) > hPlayers!){
            currentPlayer = 1
        }
        
        
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //2
        let context = appDelegate.persistentContainer.viewContext
        
        //3
        let guessentity = NSEntityDescription.entity(forEntityName: "Guess", in: context)
        
        //4
        let guessO = NSManagedObject(entity: guessentity!, insertInto: context)
        
        //5
        guessO.setValue(guessValue, forKey: "guess")
        guessO.setValue(gameOb, forKey: "game")
        guessO.setValue(guessOrder, forKey: "guessOrder")
        guessO.setValue(currentPlayer, forKey: "playerNum")
        
        self.guessOrder += 1
        
        do{
            //6
            try context.save()
        }catch let error as NSError {
            print("Error - \(error)")
        }
        
        
        if(guessValue == self.gameNumber){
            self.performSegue(withIdentifier: "winnerSegue", sender: nil)
            return
        }
        
        currentPlayer += 1
        

        
        if(guessValue > self.gameNumber!){
            
            serverSaysLabel.text = "Server Says: Lower"
            self.dynamicHighNumber = guessValue-1
            currentRangeLabel.text = "Current Range: \(dynamicLowNumber!) - \(dynamicHighNumber!)"
            whichPlayerLabel.text = "Player #\(currentPlayer) Picking Number..."
            playerChoiceTextField.text = ""
            prayButton.isHidden = true
            
        }else if(guessValue < self.gameNumber!){
            
            serverSaysLabel.text = "Server Says: Higher"
            self.dynamicLowNumber = guessValue+1
            currentRangeLabel.text = "Current Range: \(dynamicLowNumber!) - \(dynamicHighNumber!)"
            whichPlayerLabel.text = "Player #\(currentPlayer) Picking Number..."
            playerChoiceTextField.text = ""
            prayButton.isHidden = true
            
        }
        

        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "winnerSegue"){
            let dest = segue.destination as? winnerViewController
            dest?.player = currentPlayer
            dest?.number = gameNumber!
        }else{
            

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return
            }

            let context = appDelegate.persistentContainer.viewContext

            context.delete(gameToUpdate!)

            do{
                try context.save()
            }catch let error as NSError{
                print("error - \(error)")
            }
            
        }
        
        
        
    }
    

}
