//
//  gameHistoryTableViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/5/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit
import CoreData

class gameHistoryTableViewController: UITableViewController {
    
    var iRow = 0
    
    var allGames:[NSManagedObject]?
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func editButtonTapped(_ sender: Any) {
        if(allGames?.count == 0){
            return
        }else{
            
            tableView.isEditing = !tableView.isEditing
            
            if(tableView.isEditing){
                editButton.title = "Cancel"
            }else{
                editButton.title = "Edit"
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        //2
        let context = appDelegate?.persistentContainer.viewContext
        
        let gameFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        
        let sort = NSSortDescriptor(key: #keyPath(Game.date), ascending: true)
        
        gameFetch.sortDescriptors = [sort]
        
        
        let games = try! context?.fetch(gameFetch)
        
        
        self.allGames = games as? [NSManagedObject]
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //print(allGames)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGames!.count == 0 ? 1 : allGames!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(allGames?.count == 0){
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "notFoundCell", for: indexPath)
            cell.textLabel?.text = "No Games Found"
            return cell
            
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
            let game = allGames![indexPath.row] as! Game
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            
            cell.textLabel?.text = "Game #\(indexPath.row+1) - (\(game.players) players)"
            cell.detailTextLabel?.text = dateFormatter.string(from: game.date!)
            
            return cell
            
            
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if(cell?.tag != 1){
            self.iRow = indexPath.row
            self.performSegue(withIdentifier: "toDetailsSegue", sender: self)
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if(allGames!.count > 0){
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                    return
                }
                let context = appDelegate.persistentContainer.viewContext
                context.delete(allGames![indexPath.row])
                do{
                    try context.save()
                    
                    allGames?.remove(at: indexPath.row)
                    
                    if(allGames?.count == 0){
                        
                        DispatchQueue.main.async {
                            self.tableView.isEditing = false
                            self.editButton.title = "Edit"
                            self.editButton.isEnabled = false
                        }
                        
                    }

                    tableView.reloadData()
                }catch let error as NSError{
                    print("error - \(error)")
                }
            }
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "toDetailsSegue"){
            let dest = segue.destination as! gameDetailTableViewController
            dest.game = allGames?[self.iRow]
        }
        
    }
    
}
