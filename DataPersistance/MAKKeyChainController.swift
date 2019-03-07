//
//  MAKKeyChainController.swift
//  DataPersistance
//
//  Created by Afnan Khan on 3/7/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import UIKit

class MAKKeyChainController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var dataTextFeild:   UITextField!
    @IBOutlet weak var saveDataButton:  UIButton!
    @IBOutlet weak var showDataButton:  UIButton!
    @IBOutlet weak var showDataLabel:   UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveDataButtonClicked(_ sender: Any) {
        authenticationToken = dataTextFeild.text
    }
    
    @IBAction func showDataButtonClicked(_ sender: Any) {
        showDataLabel.text = authenticationToken
    }
    
    
    var authenticationToken: String? {
        get {
            if let receivedData = KeyChain.load(key: #function) {
                return receivedData.to(type: String.self)
            }
            return nil
        }
        set {
            let data = Data(from: newValue)
            let result = KeyChain.save(key: #function, data: data)
            print("result: ", result)
        }
    }
    
    
    
}
