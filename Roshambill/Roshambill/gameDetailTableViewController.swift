//
//  gameDetailTableViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/5/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit
import CoreData

class gameDetailTableViewController: UITableViewController {

    var game:NSManagedObject?
    
    var currentPlayer = 1
    
    var orderedGuesses:[Guess]{
        
        let theGame = game as? Game
        let guesses = theGame?.guess?.allObjects as! [Guess]
        
        var orderGuesses = [Guess]()
        var orderNum = 0
        
        for _ in guesses{
            for i in guesses{
                if(i.guessOrder == orderNum){
                    orderGuesses.append(i)
                    orderNum += 1
                }
            }
        }
        
        //print("ran")
        //print(orderGuesses.count)

        
        return orderGuesses
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 3
        }else{
            let theGame = game as? Game
            let guesses = theGame?.guess?.allObjects as! [Guess]
            
            return guesses.count
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "The Configuration"
        }else{
            return "The Guesses"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            
            let theGame = game as? Game
            //let guesses = theGame?.guess?.allObjects as! [Guess]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gameDetailCell", for: indexPath)
            
            if(indexPath.row == 0){
                cell.textLabel?.text = "Number to Guess: \(theGame?.guessNumber ?? 404)"
            }else if(indexPath.row == 1){
                cell.textLabel?.text = "Range: \(theGame?.lowRange ?? 404) - \(theGame?.highRange ?? 404)"
            }else if(indexPath.row == 2){
                cell.textLabel?.text = "Number of Players: \(theGame?.players ?? 404)"
            }
            
            return cell
            
            
        }else{
            
            let theGame = game as? Game

            let cell = tableView.dequeueReusableCell(withIdentifier: "gameDetailCell", for: indexPath)

            if(orderedGuesses[indexPath.row].guess != theGame?.guessNumber){
                cell.textLabel?.text = "Player \(orderedGuesses[indexPath.row].playerNum) Guessed: \(orderedGuesses[indexPath.row].guess)"
            }else{
                cell.textLabel?.text = "Player \(orderedGuesses[indexPath.row].playerNum) Wins: \(orderedGuesses[indexPath.row].guess)"
                
            }

            return cell
            
            
        }
        
        
    }

    
}
