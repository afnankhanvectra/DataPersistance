//
//  ViewController.swift
//  DataPersistance
//
//  Created by Afnan Khan on 3/6/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    enum dataOption: String, CaseIterable {
        case  userDefault = "UserDefault"
        case  keychainSharing = "KeyChainSharing"
        case  coreData = "CoreData"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    
}
//MARK: Table View
extension ViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let simpleID = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: simpleID)
        cell?.textLabel?.text =  dataOption.allCases[indexPath.row].rawValue
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var controller : UIViewController?
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        if indexPath.row ==  0 {
            controller = (storyboard.instantiateViewController(withIdentifier: "MAKUserDefaultController"))
        }
        else if indexPath.row ==  1 {
            controller = (storyboard.instantiateViewController(withIdentifier: "MAKKeyChainController"))
        }else  {
                controller = (storyboard.instantiateViewController(withIdentifier: "MAKCoreDataController"))
            }
            self.navigationController?.pushViewController(controller!, animated: true)
            
        }
        
    
        
}
