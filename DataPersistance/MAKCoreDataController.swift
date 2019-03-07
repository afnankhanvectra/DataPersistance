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
    
    let TABLE_NAME = "Users"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveDataButtonClicked(_ sender: Any) {
        saveDataInCoreData()
    }
    
    @IBAction func showDataButtonClicked(_ sender: Any) {
        getDataFromCoreData()
    }
    
    
    func saveDataInCoreData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let entity = NSEntityDescription.entity(forEntityName: TABLE_NAME, in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        // Save user data in local
        newUser.setValue("Afnan", forKey: "username")
        newUser.setValue(10, forKey: "userid")
        newUser.setValue(Date(), forKey: "dateofbirth")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    func getDataFromCoreData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // We need to create a context from this container.
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE_NAME)
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
}
