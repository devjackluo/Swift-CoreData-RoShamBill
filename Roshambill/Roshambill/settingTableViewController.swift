//
//  settingTableViewController.swift
//  Roshambill
//
//  Created by LUO ZHAOWEN on 12/4/17.
//  Copyright © 2017 Zhaowen Luo. All rights reserved.
//

import UIKit

class settingTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var lowestNumberLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    var pickerDataSource = ["1"]
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    var lowestNumber = 25
    var highestNumber = 75
    
    @IBOutlet weak var lowestNumberPicker: UIPickerView!
    
    @IBOutlet weak var endingNumberPicker: UIPickerView!
    
    @IBOutlet weak var highestNumberLabel: UILabel!
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1){
            lowestNumber = Int(pickerDataSource[row])!
            lowestNumberLabel.text = pickerDataSource[row]
            
            
            if(self.lowestNumber == 1000){
                
                lowestNumber = 999
                lowestNumberLabel.text = pickerDataSource[998]
                
                self.highestNumber = self.lowestNumber + 1
                self.highestNumberLabel.text = self.pickerDataSource[self.highestNumber-1]
                self.endingNumberPicker.selectRow(self.highestNumber-1, inComponent: 0, animated: true)
                self.lowestNumberPicker.selectRow(self.lowestNumber-1, inComponent: 0, animated: true)
                
            }else if(self.lowestNumber >= self.highestNumber){
                
                self.highestNumber = self.lowestNumber + 1
                self.highestNumberLabel.text = self.pickerDataSource[self.highestNumber-1]
                self.endingNumberPicker.selectRow(self.highestNumber-1, inComponent: 0, animated: true)
                
                
            }
            
            
        }else if(pickerView.tag == 2){
            
            highestNumber = Int(pickerDataSource[row])!
            highestNumberLabel.text = pickerDataSource[row]
            
            if(self.highestNumber == 1){
                
                highestNumber = 2
                highestNumberLabel.text = pickerDataSource[1]
                
                self.lowestNumber = self.highestNumber - 1
                self.lowestNumberLabel.text = self.pickerDataSource[self.lowestNumber-1]
                self.lowestNumberPicker.selectRow(self.lowestNumber-1, inComponent: 0, animated: true)
                self.endingNumberPicker.selectRow(self.highestNumber-1, inComponent: 0, animated: true)
                
            }else if(self.lowestNumber >= self.highestNumber){
                self.lowestNumber = self.highestNumber - 1
                //print(lowestNumber)
                //print(highestNumber)
                self.lowestNumberLabel.text = self.pickerDataSource[self.lowestNumber-1]
                self.lowestNumberPicker.selectRow(self.lowestNumber-1, inComponent: 0, animated: true)
            }
            
            
            
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.row){
        case (1):
            if isPicker1Shown{
                return 216.0
            }else{
                return 0.0
            }
        case (3):
            if isPicker2Shown{
                return 216.0
            }else{
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    var isPicker2Shown: Bool = false {
        didSet{
            lowestNumberPicker.isHidden = !lowestNumberPicker.isHidden
        }
    }
    
    var isPicker1Shown: Bool = false {
        didSet{
            endingNumberPicker.isHidden = !endingNumberPicker.isHidden
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch(indexPath.row){
        case (0):
            if isPicker1Shown{
                isPicker1Shown = false
            }else if isPicker2Shown {
                isPicker2Shown = false
                isPicker1Shown = true
            }else{
                isPicker1Shown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case (2):
            if isPicker2Shown{
                isPicker2Shown = false
            }else if isPicker1Shown {
                isPicker1Shown = false
                isPicker2Shown = true
            }else{
                isPicker2Shown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 2...1000 {
            pickerDataSource.append("\(index)")
        }
        
        self.lowestNumberPicker.dataSource = self
        self.lowestNumberPicker.delegate = self
        
        self.endingNumberPicker.dataSource = self
        self.endingNumberPicker.delegate = self
        
        self.lowestNumberPicker.selectRow(24, inComponent: 0, animated: true)
        self.endingNumberPicker.selectRow(74, inComponent: 0, animated: true)
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
