//
//  MAKUserDefaultExtension.swift
//  DataPersistance
//
//  Created by Afnan Khan on 3/6/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import Foundation


extension UserDefaults {
    
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}


class MAKUserDefault {
    
    class var sharedInstance : MAKUserDefault {
        struct Singleton {
            static let instance = MAKUserDefault()
        }
        return Singleton.instance
    }
    
    var userName: String? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    
    var userId: Int {
        get {
            return UserDefaults.standard[#function] ?? 0
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    var dateOfBirth : Date {
        get {
            return UserDefaults.standard[#function] ?? Date()
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
}
