//
//  MAKCoreDataController.swift
//  DataPersistance
//
//  Created by Afnan Khan on 3/8/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class MAKCoreDataController: UIViewController {
    
    let FTABLE_NAME = "Users"
    let FUSER_NAME = "username"
    let FUSER_ID = "userid"
    let FDATE_OF_BIRTH = "dateofbirth"



    
    //MARK: IbOutlets

    @IBOutlet weak var userNameTextField :  UITextField!
    @IBOutlet weak var userIdTextField :    UITextField!
    @IBOutlet weak var dobTextField :       UITextField!
    
    @IBOutlet weak var userNameLabel :       UILabel!
    @IBOutlet weak var userIdLabel :         UILabel!
    @IBOutlet weak var dateOfBirthLabel :    UILabel!
    
    
    //MARK: Variables
    var datePicker: UIDatePicker!
    var selectedData : Date?
    
    
    //MARK: Application life cycle

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
        saveDataInCoreData()
    }
    
    @IBAction func showDataButtonClicked(_ sender: Any) {
        getDataFromCoreData()
    }
    
    
    func saveDataInCoreData(){
        
        if validateData() != nil{ return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let entity = NSEntityDescription.entity(forEntityName: FTABLE_NAME, in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        // Save user data in local
        newUser.setValue(userNameTextField.text, forKey: FUSER_NAME)
        newUser.setValue((Int)(userIdTextField.text! ), forKey: FUSER_ID)
        newUser.setValue(selectedData!, forKey: FDATE_OF_BIRTH)
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    
    func validateData() -> String?{
        if userNameTextField.text?.count == 0 || userIdTextField.text?.count == 0 ||  dobTextField.text?.count == 0{
            return "Insert all data"
        }
         return nil
    }
    func getDataFromCoreData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: FTABLE_NAME)
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                userNameLabel.text = (data.value(forKey: FUSER_NAME) as? String)
                userIdLabel.text  = "\(data.value(forKey: FUSER_ID) as? Int ?? 0)"
                dateOfBirthLabel.text  = String().getStringFromDate(data.value(forKey: FDATE_OF_BIRTH) as? Date ?? Date())
                
              }
            
 
        } catch {
            
            print("Failed")
        }
    }
    
    
}


