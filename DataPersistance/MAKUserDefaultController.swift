//
//  MAKUserDefaultController.swift
//  DataPersistance
//
//  Created by Afnan Khan on 3/6/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import UIKit

class MAKUserDefaultController: UIViewController {
    
    @IBOutlet weak var userNameTextField :  UITextField!
    @IBOutlet weak var userIdTextField :    UITextField!
    @IBOutlet weak var dobTextField :       UITextField!
    
    @IBOutlet weak var userNameLabel :       UILabel!
    @IBOutlet weak var userIdLabel :       UILabel!
    @IBOutlet weak var dateOfBirthLabel :       UILabel!
    
    
    
    var datePicker: UIDatePicker!
    var selectedData : Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePickerView()
        // Do any additional setup after loading the view.
    }
    
    
    func configureDatePickerView() {
        datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.date = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerDateDidChange(_:)), for: .valueChanged)
        selectedData =   datePicker.date
        dobTextField.inputView = datePicker
    }
    
    @objc func datePickerDateDidChange(_ datePicker: UIDatePicker) {
        let dateString = String().getStringFromDate(datePicker.date)
        dobTextField.text = dateString
        selectedData = datePicker.date
    }
    
    @IBAction func saveDataButtonClicked(_ sender: Any) {
        MAKUserDefault.sharedInstance.userName = userNameTextField.text
        MAKUserDefault.sharedInstance.userId = (Int)(userIdTextField.text ?? "" ) ?? -1
        MAKUserDefault.sharedInstance.dateOfBirth = selectedData ?? Date()
        
    }
    
    @IBAction func getDataButtonClicked(_ sender: Any) {
        userNameLabel.text =   MAKUserDefault.sharedInstance.userName
        userIdLabel.text =   "\(MAKUserDefault.sharedInstance.userId)"
        dateOfBirthLabel.text =   "\(MAKUserDefault.sharedInstance.dateOfBirth)"
        
        
    }
    
    
}



extension String {
    /** Date format 120-01-2017 **/
    func getStringFromDate(_ givenDate : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let dateString = formatter.string(from: givenDate)
        return dateString
    }
    
}
